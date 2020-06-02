#!/bin/bash
five_days_ago=$(date +"%Y-%m-%d" -d "5 days ago")
echo "Removing any more than 5 backups older than 5 days ($five_days_ago)..."
files=$(ls /home/pi/Paper/backups | wc -l)
if [ $files -gt 5 ]
then
  find /home/pi/Paper/backups -name '*.tar.gz' -mtime +4 -print0 | xargs -0 rm -f
  rsync -a --delete /home/pi/Paper/backups/ /mnt/usb
fi
