#!/bin/bash
. bin/func.inc
LAT=$1
LON=$2
PGUID=$3
DELTALAT=$(($RANDOM%200-100))
DELTALON=$(($RANDOM%200-100))
LATE6=`echo $DELTALAT+$LAT*1000000/1|bc`
LONE6=`echo $DELTALON+$LON*1000000/1|bc`
HEXLATE6=`HEXE6   $LATE6`
HEXLONE6=`HEXE6   $LONE6`
numitemslimit=1930
L8RESLIMIT=200
L7RESLIMIT=100
L6RESLIMIT=200
L5RESLIMIT=200
L4RESLIMIT=200
L3RESLIMIT=2
L2RESLIMIT=2
L1RESLIMIT=2
L8XMPLIMIT=200
L7XMPLIMIT=2
L6XMPLIMIT=100
L5XMPLIMIT=2
L4XMPLIMIT=2
L3XMPLIMIT=2
L2XMPLIMIT=2
L1XMPLIMIT=2
L8CUBELIMIT=200
L7CUBELIMIT=200
L6CUBELIMIT=100
L5CUBELIMIT=100
L4CUBELIMIT=100
L3CUBELIMIT=2
L2CUBELIMIT=2
L1CUBELIMIT=2
MEDIALIMIT=2
KEYLIMIT=2
POWERCUBELIMIT=100
RESSHIELD10LIMIT=2
RESSHIELD20LIMIT=2
RESSHIELD30LIMIT=1000
RESSHIELD50LIMIT=1000
HEATSINKLIMIT=10
FORCEAMPLIMIT=10
MULTIHACKLIMIT=10
TURRETLIMIT=10
LINKAMPLIFIERLIMIT=10
HEATSINK200000LIMIT=2
HEATSINK500000LIMIT=12
HEATSINK700000LIMIT=102
MULTIHACK4LIMIT=2
MULTIHACK8LIMIT=12
MULTIHACK12LIMIT=100
DROPMETHOD="recycleall"
#get overrides
XM=`cat xm.txt`
if [ $XM -eq $XM 2> /dev/null ]; then
  echo > /dev/null
else
  echo xm is not defined,assuming it is empty
    XM=0
fi
if [ $XM -le "650" ]; then
     echo "XM low, will not hack"
     exit 2
fi

if [ -f "config.inc" ]; then
 echo "found custom config, sourcing it..."
 . config.inc
fi
#check input for regmatch
echo DROPMETHOD:$DROPMETHOD
echo hacking $1,$2
./bin/collectItemsFromPortal.pl $HEXLATE6 $HEXLONE6 $PGUID |gzip > payload.gz
./bin/postapi.sh collectItemsFromPortal
cat response/collectItemsFromPortal | ./bin/parseinv.pl
cat response/collectItemsFromPortal | ./bin/parseinv.pl >> inventory.txt
./bin/getObjectsInCellsa.sh $LAT $LON $PGUID
./bin/getModifiedEntitiesByGuid.sh $LAT $LON $PGUID
./bin/hacklog.pl $PGUID 2>&1 >> ~/mitm/hacklog/hacklog.`date +%Y_%m_%d`
clientLevel=`cat response/collectItemsFromPortal|json_xs |grep newLevelUpMsgId|cut -d: -f2|awk '{print $1}'|tr -d "\n"`
if [[ "$clientLevel" =~ ^[0-9]+$ ]]; then
  echo "you have gained new level $clientLevel, leveling up.."
  ./bin/levelUp.sh $LAT $LON  $clientLevel
  echo "newlevelup $clientLevel at ap `cat ap.txt`" >> levelup.log
fi
numitems=`wc -l < inventory.txt`

if [ "$numitems" -ge "$numitemslimit" ]; then
#  bin/autoclearinv.sh
   echo > /dev/null  
  numitems=`wc -l < inventory.txt`
  if [ "$numitems" -ge "$numitemslimit" ]; then
      echo "too much items, i will not continue"
      touch error.lock
      echo "too much items, i will not continue" > error.lock
      exit 1
  fi
fi

oneminskkey=`cat inventory.txt |grep KEY|grep Vilnius2|cut -d, -f3|head -n 1`
if [ -n "$oneminskkey" ]; then
  ./bin/recycleItem.sh $LAT $LON $oneminskkey
  ./bin/removefrominv.sh $oneminskkey
