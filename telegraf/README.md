Steps to configure Telegraf:

1. Update urls = ["<database IP address:port"]
2. Update database = "<database name>"
3. To get network data, uncomment the [[inputs.net]]
4. To get CPU temperature, uncomment the [[inputs.file]], and add the following lines directly below:
  files = ["/sys/class/thermal/thermal_zone0/temp"]
  name_override = "cpu_temperature"
  data_format = "value"
  data_type = "integer"
