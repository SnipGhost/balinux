#!/bin/bash
#--------------------------------------------------------------------
# Test filename var
#--------------------------------------------------------------------
if [ -z $1 ]
then
    BASEDIR=`dirname $0`
    DIRPATH=`cd $BASEDIR; pwd`
    f=$DIRPATH/data/`date +%Y.%m.%d_%H:%M:%S_diskst`
else
    f="$1"
fi
#--------------------------------------------------------------------
f1="/tmp/disksinfo1"
f2="/tmp/disksinfo2"
#--------------------------------------------------------------------
df -a  | grep -v -E '( /run| /dev| /sys| /proc| /var)' > $f1
df -ai | grep -v -E '( /run| /dev| /sys| /proc| /var)' > $f2
#--------------------------------------------------------------------
# Disks info, free space, free inodes
#--------------------------------------------------------------------
printf "<table border=\"1\">\n" > $f
cat $f1 | awk -v FILE=$f2 -v LIM1=50 -v LIM2=90                     \
'{ print "<tr>";                                                    \
   getline line < FILE;                                             \
   split(line, s);                                                  \
   split($0, k);                                                    \
   { if (k[5] != "Use%")                                            \
     { if (k[5] > LIM1)                                             \
       { if (k[5] > LIM2)                                           \
         k[5]="<span style=\"color: red\">"k[5]"</span>";           \
       else k[5]="<span style=\"color: orange\">"k[5]"</span>"; }   \
     else k[5]="<span style=\"color: green\">"k[5]"</span>"; } }    \
   { if (s[5] != "IUse%")                                           \
     { if (s[5] > LIM1)                                             \
       { if (s[5] > LIM2)                                           \
         s[5]="<span style=\"color: red\">"s[5]"</span>";           \
       else s[5]="<span style=\"color: orange\">"s[5]"</span>"; }   \
     else s[5]="<span style=\"color: green\">"s[5]"</span>"; } }    \
   print "<tr><td>"k[1]"</td><td>"                                  \
                   k[2]"</td><td>"                                  \
                   k[3]"</td><td>"                                  \
                   k[4]"</td><td>"                                  \
                   k[5]"</td><td>"                                  \
                   s[2]"</td><td>"                                  \
                   s[3]"</td><td>"                                  \
                   s[4]"</td><td>"                                  \
                   s[5]"</td><td>"                                  \
                   s[6]"</td></tr>";                                \
}' >> $f
printf "\n</table>\n" >> $f
#--------------------------------------------------------------------