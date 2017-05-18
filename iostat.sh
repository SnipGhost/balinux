#!/bin/bash
#----------------------------------------------------------------------
# Test filename var
#----------------------------------------------------------------------
if [ -z $1 ]
then
	BASEDIR=`dirname $0`
	DIRPATH=`cd $BASEDIR; pwd`
    f=$DIRPATH/data/`date +%Y.%m.%d_%H:%M:%S_iostat`
else
    f="$1"
fi
#----------------------------------------------------------------------
# Disk load (iostat)
#----------------------------------------------------------------------
printf "<table border=\"1\">\n" > $f
iostat >> /dev/null
iostat | tail -n +6 | head -n 4 | awk                                 \
'{ split($0, k);                                                      \
   print "<tr>";                                                      \
   { for (i = 1; i <= 6; i++) print "<td>"k[i]"</td>"; }              \
   print "</tr>"; }' >> $f
printf "\n</table>\n" >> $f
#----------------------------------------------------------------------
