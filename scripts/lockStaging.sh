#!/bin/bash
# H78R Systems
# Usage: ./lock.sh <IP_ADDRESS>
# Example: ./lock.sh 203.0.113.42

if [ -z "$1" ]; then
  echo "Usage: $0 <IP_ADDRESS>"
  exit 1
fi

IP="$1"
HTACCESS_PATH="$(dirname "$0")/../../.htaccess"

# Append IP restriction to .htaccess
echo -e "\n# Lock down staging to IP: $IP\n<RequireAll>\n    Require ip $IP\n</RequireAll>" >> "$HTACCESS_PATH"

echo "Appended IP lock to .htaccess for IP: $IP"
