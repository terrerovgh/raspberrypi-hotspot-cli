#!/bin/bash
# Script to stop the WiFi hotspot and clean up firewall rules
set -e

WIFI_IFACE="${WIFI_IFACE:-wlan0}"
INTERNET_IFACE="${INTERNET_IFACE:-eth0}"

# Stop create_ap
sudo pkill -f "create_ap.*$WIFI_IFACE"

# Clean up iptables rules
sudo iptables -t nat -D POSTROUTING -o "$INTERNET_IFACE" -j MASQUERADE || true
sudo iptables -D FORWARD -i "$WIFI_IFACE" -o "$INTERNET_IFACE" -j ACCEPT || true
sudo iptables -D FORWARD -i "$INTERNET_IFACE" -o "$WIFI_IFACE" -m state --state RELATED,ESTABLISHED -j ACCEPT || true
# Clean up proxy/DNS redirections if present
sudo iptables -t nat -D PREROUTING -i "$WIFI_IFACE" -p tcp --dport 80 -j REDIRECT --to-port 3128 || true
sudo iptables -t nat -D PREROUTING -i "$WIFI_IFACE" -p tcp --dport 443 -j REDIRECT --to-port 3129 || true
sudo iptables -t nat -D PREROUTING -i "$WIFI_IFACE" -p udp --dport 53 -j REDIRECT --to-port 5353 || true

# Save rules
sudo iptables-save > /etc/iptables/iptables.rules

echo "Hotspot stopped and firewall rules cleaned up."
