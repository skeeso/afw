# afw
Arpa Firewall Wrapper

AFW  (Arpa  Firewall  Wrapper) is a script that helps you build a basic firewall configured with access from different zones. This is done by only allowing specific network of countries to access your server (trusted zone) for a certain ports, and gives you also the option to load the block listed IP addresses or  networks  as  well.  AFW  does  this by configuring three (3) default zones in ipset: green (white listed zone), blue (trusted zone), red (black listed zone). By default, only the IP addresses and networks listed in the trusted zone are allowed to access the server via SSH.

AFW supports iptables and ipset from both Ubuntu and RHEL/CentOS packages:

1. Clone the repository: https://github.com/skeeso/afw
2. cd afw;chmod +x configure
3. ./configure
