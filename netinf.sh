#!/bin/bash
#----------------------------------------------------------------------
# Test filename var
#----------------------------------------------------------------------
if [ -z $1 ]
then
	BASEDIR=`dirname $0`
	DIRPATH=`cd $BASEDIR; pwd`
    f=$DIRPATH/data/curr_netinf
    l=$DIRPATH/data/last_netinf
else
    f="$1"
fi
#--------------------------------------------------------------------------------------------------
# Print net info
#--------------------------------------------------------------------------------------------------
if [ -z $l ]
	$f > $l
fi
#--------------------------------------------------------------------------------------------------
printf "<table border=\"1\">\n" > $f
(sudo cat /proc/net/dev | head -n 1 | sed 's/Inter-|/IF /g' | sed -e 's/|/_ _ _ _ _ _ _ /g'; \
 sudo cat /proc/net/dev | tail -n +2 | sed -e 's/face/\_/g' | sed -e 's/|/ /g')              \
 | column -t | sed -e 's/_/ /g' | awk \
'{ split($0, k)
   getline line < FILE;
   print "<tr>";
   { if (NR == 1) 
     { print "<td rowspan=\"2\">"k[1]"</td><td colspan=\"8\">"k[2]"</td><td colspan=\"8\">"k[3]"</td>"; }
   else
     { if (NR == 2) { for (i = 1; i <= 16; i++) print "<td>"k[i]"</td>"; }
       else { for (i = 1; i <= 17; i++) print "<td>"k[i]"</td>"; }
     }
   }
 }' >> $f
printf "\n</table>\n" >> $f
#--------------------------------------------------------------------------------------------------