#!/bin/bash
#------------------------------------------------------------------------------
# Test timeout time
#------------------------------------------------------------------------------
if [ -z $2 ]
then
    t="29"
else
    t="$2"
fi
#------------------------------------------------------------------------------
# Test packs count
#------------------------------------------------------------------------------
if [ -z $3 ]
then
    p="500"
else
    p="$3"
fi
#------------------------------------------------------------------------------
# Test filename var
#------------------------------------------------------------------------------
if [ -z $1 ]
then
    BASEDIR=`dirname $0`
    DIRPATH=`cd $BASEDIR; pwd`
    f=$DIRPATH/data/print_toptlk
else
    f="$1"
    printf "<table border=\"1\"><tr><td>COLLECTING</td></tr></table>\n" > $f
    exit 0
fi
#------------------------------------------------------------------------------
# Print top talkers
#------------------------------------------------------------------------------
tf="/tmp/toptlk"
tff="/tmp/toptlk2"
sudo timeout $t tcpdump -tnv not arp and not rarp |    \
grep -E '(*\.*\.*\.*\.* > *\.*\.*\.*\.*|IP \()' |      \
awk '{ if (NR % 2 != 0) printf "%s", $0; else print $0; }' > $tf
#------------------------------------------------------------------------------
buffer1=$(printf "<table border=\"1\">\n<tr>
<td>#</td>
<td>packs</td>
<td>pps</td>
<td>proto</td>
<td><center>IP_SRC -&gt; IP_DST</center></td>
</tr>\n";
cat $tf | awk \
'{ split($0, k);
   split(k[17], ip_src, ".");
   split(k[19], ip_dst, "."); 
   print k[13]" "substr(k[16], 0, length(k[16])-1)" "           \
         ip_src[1]"."ip_src[2]"."ip_src[3]"."ip_src[4]" -&gt; " \
         ip_dst[1]"."ip_dst[2]"."ip_dst[3]"."ip_dst[4]; 
}' | sort -k 3,5 | uniq -c -f 2 | sort -n -k 1,1 | awk -F " " \
'{ PP = $1 / 29;
   { if (substr($2, 0, 1) != "0" && substr($2, 0, 1) != "." && substr($2, 0, 1) != " " && substr($2, 0, 1) != "-" && length($4) > 6 && length($6) > 6 && $1 > 1)
   print "<tr><td>"NR"</td><td>" \
                   $1"</td><td>" \
                   PP"</td><td>" \
                   $2"</td><td>" \
                   $4" -&gt; "$6"</td></tr>\n";
   }
}';
printf "</table><br>\n";)
#------------------------------------------------------------------------------
cat $tf | awk \
'{split($0, k); print k[13]" "substr(k[16], 0, length(k[16])-1)}' | sort | \
awk -F " " 'BEGIN{lp = "NULL"; sumb = 0} {if (lp != $1) { {if (lp != "NULL") print lp" "sumb} lp = $1; sumb = $2} else sumb += $2} END{print lp" "sumb;}' | \
sort -nr -k 2,2 | grep -v "id" > $tff;
cat $tff
count=$(cat $tff | awk -F " " '{sum += $2} END{print sum}')
printf $count;
if [ "$count" -eq "0" ]
then 
	count=1
fi
buffer2=$(printf "<table border=\"1\">\n<tr>
<td>proto</td>
<td>bytes</td>
<td>proportion</td>
</tr>";
cat $tff | awk -F " " -v cnt=$count '{ if ($1 != "" && $1 != "0" && length($1) < 6) print "<tr><td>"$1"</td><td>"$2"</td><td>"$2/cnt*100"%</td></tr>" }';
printf "</table>\n";)
echo $buffer2;
#------------------------------------------------------------------------------
chars=`echo $buffer1 | wc -c`
if (( $chars < 120 ))
then
	printf "<table border=\"1\"><tr><td>NOTHING</td></tr></table>\n" > $f
else
	echo "$buffer1 $buffer2" > $f
fi
#------------------------------------------------------------------------------