fi
L8RES=`bin/showinv.sh |grep EMITTER_A,8|awk '{print $1}'`
((L8RES++))
if [ "$L8RES" -ge "$L8RESLIMIT" ]; then
  echo more than $L8RESLIMIT l8res, will recycle
  ./bin/$DROPMETHOD.sh EMITTER_A 8 1
fi

L7RES=`bin/showinv.sh |grep EMITTER_A,7|awk '{print $1}'`
((L7RES++))
if [ "$L7RES" -ge "$L7RESLIMIT" ]; then
  echo more than $L7RESLIMIT l7res, will recycle
  ./bin/$DROPMETHOD.sh EMITTER_A 7 1
fi
L6RES=`bin/showinv.sh |grep EMITTER_A,6|awk '{print $1}'`
((L6RES++))
if [ "$L6RES" -ge "$L6RESLIMIT" ]; then
  echo more than $L6RESLIMIT l6res, will recycle
  ./bin/$DROPMETHOD.sh EMITTER_A 6 1
fi

L5RES=`bin/showinv.sh |grep EMITTER_A,5|awk '{print $1}'`
((L5RES++))
if [ "$L5RES" -ge "$L5RESLIMIT" ]; then
  echo more than $L5RESLIMIT l5res, will recycle
  ./bin/$DROPMETHOD.sh EMITTER_A 5 1
fi

L4RES=`bin/showinv.sh |grep EMITTER_A,4|awk '{print $1}'`
((L4RES++))
if [ "$L4RES" -ge "$L4RESLIMIT" ]; then
  echo more than $L4RESLIMIT l4res, will recycle
  ./bin/$DROPMETHOD.sh EMITTER_A 4 1
fi

L3RES=`bin/showinv.sh |grep EMITTER_A,3|awk '{print $1}'`
((L3RES++))
if [ "$L3RES" -ge "$L3RESLIMIT" ]; then
  echo more than $L3RESLIMIT l3res, will recycle
  ./bin/$DROPMETHOD.sh EMITTER_A 3 1
fi

L2RES=`bin/showinv.sh |grep EMITTER_A,2|awk '{print $1}'`
((L2RES++))
if [ "$L2RES" -ge "$L2RESLIMIT" ]; then
  echo more than $L2RESLIMIT l2res, will recycle
  ./bin/$DROPMETHOD.sh EMITTER_A 2 1
fi

L1RES=`bin/showinv.sh |grep EMITTER_A,1|awk '{print $1}'`
((L1RES++))
if [ "$L1RES" -ge "$L1RESLIMIT" ]; then
  echo more than $L1RESLIMIT l1res, will recycle
  ./bin/$DROPMETHOD.sh EMITTER_A 1 1
fi


L8XMP=`bin/showinv.sh |grep EMP_BURSTER,8|awk '{print $1}'`
((L8XMP++))
if [ "$L8XMP" -ge "$L8XMPLIMIT" ]; then
  echo more than $L8XMPLIMIT l8xmp, will recycle
  ./bin/$DROPMETHOD.sh EMP_BURSTER 8 1
fi

L7XMP=`bin/showinv.sh |grep EMP_BURSTER,7|awk '{print $1}'`
((L7XMP++))
if [ "$L7XMP" -ge "$L7XMPLIMIT" ]; then
  echo more than  $L7XMPLIMIT xmp, will recycle
  ./bin/$DROPMETHOD.sh EMP_BURSTER 7 1
fi

L6XMP=`bin/showinv.sh |grep EMP_BURSTER,6|awk '{print $1}'`
((L6XMP++))
if [ "$L6XMP" -ge "$L6XMPLIMIT" ]; then
  echo more than  $L6XMPLIMIT xmp, will recycle
  ./bin/$DROPMETHOD.sh EMP_BURSTER 6 1
fi

L5XMP=`bin/showinv.sh |grep EMP_BURSTER,5|awk '{print $1}'`
((L5XMP++))
if [ "$L5XMP" -ge "$L5XMPLIMIT" ]; then
  echo more than  $L5XMPLIMIT xmp, will recycle
  ./bin/$DROPMETHOD.sh EMP_BURSTER 5 1
fi

L4XMP=`bin/showinv.sh |grep EMP_BURSTER,4|awk '{print $1}'`
((L4XMP++))
if [ "$L4XMP" -ge "$L4XMPLIMIT" ]; then
  echo more than $L4XMPLIMIT xmp, will recycle
  ./bin/$DROPMETHOD.sh EMP_BURSTER 4 1
fi

