#!/bin/bash

# backup copy of shared Keepass databases if different 
FILE=$(ls -t /home/pi/keepass/main* | head -1)
STR=$(diff -s "$FILE" /mnt/gdrive/misc/main.kdbx)
SUB='differ'
if [[ "$STR" == *"$SUB"* ]]; then
  cp /mnt/gdrive/misc/main.kdbx /home/pi/keepass/main.$(date +%Y.%m.%d.%H.%M.%S).kdbx
fi

# delete all but the last 10 files
COUNT=$(ls /home/pi/keepass/kathy.* | wc -l)
if [[ $COUNT -gt 10 ]]; then
  ls -t /home/pi/keepass/kathy.* | tail -n +11 | xargs rm --
fi

FILE=$(ls -t /home/pi/keepass/kathy* | head -1)
STR=$(diff -s "$FILE" /mnt/gdrive_kathy/kathy.kdbx)
if [[ "$STR" == *"$SUB"* ]]; then
  cp /mnt/gdrive_kathy/kathy.kdbx /home/pi/keepass/kathy.$(date +%Y.%m.%d.%H.%M.%S).kdbx
fi

# delete all but the last 10 files
COUNT=$(ls /home/pi/keepass/main.* | wc -l)
if [[ $COUNT -gt 10 ]]; then
  ls -t /home/pi/keepass/main.* | tail -n +11 | xargs rm --
fi

# backup the backups to usb drive
rsync -a --delete /home/pi/keepass /mnt/usb
