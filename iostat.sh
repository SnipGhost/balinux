#!/bin/bash
#----------------------------------------------------------------------
# Test filename var
#----------------------------------------------------------------------
if [ -z $1 ] || [ -z $2 ]
then
	BASEDIR=`dirname $0`
	DIRPATH=`cd $BASEDIR; pwd`
	f1=$DIRPATH/data/print_iostat
	f2=$DIRPATH/data/print_cpuinf
	tf=$DIRPATH/data/iostat_output
else
    f1="$1"
    f2="$2"
    tf="/tmp/iostat_output"
fi
#----------------------------------------------------------------------
iostat -k 25 2 > $tf
lines=`wc -l $tf | cut -d " " -f1`
#----------------------------------------------------------------------
# Disk load (iostat)
#----------------------------------------------------------------------
printf "<table border=\"1\">\n" > $f1
cat $tf | tail -n `expr $lines / 2` | tail -n +5 | head -n -1 | awk   \
'{ split($0, k);
   print "<tr>";
   { for (i = 1; i <= 14; i++) print "<td>"k[i]"</td>"; }
   print "</tr>"; }' >> $f1
printf "\n</table>\n" >> $f1
#----------------------------------------------------------------------
# CPU info (cpuinf)
#----------------------------------------------------------------------
printf "<table border=\"1\">" > $f2
cat $tf | tail -n `expr $lines / 2` | tail -n +2 | head -n 2 |        \
sed -e 's/avg-cpu: //g' | awk -v LIM1=20 -v LIM2=60                   \
'{ split($0, k);
   print "<tr>";
   { for (i = 1; i <= 6; i++)
     {
     if (i != 2) {
     print "<td>";
     ks = substr(k[i], 0, 1);
     { if (ks != "%") {
       { if (i == 1) k[i] = k[i]+k[i+1]; }
       { if (k[i] > LIM1)
         { if (k[i] > LIM2)
           k[i] = "<span style=\"color: red;\">"k[i]"</span>";
         else k[i] = "<span style=\"color: yellow;\">"k[i]"</span>" }
       else k[i] = "<span style=\"color: green;\">"k[i]"</span>" } }
     print k[i]"</td>";
   } } } }
   print "</tr>"; }' >> $f2
printf "</table>\n" >> $f2
#----------------------------------------------------------------------