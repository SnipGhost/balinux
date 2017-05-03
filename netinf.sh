#!/bin/bash
#-------------------
# Test filename var
#-------------------
if [ -z $1 ]
then
	BASEDIR=`dirname $0`
	DIRPATH=`cd $BASEDIR; pwd`
    f=$DIRPATH/data/`date +%Y.%m.%d_%H:%M:%S_netinf`
else
    f="$1"
fi
#-------------------
# Print net info
#-------------------
(sudo cat /proc/net/dev | head -n 1 | sed 's/Inter-|/IF /g' | sed -e 's/|/_ _ _ _ _ _ _ /g'; \
 sudo cat /proc/net/dev | tail -n +2 | sed -e 's/face/\_/g' | sed -e 's/|/ /g')              \
 | column -t | sed -e 's/_/ /g' > $f
 printf "\n" >> $f