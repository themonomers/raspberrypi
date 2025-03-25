#!/bin/bash

mounts="$(df -h)"
usb=false
gdrive=false

# loop through disks
while delimiter='/' read -ra row; do

  for i in "${row[@]}"; do
#    echo "$i"
    if [[ $i == "/mnt/usb" ]]; then
      usb=true
    fi
    if [[ $i == "/mnt/gdrive" ]]; then
      gdrive=true
    fi
  done
done <<< "$mounts"

#echo "$usb"
#echo "$gdrive"

# send notification if any disks failed to mount
if [[ $usb == "false" ]] || [[ $gdrive == "false" ]]; then
  curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data '{"content":"'"One or more disks failed to mount:  \n  USB: $usb\n  GDrive:  $gdrive"'"}' $webhook &> /dev/null
fi
