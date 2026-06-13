#!/bin/bash

processes="$(ps -ef | grep tesla-http-proxy | grep -v grep)"
up=false

# loop through filtered processes
while delimiter='/' read -ra row; do

  for i in "${row[@]}"; do
#    echo "($up) $i"
    if [[ $i == *"tesla-http-proxy"* ]]; then
      up=true
    fi
  done
done <<< "$processes"

# send notification if process found to be not running
if [[ $up == "false" ]]; then
#  echo "Tesla HTTP Proxy not running"
  curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data '{"content":"'"Tesla HTTP Proxy not running"'"}' $webhook &> /dev/null
fi
