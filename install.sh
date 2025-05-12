#!/bin/bash
# Install script for raspberrypi-hotspot-cli
set -e

# Copy CLI
sudo cp hotspot /usr/local/bin/hotspot
sudo chmod +x /usr/local/bin/hotspot

# Copy scripts (if present)
if [ -d scripts ]; then
  sudo mkdir -p /usr/local/lib/raspberrypi-hotspot-cli/scripts
  sudo cp scripts/*.sh /usr/local/lib/raspberrypi-hotspot-cli/scripts/
  sudo chmod +x /usr/local/lib/raspberrypi-hotspot-cli/scripts/*.sh
fi

echo "hotspot CLI installed! Run 'hotspot --help' to get started."
