#!/bin/bash

cd /home/pi/vehicle-command

/usr/local/go/bin/go run /home/pi/vehicle-command/cmd/tesla-http-proxy -tls-key /home/pi/tesla/python/secrets/key.pem -cert /home/pi/tesla/python/secrets/cert.pem -port 4443 -key-file /home/pi/tesla/python/secrets/tesla_private_key.pem > tesla-http-proxy.log 2>&1 &
