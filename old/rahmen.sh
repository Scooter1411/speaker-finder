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
<<<<<<< HEAD
            echo $J
            ./$I $J > /dev/null &
=======
            nice ./$I $J > /dev/null &
            TOSLEEP=`uptime|awk '{print $8}'|sed -e's/,//g'`
            echo $TOSLEEP '  ' $J
            sleep $TOSLEEP
>>>>>>> 31a21eb335dfb7b03323bd9498ef71be639a1d9b
          done
    fi
  done

for I in *.out
  do
    if [ ! -s $I ] ; then
        rm -f $I
    fi
  done
