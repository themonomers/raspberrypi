#!/bin/bash
thirty_days_ago=$(date +"%Y-%m-%d" -d "30 days ago")
echo "Removing logs older than 30 days ($thirty_days_ago)..."
files=$(ls /home/pi/Paper/logs | wc -l)
if [ $files -gt 5 ]
then
  find /home/pi/Paper/logs -name '*.log.gz' -mtime +29 -print0 | xargs -0 rm -f
fi
