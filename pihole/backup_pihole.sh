#!/bin/bash

# backup pihole teleporter into usb drive
cd /home/pi/pihole
/usr/local/bin/pihole -a -t

# backup copy DNS mapping file if different
FILE=$(ls -t /home/pi/pihole/dnsmasq-* | head -1)
STR=$(diff -s "$FILE" /etc/dnsmasq.conf)
SUB='differ'
if [[ "$STR" == *"$SUB"* ]]; then
  timestamp=$(date +"%Y.%m.%d.%H.%M.%S")
  sudo cp /etc/dnsmasq.conf /home/pi/pihole/dnsmasq-$timestamp.conf
fi

# delete all but the last 5 backups
ls -t -d /home/pi/pihole/pi-hole-teleporter* | tail -n +6 | xargs rm -rf 
ls -t -d /home/pi/pihole/dnsmasq-* | tail -n +6 | xargs rm -rf

# backup the backups to usb drive
rsync -a --delete /home/pi/pihole /mnt/usb
