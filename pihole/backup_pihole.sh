#!/bin/bash

# backup pihole teleporter into usb drive
cd /home/pi/pihole
/usr/local/bin/pihole -a -t

# delete all but the last 5 backups
ls -t -d /home/pi/pihole/pi-hole-teleporter* | tail -n +6 | xargs rm -rf 

# backup the backups to usb drive
rsync -a --delete /home/pi/pihole /mnt/usb
