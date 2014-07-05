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

export LANG=en_US
cat <<EOF > $TMP.awk
BEGIN{
    OFMT="%10.5f"
    dlist[1]=40
    dname[1]="1x40 mm"
    dlist[2]=50
    dname[2]="1x50 mm"
    dlist[3]=70
    dname[3]="1x70 mm"
    dlist[4]=100
    dname[4]="1x100 mm"
    dlist[5]=141
    dname[5]="2x100 mm"
    dlist[6]=173
    dname[6]="3x100 mm"
    dlist[7]=200
    dname[7]="4x100 mm"
    dlist[8]=224
    dname[8]="5x100 mm"
    dlist[9]=245
    dname[9]="6x100 mm"
    dimax=9    

    #rpara[1]=0;
    #rpara[2]=1.0;
    #rpara[3]=1.5;
    #rpara[4]=2.2;
    #rpara[5]=3.3;
    #rpara[6]=4.7;
    #rpara[7]=6.8;
    #rpara[8]=10;
    #rpara[9]=15;
    #rpara[10]=22;
    #rpara[11]=33;
    #rpara[12]=47;
    #rpara[13]=68;
    #rpara[14]=100;
    #rpara[15]=150;
    #rpara[16]=9999;
    #rparamax=16;

    rpara[1]=0;
    rpara[2]=2.7;
    rpara[3]=6.8;
    rpara[4]=100000;
    rparamax=4;

    lmin=20
    lmax=800

    lemin = 1.0;
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
        if( nvc * le1 >= lemin ) {
            dwunsch = sqrt( sd / 5 ) * 10;
            for(diwunsch=1;diwunsch<=dimax;diwunsch++) {
               if( dwunsch < dlist[diwunsch] )
                   break;
            }
            d  = dlist[diwunsch];
        
            r=0.2;
            qes1 = qes * ( re + r ) / re;
            bl   = sqrt( 2 * 3.1416 * fs * mms * (re1/2) / qes );
            rms  = 2 * 3.1416 * fs * mms / qms;
            pmax1 = 0.75 * pmax;
            printf("*****************************************************************************\n");
            for( i=1; i<=rparamax; i++ ) {
                rp=rpara[i];
                rms2 = bl * bl / ( re1 + rp );
                rmt  = rms + rms2;
                qms1 = 2 * 3.1416 * fs * mms / rmt;
                qts1=1/((1/qms1)+(1/qes1))
                printf("%s || %6.1fOhm %5.2f %5.1fdB %4.0fW %8s\n", name, rp, qts1, spl, pmax1, dname[diwunsch] );
                printf(" fu     fc      fo      SplMech  Vb1     Vb2       d         l        C");
                printf("\n");
                 
                fs43   = exp( -4 / 3 * log( fs   ));
                qts123 = exp( -2 / 3 * log( qts1 ));
                vb2 = 2 * vas * qts1 * qts1;

                # vb1 unendlich: 
                # 1 == 1.84 * qts123 * fs43 * fu43
                fu43 = 1 / 1.84 / qts123 / fs43;
                fu = exp( 3 / 4 * log( fu43 ));
                cs   = 145000 / ( re * fs * qts1 );
                
                for(di=1;di<=dimax;di++) {
                   if( dwunsch < dlist[di] )
                       break;
                }
                d  = dlist[di];
                l  = 2340 * d * d / (fs*fs*vb2  ) - 0.8 * d;
                dkorr=" "
                if( l > lmax && di > 1 ) {
                    di--;
                    d = dlist[di];
                    l = 2340 * d * d / (fs*fs*vb2  ) - 0.8 * d;
                    dkorr="-"
                    if( l > lmax ) {
                        di--;
                        d = dlist[di];
                        l = 2340 * d * d / (fs*fs*vb2  ) - 0.8 * d;
                        dkorr="*"
                    }
                }
                while( l < lmin && di < dimax ) {
                    di++;
                    d = dlist[di];
                    l = 2340 * d * d / (fs*fs*vb2  ) - 0.8 * d;
                    dkorr="+"
                }
                
                fc = fs;
                fo = fc * fc / fu;
                
                vd = sd * 2 * xmax / 10;
                spl2 = 20 * log( 0.37 * fu * fu * vd ) / log(10);
                
                printf("%5.1f Hz %3.0f Hz %4.0f Hz %6.1f dB   oo l +%4.0f l  %1s %-8s %4.0f mm %5.0f uF\n",
                        fu,fc,fo,spl2,vb2,dkorr,dname[di],l,cs);
                
                for( fu=sprintf("%3.0f", fu + 0.51 ); fu<=18; fu++ ) {
                
                    fu43 = exp(  4 / 3 * log( fu   ));
                    vb1  = vas / ( 1.84 * qts123 * fu43 * fs43 - 1 );
                    cs   = 145000 / ( re * fs * qts1 * ( vas/vb1 +1 ));
                
                    for(di=1;di<=dimax;di++) {
                       if( dwunsch < dlist[di] )
                           break;
                    }
                    d  = dlist[di];
                    l  = 2340 * d * d / (fs*fs*(vas/vb1+1)*vb2  ) - 0.8 * d;
                    dkorr=" "
                    if( l > lmax && di > 1 ) {
                        di--;
                        d = dlist[di];
                        l = 2340 * d * d / (fs*fs*(vas/vb1+1)*vb2  ) - 0.8 * d;
                        dkorr="-"
                        if( l > lmax ) {
                            di--;
                            d = dlist[di];
                            l = 2340 * d * d / (fs*fs*(vas/vb1+1)*vb2  ) - 0.8 * d;
                            dkorr="*"
                            if( l > lmax ) {
                                continue;
                            }
                        }
                    }
                    while( l < lmin && di < dimax ) {
                        di++;
                        d = dlist[di];
                        l = 2340 * d * d / (fs*fs*(vas/vb1+1)*vb2  ) - 0.8 * d;
                        dkorr="+"
                    }
                
                    fc = fs * sqrt( vas/vb1 + 1 );
                    fo = fc * fc / fu;
                
                    vd = sd * 2 * xmax / 10;
                    spl2 = 20 * log( 0.37 * fu * fu * vd ) / log(10);
                
                    printf("%5.1f Hz %3.0f Hz %4.0f Hz %6.1f dB %4.0f l +%4.0f l  %1s %-8s %4.0f mm %5.0f uF\n",
                            fu,fc,fo,spl2,vb1,vb2,dkorr,dname[di],l,cs);
                }
                printf("\n");
            }
        }
    }
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT
if [ ! -s "$OUT" ] ; then
    rm $OUT
fi
rm $TMP.* 

