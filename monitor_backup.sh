#!/bin/bash

GRAFANA_BACKED_UP=false
DEV_BACKED_UP=false

TODAY=$(date +%F)
#echo $TODAY

# check file date
cd /mnt/usb/grafana
FILE=$(ls -1t | sed -n '2p')
FILE_DATE=$(stat -c %y "$FILE" | cut -d' ' -f1)
#echo $FILE_DATE

if [[ $TODAY == $FILE_DATE ]]; then
  GRAFANA_BACKED_UP=true
fi  

# check file date
cd /mnt/usb/dev/tesla/python/test
FILE=$(ls -t | head -n 1)
FILE_DATE=$(stat -c %y "$FILE" | cut -d' ' -f1)
#echo $FILE_DATE

if [[ $TODAY == $FILE_DATE ]]; then
  DEV_BACKED_UP=true
fi

# send notification if back up failed
if [[ $GRAFANA_BACKED_UP == "false" ]] || [[ $DEV_BACKED_UP == "false" ]]; then
  curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data '{"content":"'"One or more backups failed on $HOSTNAME:  \n  Grafana Backed Up:  $GRAFANA_BACKED_UP\n  Dev Backed Up:  $DEV_BACKED_UP"'"}' $webhook &> /dev/null
fi
