#!/bin/sh
while true;do 
  if [ -f error.lock ]; then
    echo "error.lock is present, i will not continue"
    exit 1
  fi
  bin/auths.sh;
  bin/getinventory.sh;
  cp maps/m1.txt cur.txt;
#  bin/multipickupcustom.sh RES_SHIELD,50 50;
#  bin/proposetodrop.sh |grep -E "POWER_CUBE [4-8]|HEATSINK [5-7]|MULTIHACK [1,8]|RES_SHIELD [2-3]|FLIP|EMP_BURSTER [6-8]|EMITTER_A [4-8]|FORCE_AMP|TURRET"|sh;
  scp root@185.66.70.13:/opt/consolebot/mitm/maps/resistanceshieldlatest.txt maps/
  bin/randomizemap.sh maps/resistanceshieldlatest.txt
  bin/genblobmap.sh map.war.txt
  bin/randomizemap.sh map.war.txt
  sleep 600;
  bin/hacknup.sh map.war.txt ;
  sleep 600; 
done
