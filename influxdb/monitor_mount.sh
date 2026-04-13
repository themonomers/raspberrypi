#!/bin/bash

mounts="$(df -h)"
usb=false

# loop through disks
while delimiter='/' read -ra row; do

  for i in "${row[@]}"; do
#    echo "$i"
    if [[ $i == "/mnt/usb" ]]; then
      usb=true
    fi
  done
done <<< "$mounts"

#echo "$usb"

# send notification if any disks failed to mount
if [[ $usb == "false" ]]; then
  curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data '{"content":"'"One or more disks failed to mount on $HOSTNAME:  \n  USB Mounted: $usb"'"}' $webhook &> /dev/null
fi
