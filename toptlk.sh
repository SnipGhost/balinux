# Найти последний файл по маске  *_toptlk
ls -t *_toptlk | head -n1

#!/bin/bash
#-------------------
# Test timeout time
#-------------------
if [ -z $1 ]
then
	t="30"
else
	t="$1"
fi
#-------------------
# Test packs count
#-------------------
if [ -z $2 ]
then
	p="1000"
else
	p="$2"
fi
#-------------------
# Test packs count
#-------------------
if [ -z $3 ]
then
    f=`date +%Y.%m.%d_%H:%M:%S_toptlk`
else
    f="$3"
fi
#-------------------
# Print top talkers
#-------------------
sudo timeout $t tcpdump -tnn -c $p | awk -F "." '{print $1"."$2"."$3"."$4}' | sort | uniq -c | sort -nr | awk '$1 > 1' > $f