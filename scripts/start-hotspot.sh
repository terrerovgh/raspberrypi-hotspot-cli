#!/bin/bash
# Script to start the WiFi hotspot with create_ap and firewall rules
set -e

# Use environment variables or defaults
WIFI_IFACE="${WIFI_IFACE:-wlan0}"
INTERNET_IFACE="${INTERNET_IFACE:-eth0}"
SSID="${SSID:-TerrerovHotspot}"
PASSPHRASE="${PASSPHRASE:-raspberry2025}"

# Start create_ap
sudo create_ap --daemon --no-virt -n "$WIFI_IFACE" "$INTERNET_IFACE" "$SSID" "$PASSPHRASE"

# Enable NAT and forwarding
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o "$INTERNET_IFACE" -j MASQUERADE
sudo iptables -A FORWARD -i "$WIFI_IFACE" -o "$INTERNET_IFACE" -j ACCEPT
sudo iptables -A FORWARD -i "$INTERNET_IFACE" -o "$WIFI_IFACE" -m state --state RELATED,ESTABLISHED -j ACCEPT

# Example: redirect HTTP/HTTPS to proxy in Docker (uncomment and adjust as needed)
# sudo iptables -t nat -A PREROUTING -i "$WIFI_IFACE" -p tcp --dport 80 -j REDIRECT --to-port 3128
# sudo iptables -t nat -A PREROUTING -i "$WIFI_IFACE" -p tcp --dport 443 -j REDIRECT --to-port 3129
# Example: redirect DNS to Pi-hole/CoreDNS in Docker
# sudo iptables -t nat -A PREROUTING -i "$WIFI_IFACE" -p udp --dport 53 -j REDIRECT --to-port 5353

# Save rules
sudo iptables-save > /etc/iptables/iptables.rules

echo "Hotspot started and firewall rules applied."
