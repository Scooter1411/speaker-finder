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
rm -f $TMP* 2>/dev/null
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
    printf( "                       fs    mms    cms    sag    pct\n");
}
{
    name=\$1
    vas=\$2
    gsub("\\\\.",",",vas);
#print vas
    qts=\$3
    qes=\$4
    qms=\$5
    fs=\$6
    gsub("\\\\.",",",fs);
    mms=\$7
    gsub("\\\\.",",",mms);
    #mms /= 1000;
    cms=\$8;
    gsub("\\\\.",",",cms);
    #cms /= 1000;
    nvc=\$9
    re1=\$10
    le1=\$11
    sd=\$12
    gsub("\\\\.",",",sd);
#print sd
    xmax=\$13
    gsub("\\\\.",",",xmax);
    spl=\$14
    pmax=\$15

    if( mms > 0 && xmax > 0 ){
        if( cms < 0.00001 ) {
            cms = 1 / ( ( 2 * 3.1416 * fs ) ^ 2 * mms ) * 1000;
        }
        printf( "%-20s %5.1f  %5.1f ", name, fs, mms);
        if( cms > 1 ) {
            printf( "%5.2f ", cms );
        } else {
            printf( "%6.3f", cms );
        }
        sag = cms * mms * 9.81 / 1000;
        printf( " %6.3f", sag );
        pct = (sag / xmax) * 100;
        printf( " %4.1f%%", pct );
        if( pct > 5 ) {
            printf(" Not OK\n");
        }else{
            printf(" OK\n");
        }
    }
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT

