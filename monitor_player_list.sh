#!/bin/bash

#send list players command to minecraft screen
screen -Rd minecraft -p 0 -X stuff "list $(printf '\r')"

#pause to allow command to execute and return output before writing to file
sleep 1
screen -Rd minecraft -p 0 -X hardcopy

#grab the last output line from the list command and parse out player names
STR=$(tac /home/pi/Paper/hardcopy.0 | grep -m1 INFO)
PLAYERS="${STR:60}"
echo "${PLAYERS}"

#loop through player names with comma delimiters
#for i in $(echo $PLAYERS | sed "s/, / /g")
#do
#  echo "$i"
#done
