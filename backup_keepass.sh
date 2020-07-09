#!/bin/bash

# backup copy of shared Keepass databases if different 
FILE=$(ls -t main* | head -1)
STR=$(diff -s "$FILE" /mnt/gdrive/misc/main.kdbx)
SUB='differ'
if [[ "$STR" == *"$SUB"* ]]; then
  cp /mnt/gdrive/misc/main.kdbx /home/pi/keepass/main.$(date +%Y.%m.%d.%H.%M.%S).kdbx
fi

FILE=$(ls -t other* | head -1)
STR=$(diff -s "$FILE" /mnt/gdrive_other/other.kdbx)
if [[ "$STR" == *"$SUB"* ]]; then
  cp /mnt/gdrive_other/other.kdbx /home/pi/keepass/other.$(date +%Y.%m.%d.%H.%M.%S).kdbx
fi

# backup the backups to usb drive
rsync -a --delete /home/pi/keepass /mnt/usb
