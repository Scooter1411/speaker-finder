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
    dname[1]="1x40mm"
    dlist[2]=50
    dname[2]="1x50mm"
    dlist[3]=70
    dname[3]="1x70mm"
    dlist[4]=100
    dname[4]="1x100mm"
    dlist[5]=141
    dname[5]="2x100mm"
    dlist[6]=173
    dname[6]="3x100mm"
    dlist[7]=200
    dname[7]="4x100mm"
    dlist[8]=224
    dname[8]="5x100mm"
    dlist[9]=245
    dname[9]="6x100mm"
    dimax=9    

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
    if( nvc < 2 ) {
       re = re1;
        if( nvc * le1 >= lemin ) {
            dwunsch = sqrt( sd / 5 ) * 10;
            for(di=1;di<=dimax;di++) {
               if( dwunsch < dlist[di] )
                   break;
            }
            d  = dlist[di];
        
            printf("-------------\n%s\n",name);
            printf("           %5.1fdB          %4.0fW     %8s\n", spl, pmax, dname[di] );
            printf("   fu     fc      fo      SplMech  Vb1     Vb2       d         l        C");
            printf("\n");
            r=0.2;
        
            qes1 = qes * ( re + r ) / re;
            qts1=1/((1/qms)+(1/qes1))
            qts123 = exp( -2 / 3 * log( qts1 ));
            fs43   = exp( -4 / 3 * log( fs   ));
            vb2 = 2 * vas * qts * qts;
        
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
            
            printf("%5.1f Hz %3.0f Hz %4.0f Hz %6.1f dB   oo l +%4.0f l  %1s %-8s %4.0f mm %5.0f µF\n",
                    fu,fc,fo,spl2,vb2,dkorr,dname[di],l,cs);
                    
            for( fu=sprintf("%3.0f", fu + 0.51 ); fu<=30; fu++ ) {
        
                fu43   = exp(  4 / 3 * log( fu   ));
                vb1 = vas / ( 1.84 * qts123 * fu43 * fs43 - 1 );
                cs = 145000 / ( re * fs * qts1 * ( vas/vb1 +1 ));
        
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
                        l = 2340 * d * d / (fs*fs*vb2  ) - 0.8 * d;
                        dkorr="*"
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
        
                printf("%5.1f Hz %3.0f Hz %4.0f Hz %6.1f dB %4.0f l +%4.0f l  %1s %-8s %4.0f mm %5.0f µF\n",
                        fu,fc,fo,spl2,vb1,vb2,dkorr,dname[di],l,cs);
            }
            printf("\n");
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
