# Arpa Firewall Wrapper (AFW)

**Arpa Firewall Wrapper (AFW)** is a script that helps you build a basic firewall with zone-based access controls. It works by allowing only specific country networks to access your server (trusted zones) on designated ports. AFW also provides the option to load blocklisted IP addresses or networks.

AFW achieves this by configuring three (3) default zones in **ipset**:

* **Green** – whitelisted zone
* **Blue** – trusted zone
* **Red** – blocklisted zone

By default, only the IP addresses and networks in the trusted zone are permitted to access the server via SSH.

The main goal of AFW is to simplify the process of whitelisting and blacklisting. Instead of leaving your server open to all, it restricts access only to countries where you intend to deliver content or conduct business. This reduces the risk of attackers from unauthorized countries scanning or harvesting information from your server.

The list of country-specific networks is sourced from:
[https//www.ipdeny.com/ipblocks/data/countries](https://www.ipdeny.com/ipblocks/data/countries)

AFW supports **iptables** and **ipset** on **Ubuntu** distributions.

0xff, e@arpa.ph
