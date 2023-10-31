Steps to configure Telegraf:

1. Update urls = ["<database IP address:port"]
2. Update database = "<database name>"
3. To get network data, uncomment the [[inputs.net]]
4. In order for the inputs.exec to run properly in Telegraf:
  a.  Add telegraf user to video group (for GPU temperature), sudo usermod -a -G video telegraf, and restart the service (systemctl)
  b.  Daemon runs as telegraf therefore some of the shell scripts don't return the expected values and need to run with sudo and bypass the password:
    i.  Run:  sudo visudo
    ii.  Add:  telegraf ALL=(ALL) NOPASSWD: /<full path>/monitor_player.sh, /<full path>/monitor_player_list.sh, /<full path>/monitor_minecraft.sh
