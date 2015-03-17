#!/bin/bash
. bin/func.inc
LAT=$1
LON=$2
ITEMID=$3
PORTALGUID=$4
LATE6=`echo $LAT*1000000/1|bc`
LONE6=`echo $LON*1000000/1|bc`
HEXLATE6=`HEXE6   $LATE6`
HEXLONE6=`HEXE6   $LONE6`
#check input for regmatch
echo will flip portal with  `cat inventory.txt|grep $ITEMID`
./bin/flipPortal.pl $HEXLATE6 $HEXLONE6 $ITEMID $PORTALGUID|gzip > payload.gz
./bin/removefrominv.sh $ITEMID
./bin/postapi.sh flipPortal
