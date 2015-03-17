#!/bin/bash
POS1=""
POS2=""
for i in `cat $1|cut -d, -f1,2`;do
  echo -n $i
  PGUID=`grep $i $1|cut -d, -f3|sort -n|uniq`
  POS1=$POS2
  POS2=$i
  if [ -z $POS1 ]
  then
    echo ",60,$PGUID"
  else
  DISTM=`./bin/mapmaker/distance.pl $POS1 $POS2|grep -vE ","`
#  echo $DISTKM
  DISTMIN=`echo "scale=0; 70*$DISTM/1000"|bc`
  echo ",$DISTMIN,$PGUID"
  fi
done
