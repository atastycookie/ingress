#!/bin/bash
PORTALGUID=`cat  maps/vc2.txt |cut -d, -f3|sort -R|head -n 1`
while true; do
cat maps/p|gzip > payload.gz ; ./bin/postapi.sh getObjectsInCells
  ./bin/upgradeportalmod.sh 0 0 $PORTALGUID
  ./bin/rechargeResonatorsV2.sh 0 0 $PORTALGUID
  ./bin/rechargeResonatorsV2.sh 0 0 $PORTALGUID
  ./bin/rechargeResonatorsV2.sh 0 0 $PORTALGUID
  ./bin/upgradeportalmod.sh 0 0 $PORTALGUID
  if [ -f maps/vcl3.txt ]; then
    echo "WAR HAS BEGUN"
    sleep 120
    bin/vwar3.sh
  fi 
done
