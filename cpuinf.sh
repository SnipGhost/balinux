#!/bin/bash
#----------------------------------------------------------------------
# Test filename var
#----------------------------------------------------------------------
if [ -z $1 ]
then
	BASEDIR=`dirname $0`
	DIRPATH=`cd $BASEDIR; pwd`
    f=$DIRPATH/data/`date +%Y.%m.%d_%H:%M:%S_cpuinf`
else
    f="$1"
fi
#----------------------------------------------------------------------
# CPU info (cpuinf)
#----------------------------------------------------------------------
printf "<table border=\"1\">" > $f
iostat | tail -n +3 | head -n 2 | sed -e 's/avg-cpu: //g' |           \
awk -v LIM1=20 -v LIM2=60                                             \
'{ split($0, k);                                                      \
   print "<tr>";                                                      \
   { for (i = 1; i <= 6; i++)                                         \
     {                                                                \
     print "<td>";                                                    \
     ks = substr(k[i], 0, 1);                                         \
     { if (ks != "%")                                                 \
       { if (k[i] > LIM1)                                             \
         { if (k[i] > LIM2)                                           \
           k[i] = "<span style=\"color: red;\">"k[i]"</span>";        \
         else k[i] = "<span style=\"color: orange;\">"k[i]"</span>" } \
       else k[i] = "<span style=\"color: green;\">"k[i]"</span>" } }  \
     print k[i]"</td>";                                               \
     }                                                                \
   }                                                                  \
   print "</tr>"; }' >> $f
printf "</table>\n" >> $f
#----------------------------------------------------------------------