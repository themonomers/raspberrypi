#!/bin/bash
STR=$(sudo du -s /var/lib/influxdb/data/grafana/)
SUB=$(echo $STR | cut -d " " -f1)"000"
#echo -e "{\"value\":$SUB}"
echo -e "$SUB"
