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
    lmax=700
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
    if( qts > 0 && qts < 0.66 ) {
        p0= 2.83 * 2.83 / re;
        #p0=1;
        dwunsch = sqrt( sd / 5 ) * 10;
        for(di=1;di<=dimax;di++) {
           if( dwunsch < dlist[di] )
               break;
        }
        d  = dlist[di];

        printf("-------------\n%-37s %5.1fdB %4.0fW                    %8s\n",name, spl, pmax, dname[di]);
        printf("Rpre   Spl\n      Vb      fb         SplMech Pmech  SplEle     f3       dv       lv\n");
        printf("\n");

        vd = sd * 2 * xmax / 10;

        for( r=0.2; r<=1.0; r+=0.4 ) {
        
            qes1 = qes * ( re + r ) / re;
            qts1=1/((1/qms)+(1/qes1))
			vb = 15 * vas * ( qts1  ^ 2.87 );
            f3 = 0.26 * fs / ( qts1 ^ 1.4 );
            fb = 0.42 * fs / ( qts1 ^ 0.9 );

            eff = 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1;
            spl1 = 112 + 10 * log( eff ) / log(10); 

            #printf("%4.2f ",r);
            #printf("%4.2f %5.1fl@%4.1fHz=> %4.1fHz ",r,vb,fb,f3);
            
            first = "true";
            if( sd > 400 && r < 0.3 ) {
                # LLT subs
                vmax = vas / vb * ( ( fs / 10 ) ^3 )
            } else {
                vmax = 1.41
            }
            for( vx=0.7; vx<=vmax; vx *= 1.12 ) {

                if( (vx - 1.0) ^ 2  < 0.0016) 
                    mark = "*";
                else 
                    mark = " ";
                vbx  = vb * vx;
                f3x  = fs * ( vas / vbx ) ^ 0.5;
                fbx  = fs * ( vas / vbx ) ^ 0.32;                
                spl2 = ( 20 * log( 0.37 * f3x * f3x * vd ) / log(10) ) + 4;
                p2   = p0 * exp(( spl2 - spl1)/10*log(10));
                spl3 = spl1 + 10 * log( pmax / p0 ) / log(10);

                for(di=1;di<=dimax;di++) {
                   if( dwunsch < dlist[di] )
                       break;
                }
                d  = dlist[di];
                sv = 3.1416 / 4 * ( d / 10 ) ^ 2;
                l  = (((10 * 343 ^2 * sv )/(4*3.1416^2*fs^2*vbx)) - 0.825 * ( sv ^ 0.5 ))*10;
                dkorr=" "
                if( l > lmax && di > 1 ) {
                    di--;
                    d = dlist[di];
                    sv = 3.1416 / 4 * ( d / 10 ) ^ 2;
                    l  = (((10 * 343 ^2 * sv )/(4*3.1416^2*fs^2*vbx)) - 0.825 * ( sv ^ 0.5 ))*10;
                    dkorr="-"
                    if( l > lmax ) {
                        continue;
                    }
                }
                while( l < lmin && di < dimax ) {
                    di++;
                    d = dlist[di];
                    sv = 3.1416 / 4 * ( d / 10 ) ^ 2;
                    l  = (((10 * 343 ^2 * sv )/(4*3.1416^2*fs^2*vbx)) - 0.825 * ( sv ^ 0.5 ))*10;
                    dkorr="+"
                }
    
                if( vbx > 0 && l >= lmin && l <= lmax ) {
                    if( first == "true" ) {
                        printf("%4.2f %5.1fdB --------------------------------------------------------------\n",r,spl1);
                        first = "false";
                    } #else {
                      #  printf("             ");
                    #}

                    printf("%1s %6.1fl @ %5.1fHz  =>  %5.1fdB %4.0fW %5.1fdB @ %5.1fHz ",mark,vbx,fbx,spl2,p2,spl3,f3x);
                    printf("%1s %-8s %4.0f mm \n",dkorr,dname[di],l);
                }
        
                #if( vb1 < 2000 && vb1 > 0 && l >= lmin && l <= lmax ) {
                #    printf("%3.0f Hz %3.0f Hz %4.0f Hz %6.1f dB %4.0f l +%4.0f l  %1s %-8s %4.0f mm %5.0f µF\n",
                #            fu,fc,fo,spl2,vb1,vb2,dkorr,dname[di],l,cs);
                #}
            }
            #printf("\n");
        }
    }
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT

