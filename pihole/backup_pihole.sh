#!/bin/bash

# run pihole teleporter to backup configuration as an archive
cd /home/pi/pihole
sudo pihole-FTL --teleporter

# delete all but the last 5 backups
ls -t -d /home/pi/pihole/pi-hole_teleporter* | tail -n +6 | xargs rm -rf

# backup the backups to usb drive
rsync -a --delete /home/pi/pihole /mnt/usb
