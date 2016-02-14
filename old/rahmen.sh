#!/bin/sh
#################################
# Rahmensteuerung
#################################
BASE=`basename $0 .sh`
rm -f /tmp/$BASE.*
TMP=/tmp/$BASE.$$

for I in *.sh
  do
    echo '******************  ' $I
    if [ ! "$I" = "rahmen.sh" ] ; then
        for J in *.in
          do
            nice ./$I $J > /dev/null &
            TOSLEEP=`uptime|awk '{print $10}'|sed -e's/,//g'`
            echo $TOSLEEP '  ' $J
            sleep $TOSLEEP
          done
    fi
  done

for I in *.out
  do
    if [ ! -s $I ] ; then
        rm -f $I
    fi
  done
