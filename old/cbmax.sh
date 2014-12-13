#!/bin/sh
#################################
# 2 Ls => +  6 dB 
# 3 Ls => + 10 dB
# 6 Ls => + 16 dB
#################################
# 115 dB mit 2 Ls => 109 dB
# 115 dB mit 3 Ls => 105 dB
# 115 dB mit 6 Ls =>  99 dB
#################################
BASE=`basename $0 .sh`
TMP=/tmp/$BASE.$$
rm -f $TMP*
if [ -f "$1" ] ; then
    IN=$1
else
    IN=in.in
fi
if [ ! -f "$IN" ] ; then
    echo "Keine Eingabe"
fi
OUT=`basename $IN .in`.$BASE.out


export LANG=POSIX
cat <<EOF > $TMP.awk
BEGIN{
}
{
    name=\$1
    vas=\$2
    qts=\$3
    qes=\$4
    qms=\$5
    fs=\$6
    mms=\$7
    cms=\$8
    nvc=\$9
    re1=\$10
    le1=\$11
    sd=\$12
    xmax=\$13
    spl=\$14
    pmax=\$15
    if( nvc == 2 ) {
        if( re1 > 4 ) {
            re = re1 / 2; 
        } else {
            re = re1 * 2;
        }
    } else {
       re = re1;
    }
    if( pmax > 0 ) {

        p0= 2.83 * 2.83 / re;
        #p0=1;

        r=0.2
        
        vd = sd * 2 * xmax / 10;
        qes1=qes * ( re + r ) / re;
        qts1=1/((1/qms)+(1/qes1))
        eff = 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1;
        spl1 = 112 + 10 * log( eff ) / log(10); 
        fc = 0.7/qts1 * fs;
        f3x = 1.05 * fc
        qtc = 1.1
        vb   = vas / (((qtc^2)/(qts1^2))-1);

        pdiv = 64
        if( pmax < 160 ) pdiv = 32
        if( pmax <  80 ) pdiv = 16
        if( pmax <  40 ) pdiv = 8
        if( pmax <  20 ) pdiv = 4

        if( vb < 500 ){

            printf("-------------\n%s\n-------------\n",name);
            printf("%5.1fdB           %5.1fl (1.1)             %5.0fW\n", spl, vb, pmax );
            printf("SplMech  Pmech SplEle     f3\n");
            printf("\n");

            for( f3=16; f3<50; f3+=2 ) {
                    
                spl2 = 20 * log( 0.37 * f3 * f3 * vd ) / log(10);   
                splx = 12 / log(2) * log( f3x/f3 )
                if( splx < 20 ){
                    p2   = p0 * exp(( spl2 - spl1 + splx )/10*log(10));
                    spl3 = spl1 + 10 * log( pmax / p0 ) / log(10) - splx;
                    if(( f3 == 20 )||( f3 == 30 )){
                        for( px = pmax / pdiv; px <= pmax; px *= 1.2599 ) {
                                
                            spl3 = spl1 + 10 * log( px / p0 ) / log(10) - splx;
                            if( spl3 < spl2 )
                                printf("        %5.0fW %5.1fdB @%4.0fHz \n",px,spl3,f3);
                        }
                    }
                    printf("%5.1fdB %5.0fW %5.1fdB @%4.0fHz %4.0f\n",spl2,p2,spl3,f3,splx);
                }
            }
        }
    }
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT
