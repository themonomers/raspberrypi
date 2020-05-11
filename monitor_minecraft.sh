#!/bin/bash
proc=$(ps aux | grep java | grep -v grep) 
sub='java'
if [[ "$proc" == *"$sub"* ]]; then
  echo -e "{\"value\":1}"
else
  echo -e "{\"value\":0}"
fi
