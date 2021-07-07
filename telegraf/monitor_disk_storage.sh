#!/bin/bash
#STR=$(sudo du -s /var/lib/influxdb/data/grafana/)
STR=$(sudo du -s / 2> /dev/null | cut -f1)
SUB=$(echo $STR | cut -d " " -f1)"000"
#echo -e "{\"value\":$SUB}"
echo -e "$SUB"