L3XMP=`bin/showinv.sh |grep EMP_BURSTER,3|awk '{print $1}'`
((L3XMP++))
if [ "$L3XMP" -ge "$L3XMPLIMIT" ]; then
  echo more than $L3XMPLIMIT xmp, will recycle
  ./bin/$DROPMETHOD.sh EMP_BURSTER 3 1
fi

L2XMP=`bin/showinv.sh |grep EMP_BURSTER,2|awk '{print $1}'`
((L2XMP++))
if [ "$L2XMP" -ge "$L2XMPLIMIT" ]; then
  echo more than $L2XMPLIMIT xmp, will recycle
  ./bin/$DROPMETHOD.sh EMP_BURSTER 2 1
fi

L1XMP=`bin/showinv.sh |grep EMP_BURSTER,1|awk '{print $1}'`
((L1XMP++))
if [ "$L1XMP" -ge "$L1XMPLIMIT" ]; then
  echo more than $L1XMPLIMIT xmp, will recycle
  ./bin/$DROPMETHOD.sh EMP_BURSTER 1 1
fi

KEYS=`bin/showinv.sh |grep PORTAL_LINK_KEY|awk '{print $1}'`
((KEYS++))
if [ "$KEYS" -ge "$KEYLIMIT" ]; then
  echo more than $KEYLIMIT keys, will recycle
  ./bin/$DROPMETHOD.sh PORTAL_LINK_KEY 0 1
fi
L1CUBE=`bin/showinv.sh |grep POWER_CUBE,1|awk '{print $1}'`
((L1CUBE++))
if [ "$L1CUBE" -ge "$L1CUBELIMIT" ]; then
  echo more than $L1CUBELIMIT cubes, will recycle
  ./bin/$DROPMETHOD.sh POWER_CUBE 1 1
fi
L2CUBE=`bin/showinv.sh |grep POWER_CUBE,2|awk '{print $1}'`
((L2CUBE++))
if [ "$L2CUBE" -ge "$L2CUBELIMIT" ]; then
  echo more than $L2CUBELIMIT cubes, will recycle
  ./bin/$DROPMETHOD.sh POWER_CUBE 2 1
fi
L3CUBE=`bin/showinv.sh |grep POWER_CUBE,3|awk '{print $1}'`
((L3CUBE++))
if [ "$L3CUBE" -ge "$L3CUBELIMIT" ]; then
  echo more than $L3CUBELIMIT cubes, will recycle
  ./bin/$DROPMETHOD.sh POWER_CUBE 3 1
fi
L4CUBE=`bin/showinv.sh |grep POWER_CUBE,4|awk '{print $1}'`
((L4CUBE++))
if [ "$L4CUBE" -ge "$L4CUBELIMIT" ]; then
  echo more than $L4CUBELIMIT cubes, will recycle
  ./bin/$DROPMETHOD.sh POWER_CUBE 4 1
fi
L5CUBE=`bin/showinv.sh |grep POWER_CUBE,5|awk '{print $1}'`
((L5CUBE++))
if [ "$L5CUBE" -ge "$L5CUBELIMIT" ]; then
  echo more than $L5CUBELIMIT cubes, will recycle
  ./bin/$DROPMETHOD.sh POWER_CUBE 5 1
fi
L6CUBE=`bin/showinv.sh |grep POWER_CUBE,6|awk '{print $1}'`
((L6CUBE++))
if [ "$L6CUBE" -ge "$L6CUBELIMIT" ]; then
  echo more than $L6CUBELIMIT cubes, will recycle
  ./bin/$DROPMETHOD.sh POWER_CUBE 6 1
fi
L7CUBE=`bin/showinv.sh |grep POWER_CUBE,7|awk '{print $1}'`
((L7CUBE++))
if [ "$L7CUBE" -ge "$L7CUBELIMIT" ]; then
  echo more than $L7CUBELIMIT cubes, will recycle
  ./bin/$DROPMETHOD.sh POWER_CUBE 7 1
fi
L8CUBE=`bin/showinv.sh |grep POWER_CUBE,8|awk '{print $1}'`
((L8CUBE++))
if [ "$L8CUBE" -ge "$L8CUBELIMIT" ]; then
  echo more than $L8CUBELIMIT cubes, will recycle
  ./bin/$DROPMETHOD.sh POWER_CUBE 8 1
fi
HEATSINK200000=`bin/showinv.sh |grep HEATSINK,200000|awk '{print $1}'`
((HEATSINK200000++))
if [ "$HEATSINK200000" -ge "$HEATSINK200000LIMIT" ]; then
  echo more than $HEATSINK200000LIMIT heatsink, will recycle
  ./bin/$DROPMETHOD.sh HEATSINK 200000 1
