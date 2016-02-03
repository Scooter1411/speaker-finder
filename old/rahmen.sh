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
            echo $J
            ./$I $J > /dev/null &
          done
    fi
  done

for I in *.out
  do
    if [ ! -s $I ] ; then
        rm -f $I
    fi
  done
