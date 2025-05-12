# Raspberry Pi Hotspot CLI

A standalone CLI tool to manage a WiFi hotspot on Raspberry Pi with systemd integration, firewall/NAT rules, and flexible configuration.

## Features
- Start, stop, restart, and check status/logs of the hotspot
- Custom SSID, WPA2 password, WiFi and Internet interfaces
- Integrates with systemd for robust service management
- Automatically manages iptables/NAT rules
- Easy to use and extend

## Usage
```
hotspot <start|stop|restart|status|logs> [options]

Options:
  --ssid <name>         Set the WiFi SSID (network name) for the hotspot
  --pass <password>     Set the WPA2 password for the hotspot (min 8 chars)
  --wifi <iface>        Set the WiFi interface to use (default: wlan0)
  --inet <iface>        Set the outgoing Internet interface (default: eth0)
  --help                Show help message and exit
```

### Examples
```
hotspot start --ssid MyNetwork --pass mysecretpass
hotspot stop
hotspot restart --wifi wlan1 --inet eth1
hotspot status
hotspot logs
```

## Installation
Run the install script:
```
curl -fsSL https://raw.githubusercontent.com/<youruser>/raspberrypi-hotspot-cli/main/install.sh | bash
```
Or manually:
```
sudo cp hotspot /usr/local/bin/hotspot
sudo chmod +x /usr/local/bin/hotspot
```

## Requirements
- Bash
- systemd
- create_ap, hostapd, dnsmasq, iptables (install via your package manager)

## License
MIT
