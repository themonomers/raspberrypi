#!/bin/bash

# backup InfluxDB into a new folder 
DIR=influx-$(date +%Y.%m.%d.%H.%M.%S)
mkdir /home/pi/influxdb/$DIR
cd /home/pi/influxdb/$DIR
influxd backup -portable .

# delete all but the last 5 backup folders
#ls -t influx-* | tail -n +6 | xargs rm --
ls -t -d /home/pi/influxdb/influx-* | tail -n +6 | xargs rm -rf 

# backup the backups to usb drive
rsync -a --delete /home/pi/influxdb /mnt/usb
