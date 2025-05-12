#!/bin/bash
# Script to reload the WiFi hotspot configuration
set -e

"$(dirname "$0")/stop-hotspot.sh"
sleep 2
"$(dirname "$0")/start-hotspot.sh"

echo "Hotspot configuration reloaded."
