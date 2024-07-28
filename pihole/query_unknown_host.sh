#!/bin/bash

leases="$(cat /etc/pihole/dhcp.leases)"
#echo "$leases"

# loop through pihole dhcp lease file delimited by spaces
while delimiter=' ' read -ra entry; do
  count=1

  for i in "${entry[@]}"; do
#    echo "$count.  $i"
    if [ "$count" == 1 ]; then
      id=$i
    elif [ "$count" == 2 ]; then
      mac=$i
    elif [ "$count" == 3 ]; then
      ip=$i
    elif [ "$count" == 4 ]; then
      hostname=$i
    elif [ "$count" == 5 ]; then
      other=$i
    fi

    count=$[count + 1]
  done

  # look for any unknown hostnames and send a notification to discord for further investigation for security purposes (all known device hostnames and their corresponding mac addresses are either mapped in /etc/dnsmasq.conf or assigned a static ip in the pihole web console)
  if [ "$hostname" == "*" ]; then
#    echo "unknown host detected:  $id $mac $ip $hostname $other"
    curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data '{"content":"'"Unknown host detected:  \n  ID:  $id\n  MAC Address:  $mac\n  IP Address:  $ip\n  Hostname:  $hostname\n  DHCP UID:  $other"'"}' $webhook &> /dev/null
  fi

#  echo "$id|$mac|$ip|$hostname|$other"
#  echo "===="
done <<< "$leases"
