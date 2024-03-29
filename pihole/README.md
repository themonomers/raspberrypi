Setup Pihole as DNS and DHCP server:
1.  Set router primary DNS to Pihole static IP
2.  Turn off router DHCP
3.  Turn on Pihole DHCP
4.  Update Pihole, /etc/dhcpcd.conf:  static domain_name_servers=<Pihole static IP, not 127.0.0.1> 
5.  Set devices DNS configuration to automatic

Hostname mapping to IP addresses in Pihole:
1.  Update Pihole for DHCP clients, /etc/dnsmasq.conf:  dhcp-host=<MAC address>,<hostname>
2.  Update Pihole for static DHCP lease clients, /etc/hosts:  127.0.0.1 localhost, 127.0.1.1 <hostname>, and other <static IP> <hostname>
3.  Update Pihole for static IP address, /etc/dhcpcd.conf:  static ip_address=<Pihole static IP>/24, static routers=<router IP>, static domain_name_servers=<Pihole static IP>
4.  Update static DHCP lease clients, /etc/dhcpcd.conf:  static domain_name_servers=<Pihole static IP, not router IP>
5.  Update clients for hostnames, /etc/hosts:  127.0.0.1 localhost, 127.0.1.1 <hostname>

Hostname namespace:  [prefix]-[owner]-[item]-[location]-[id]
