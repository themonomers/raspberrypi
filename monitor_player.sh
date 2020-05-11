#!/bin/bash
proc=$(lsof -iTCP:25565 -sTCP:ESTABLISHED | grep -o 'ESTABLISHED' | wc -l) 
echo -e "{\"value\":$proc}"
