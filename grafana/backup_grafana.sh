#!/bin/bash

echo "Executing Grafana Backup"
timestamp=$(date +"%Y.%m.%d.%H.%M.%S")
sudo tar -cvf /home/pi/grafana/grafana-$timestamp.tar /var/lib/grafana/grafana.db
sudo tar -rvf /home/pi/grafana/grafana-$timestamp.tar /etc/grafana/grafana.ini
gzip /home/pi/grafana/grafana-$timestamp.tar

# delete all but the last 5 backups
ls -t -d /home/pi/grafana/grafana-* | tail -n +6 | xargs rm -rf


# backup the backups to usb drive
rsync -a --delete /home/pi/grafana /mnt/usb
