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
        printf("-------------\n%s\n",name);
        printf("     %5.1fdB                          %5.0fW\n", spl, pmax );
        printf("Rpre   Spl      qtc    Vb     SplMech Pmech SplEle      f3\n");
        printf("\n");

        vd = sd * 2 * xmax / 10;

        for( r=0.2; r<=1.0; r+=0.4 ) {
        
            qes1=qes * ( re + r ) / re;
            qts1=1/((1/qms)+(1/qes1))
            eff = 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1;
            spl1 = 112 + 10 * log( eff ) / log(10); 

            cs = 316000 * qts1 / re / fs;

            first = "true";
            for( qtc=0.5; qtc<=1.1; qtc+=0.1 ) {
                fc = qtc /qts1 * fs;
#print fc
                if( qtc < 0.525 ) {
                    f3 = 1.45 * fc
                } else if ( qtc < 0.55 ) {
                    f3 = 1.35 * fc 
                } else if ( qtc < 0.575 ) {
                    f3 = 1.29 * fc 
                } else if ( qtc < 0.60 ) {
                    f3 = 1.24 * fc 
                } else if ( qtc < 0.65 ) {
                    f3 = 1.14 * fc 
                } else if ( qtc < 0.7 ) {
                    f3 = 1.05 * fc 
                } else if ( qtc < 0.75 ) {
                    f3 = 0.98 * fc 
                } else if ( qtc < 0.8 ) {
                    f3 = 0.93 * fc 
                } else if ( qtc < 0.85 ) {
                    f3 = 0.88 * fc 
                } else if ( qtc < 0.9 ) {
                    f3 = 0.85 * fc 
                } else if ( qtc < 0.95 ) {
                    f3 = 0.81 * fc 
                } else if ( qtc < 1.0 ) {
                    f3 = 0.79 * fc 
                } else if ( qtc < 1.05 ) {
                    f3 = 0.77 * fc
                } else {
                    f3 = 0.75 * fc 
                } 
                    
                spl2 = 20 * log( 0.37 * f3 * f3 * vd ) / log(10);            
                p2   = p0 * exp(( spl2 - spl1)/10*log(10));
                spl3 = spl1 + 10 * log( pmax / p0 ) / log(10);
        
                vb   = vas / (((qtc^2)/(qts1^2))-1);

                if( vb > 0 && vb < 1000 ) {
                    if( first == "true" ) {
                        printf("%4.2f %5.1fdB:",r,spl1);
                        first = "false";
                    } else {
                        printf("             ");
                    }
                   if( qtc > 1.0 ) {
                       printf("%6.1f %6.1fl: (%5.1fdB %5.0fW %5.1fdB) @%4.0fHz\n",qtc,vb,spl2,p2,spl3,f3);
                       f3 = 0.7 / qts1 * fs;
                       spl2 = 20 * log( 0.37 * f3 * f3 * vd ) / log(10);            
                       p2   = p0 * exp(( spl2 - spl1)/10*log(10));
                       spl3 = spl1 + 10 * log( pmax / p0 ) / log(10);
                       printf("             %6.1f %6.1fl: (%5.1fdB %5.0fW %5.1fdB) @%4.0fHz (%5.0fuF)\n\n",qtc,vb,spl2,p2,spl3,f3,cs);
                   }else{
                       printf("%6.1f %6.1fl: (%5.1fdB %5.0fW %5.1fdB) @%4.0fHz\n",qtc,vb,spl2,p2,spl3,f3);
                   }
                } 
            }
        }
     }
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT
