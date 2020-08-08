#!/bin/bash

#send list players command to minecraft screen
screen -Rd minecraft -p 0 -X width -d 500 > /dev/null 2>&1
screen -Rd minecraft -p 0 -X stuff "list $(printf '\r')" > /dev/null 2>&1

#pause to allow command to execute and return output before writing to file
sleep 1
screen -Rd minecraft -p 0 -X hardcopy > /dev/null 2>&1

#grab the last output line from the list command and parse out player names
STR=$(tac /home/pi/Paper/hardcopy.0 | grep -m1 INFO)
PLAYERS="${STR:60}"
SUB='players online'
if [[ "$STR" == *"$SUB"* ]]; then
  echo "${PLAYERS}"
fi

#loop through player names with comma delimiters
#for i in $(echo $PLAYERS | sed "s/, / /g")
#do
#  echo "$i"
#done
