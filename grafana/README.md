To perform a full Grafana restore:

1.  Install a new instance of Grafana
2.  Enable systemctl and start Grafana service
3.  Stop Grafana service, update ownership of backup files, and:
      - sudo cp grafana.db /var/lib/grafana/
      - sudo cp grafana.ini /etc/grafana/
4.  Start Grafana service
