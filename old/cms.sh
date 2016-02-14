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
rm -f $TMP*export LANG=en_US

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
    printf( "                       fs   mms    cms    cms1   cms2   cms     mms2\n");
}
{
    name=\$1
    vas=\$2
    #gsub("\\\\.",",",vas);
#print vas
    qts=\$3
    qes=\$4
    qms=\$5
    fs=\$6
    #gsub("\\\\.",",",fs);
    mms=\$7
    #gsub("\\\\.",",",mms);
    cms=\$8;
    #gsub("\\\\.",",",cms);
    nvc=\$9
    re1=\$10
    le1=\$11
    sd=\$12
    gsub("\\\\.",",",sd);
#print sd
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
    printf( "%-20s %5.1f %6.1f", name, fs, mms * 1.0);
    if( cms > 1 ) {
        printf( " %5.2f ", cms );
    } else {
        printf( " %6.3f", cms );
    }

#print " "
#print "XXX " sd
#print "YYY " 331^2 * cms * 1000 * ((sd / 10000)^2)
#print "ZZZ " vas / 1000 / (331^2 * cms * 1000 * ((sd / 10000)^2))
#print " "   
       #cms1 = vas * 100 / ( 2 * 3.1416 * fs * (331^2) * ((sd / 10000)^2));
       cms1 = 1000 * vas / ( 1180 * (340^2) * ((sd / 10000)^2));
#print " "
#print 2 * 3.1416 * fs

        if( cms1 > 1 ) {
            printf( " %5.2f ", cms1 );
        } else {
            printf( " %6.3f", cms1 );
        }
        if( mms > 0 ) {
            cms2 = 1 / ( ( 2 * 3.1416 * fs ) ^ 2 * mms ) * 1000000;
        } else {
            cms2 = 0.0;
        }

        if( cms2 > 1 ) {
            printf( " %5.2f ", cms2 );
        } else {
            printf( " %6.3f", cms2 );
        }
        cms3 = ( cms1 + cms2 ) / 2;

        if( cms3 > 1 ) {
            printf( " %5.2f ", cms3 );
        } else {
            printf( " %6.3f", cms3 );
        }

        mms2 = 1 / ( ( 2 * 3.1416 * fs ) ^ 2 * cms1 ) * 1000000;
        printf( " %6.1f ", mms2 );

    printf( "\n" );
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT

