#!/bin/bash

STR=$(ps -aux |grep "/usr/bin/python /home/pi/webhook/PowerwallWebhook.py" | grep -v grep)

PROC=${STR:9:5}
#echo $PROC

kill $PROC