fi
HEATSINK500000=`bin/showinv.sh |grep HEATSINK,500000|awk '{print $1}'`
((HEATSINK500000++))
if [ "$HEATSINK500000" -ge "$HEATSINK500000LIMIT" ]; then
  echo more than $HEATSINK500000LIMIT heatsink, will recycle
  ./bin/$DROPMETHOD.sh HEATSINK 500000 1
fi
HEATSINK700000=`bin/showinv.sh |grep HEATSINK,700000|awk '{print $1}'`
((HEATSINK700000++))
if [ "$HEATSINK700000" -ge "$HEATSINK700000LIMIT" ]; then
  echo more than $HEATSINK700000LIMIT heatsink, will recycle
  ./bin/$DROPMETHOD.sh HEATSINK 700000 1
fi
MULTIHACK4=`bin/showinv.sh |grep MULTIHACK,4|awk '{print $1}'`
((MULTIHACK4++))
if [ "$MULTIHACK4" -ge "$MULTIHACK4LIMIT" ]; then
  echo more than $MULTIHACK4LIMIT multihack, will recycle
  ./bin/$DROPMETHOD.sh MULTIHACK 4 1
fi
MULTIHACK8=`bin/showinv.sh |grep MULTIHACK,8|awk '{print $1}'`
((MULTIHACK8++))
if [ "$MULTIHACK8" -ge "$MULTIHACK8LIMIT" ]; then
  echo more than $MULTIHACK8LIMIT multihack, will recycle
  ./bin/$DROPMETHOD.sh MULTIHACK 8 1
fi
MULTIHACK12=`bin/showinv.sh |grep MULTIHACK,12|awk '{print $1}'`
((MULTIHACK12++))
if [ "$MULTIHACK12" -ge "$MULTIHACK12LIMIT" ]; then
  echo more than $MULTIHACK12LIMIT multihack, will recycle
  ./bin/$DROPMETHOD.sh MULTIHACK 12 1
fi

MEDIA=`bin/showinv.sh |grep MEDIA|head -n 1|awk '{print $1}'`
((MEDIA++))
if [ "$MEDIA" -ge "$MEDIALIMIT" ]; then
  MEDIALEVEL=`bin/showinv.sh |grep MEDIA|head -n 1|cut -d, -f2`
  echo more than $MEDIALIMIT media, will recycle
  ./bin/$DROPMETHOD.sh MEDIA $MEDIALEVEL 1
fi

RESSHIELD10=`bin/showinv.sh |grep RES_SHIELD,10|awk '{print $1}'`
((RESSHIELD10++))
if [ "$RESSHIELD10" -ge "$RESSHIELD10LIMIT" ]; then
  echo more than $RESSHIELD10LIMIT shields, will recycle
  ./bin/$DROPMETHOD.sh RES_SHIELD 10 1
fi

RESSHIELD20=`bin/showinv.sh |grep RES_SHIELD,20|awk '{print $1}'`
((RESSHIELD20++))
if [ "$RESSHIELD20" -ge "$RESSHIELD20LIMIT" ]; then
  echo more than $RESSHIELD20LIMIT shields, will recycle
  ./bin/$DROPMETHOD.sh RES_SHIELD 20 1
fi

RESSHIELD30=`bin/showinv.sh |grep RES_SHIELD,30|awk '{print $1}'`
((RESSHIELD30++))
if [ "$RESSHIELD30" -ge "$RESSHIELD30LIMIT" ]; then
  echo more than $RESSHIELD30LIMIT shields, will recycle
  ./bin/$DROPMETHOD.sh RES_SHIELD 30 1
fi

FORCEAMP=`bin/showinv.sh |grep FORCE_AMP,2000|awk '{print $1}'`
((FORCEAMP++))
if [ "$FORCEAMP" -ge "$FORCEAMPLIMIT" ]; then
  echo more than $FORCEAMPLIMIT forceamp, will recycle
  ./bin/$DROPMETHOD.sh FORCE_AMP 2000  1
fi

TURRET=`bin/showinv.sh |grep TURRET,2000|awk '{print $1}'`
((TURRET++))
if [ "$TURRET" -ge "$TURRETLIMIT" ]; then
  echo more than $TURRETLIMIT turrets, will recycle
  ./bin/$DROPMETHOD.sh TURRET 2000  1
fi

