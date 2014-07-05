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

cat <<EOF > $TMP.awk
BEGIN{
    printf( "                      fs     mms     qms        rms      rms/sd\n");
}
{
    name=\$1

    qms=\$5
    gsub("\\\\.",",",qms);

    fs=\$6
    gsub("\\\\.",",",fs);

    mms=\$7
    gsub("\\\\.",",",mms);

    sd=\$12
    gsub("\\\\.",",",sd);

    if( mms > 0 ){
        rms = 2 * 3.1415926 * fs * mms / qms / 1000;
        printf( "%-20s %5.1f %6.1f %8.3f %10.3f %10.5f\n", name, fs, mms, qms, rms, rms/sd );
    }
}
END{
}
EOF

grep -v \# $IN|grep .|awk -F, -f $TMP.awk|tee $OUT

