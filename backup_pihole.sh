#!/bin/bash

# backup pihole teleporter into usb drive
cd /mnt/usb/pihole
pihole -a -t

# delete all but the last 5 backups
ls -t -d /mnt/usb/pihole/pi-hole-teleporter* | tail -n +6 | xargs rm -rf 
