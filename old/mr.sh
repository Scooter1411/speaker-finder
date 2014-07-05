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
rm -f $TMP* export LANG=en_US

if [ -f "$1" ] ; then
    IN=$1
else
    IN=in.in
fi
if [ ! -f "$IN" ] ; then
    echo "Keine Eingabe"
fi
OUT=`basename $IN .in`.$BASE.out


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

        printf("-------------\n%s\n",name);
        printf("     %5.1fdB           %4.0fW\n", spl, pmax );
        printf("Rpre   Spl     SplMech Pmech SplEle      f3\n");
        printf("\n");

        vd = sd * 2 * xmax / 10;

        for( r=0.2; r<=1.0; r+=0.4 ) {
        
            qes1 = 1.0 * qes * ( re + r ) / re;
            qts1=1/((1/qms)+(1/qes1))
            eff = 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1;
            spl1 = 112 + 10 * log( eff ) / log(10); 

	    qtc = 0.7;
            fc  = qtc /qts1 * fs;

            first = "true";

            for( f3=fc; f3<800; f3 *= 1.1892 ) {
                    
                spl2 = 20 * log( 0.37 * f3 * f3 * vd ) / log(10);            
                p2   = p0 * exp(( spl2 - spl1)/10*log(10));
                spl3 = spl1 + 10 * log( pmax / p0 ) / log(10);
        
                if( p2 < pmax * 10 || first == "true" ) {
                    if( first == "true" ) {
                        printf("%4.2f %5.1fdB:",r,spl1);
                        first = "false";
                    } else {
                        printf("             ");
                    }
                    printf(" (%5.1fdB %5.0fW %5.1fdB) @%4.0fHz\n",spl2,p2,spl3,f3);
                }
            }
        }
     }
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT

