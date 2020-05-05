import os
import requests

try:
  line = os.popen("screen -list | grep minecraft").readline()
  if "minecraft" not in line:
    requests.post("https://maker.ifttt.com/trigger/minecraft_server_down/with/key/KEY")

except:
  pass
