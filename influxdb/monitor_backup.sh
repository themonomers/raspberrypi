#!/bin/bash

INFLUX_BACKED_UP=false

TODAY=$(date +%F)
#echo $TODAY

# check file date
cd /mnt/usb/influxdb
FILE=$(ls -1t | sed -n '2p')
FILE_DATE=$(stat -c %y "$FILE" | cut -d' ' -f1)
#echo $FILE_DATE

if [[ $TODAY == $FILE_DATE ]]; then
  INFLUX_BACKED_UP=true
fi

# send notification if back up failed
if [[ $INFLUX_BACKED_UP == "false" ]]; then
  curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data '{"content":"'"One or more backups failed:  \n  Influx Backed Up:  $INFLUX_BACKED_UP"'"}' $webhook &> /dev/null
fi
