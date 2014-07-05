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
    rpara[1]=0;
    rpara[2]=1.0;
    rpara[3]=1.5;
    rpara[4]=2.2;
    rpara[5]=3.3;
    rpara[6]=4.7;
    rpara[7]=6.8;
    rpara[8]=10;
    rpara[9]=15;
    rpara[10]=22;
    rpara[11]=33;
    rpara[12]=47;
    rpara[13]=68;
    rpara[14]=100;
    rpara[15]=150;
    rpara[16]=9999;
    rparamax=16;
    CONVFMT="%8.2f";
    OFMT="%8.2f";
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
    if( nvc == 1 ) {
        # Keine Güteänderung 
        #p0= 2.83 * 2.83 / re;
        p0=1
        r = 0.2;
        qes1=qes * ( re + r ) / re;
        qts1=1/((1/qms)+(1/qes1))
        if( qts1 >= 0.5 ) {
            printf("-------------\n%s\n",name);
            printf("                   %5.1fdB          %4.0fW\n", spl, pmax );
            printf("         qts   f3   Spl     SplMech Pmech  SplEle  ");
            printf("\n");

            fc  = fs;
            qtc = qts1;

            if( qtc < 0.525 ) {
                f3 = 1.45 * fs
            } else if ( qtc < 0.55 ) {
                f3 = 1.35 * fs 
            } else if ( qtc < 0.575 ) {
                f3 = 1.29 * fs 
            } else if ( qtc < 0.60 ) {
                f3 = 1.24 * fs 
            } else if ( qtc < 0.65 ) {
                f3 = 1.14 * fs 
            } else if ( qtc < 0.7 ) {
                f3 = 1.05 * fs 
            } else if ( qtc < 0.75 ) {
                f3 = 0.98 * fs 
            } else if ( qtc < 0.8 ) {
                f3 = 0.93 * fs 
            } else if ( qtc < 0.85 ) {
                f3 = 0.88 * fs 
            } else if ( qtc < 0.9 ) {
                f3 = 0.85 * fs 
            } else if ( qtc < 0.95 ) {
                f3 = 0.81 * fs 
            } else if ( qtc < 1.0 ) {
                f3 = 0.79 * fs 
            } else if ( qtc < 1.05 ) {
                f3 = 0.77 * fs
            } else {
                f3 = 0.75 * fs 
            } 
    
            eff = 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1;
            spl1 = 112 + 10 * log( eff ) / log(10); 
            
            vd = sd * 2 * xmax / 10;
            spl2 = 20 * log( 0.37 * f3 * f3 * vd ) / log(10);
            
            p2 = p0 * exp(( spl2 - spl1)/10*log(10));
            spl3 = spl1 + 10 * log( pmax / p0 ) / log(10);
            
            printf("       %5.2f %3.0fHz %5.1fdB  %5.1fdB %4.0fW  %5.1fdB\n",qts1,f3,spl1,spl2,p2,spl3);
        }
    } else if( nvc == 2 && mms > 0 ) {
        # Güteänderung 
        p0=1
        r = 0.2;
#print qes
        bl   = sqrt( 2 * 3.1416 * fs * mms * (re1/2) / qes );
#print bl
        qes0 = 2 * 3.1416 * fs * mms * re1 / ( bl * bl );
#print qes0
        qes1=qes0 * ( re1 + r ) / re1;
#print qes1
        pmax1 = 0.75 * pmax;

        qts1=1/((1/qms)+(1/qes1))
        if( qts1 >= 0.5 ) {
            printf("-------------\n%s\n",name);
            printf("                   %5.1fdB          %4.0fW\n", spl, pmax1 );
            printf("  R||    qts   f3   Spl     SplMech Pmech  SplEle  ");
            printf("\n");
        }
        for( i=1; i<=rparamax; i++ ) {
            rp=rpara[i];

            rms  = 2 * 3.1416 * fs * mms / qms;
            rms2 = bl * bl / ( re1 + rp );
            rmt  = rms + rms2;
            qms1 = 2 * 3.1416 * fs * mms / rmt;
            qts1=1/((1/qms1)+(1/qes1))
#print rp " " qts1
            if( qts1 >= 0.5 ) {
                fc  = fs;
                qtc = qts1;

                if( qtc < 0.525 ) {
                    f3 = 1.45 * fs
                } else if ( qtc < 0.55 ) {
                    f3 = 1.35 * fs 
                } else if ( qtc < 0.575 ) {
                    f3 = 1.29 * fs 
                } else if ( qtc < 0.60 ) {
                    f3 = 1.24 * fs 
                } else if ( qtc < 0.65 ) {
                    f3 = 1.14 * fs 
                } else if ( qtc < 0.7 ) {
                    f3 = 1.05 * fs 
                } else if ( qtc < 0.75 ) {
                    f3 = 0.98 * fs 
                } else if ( qtc < 0.8 ) {
                    f3 = 0.93 * fs 
                } else if ( qtc < 0.85 ) {
                    f3 = 0.88 * fs 
                } else if ( qtc < 0.9 ) {
                    f3 = 0.85 * fs 
                } else if ( qtc < 0.95 ) {
                    f3 = 0.81 * fs 
                } else if ( qtc < 1.0 ) {
                    f3 = 0.79 * fs 
                } else if ( qtc < 1.05 ) {
                    f3 = 0.77 * fs
                } else {
                    f3 = 0.75 * fs 
                } 
    
                eff = 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1;
                spl1 = 112 + 10 * log( eff ) / log(10); 
                
                vd = sd * 2 * xmax / 10;
                spl2 = 20 * log( 0.37 * f3 * f3 * vd ) / log(10);
                
                p2 = p0 * exp(( spl2 - spl1)/10*log(10));
                spl3 = spl1 + 10 * log( pmax1 / p0 ) / log(10);
                
                printf("%6.1f %5.2f %3.0fHz %5.1fdB  %5.1fdB %4.0fW  %5.1fdB\n",rp,qts1,f3,spl1,spl2,p2,spl3);
            }
        }
    }
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT

