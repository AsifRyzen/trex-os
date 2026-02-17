#!/bin/bash

set -e

echo "Applying TReX OS configuration..."

# ---- SNAP POLICY ----
if dpkg -l | grep -q snapd; then
    echo "Removing snapd..."
    sudo apt remove -y snapd
fi

# ---- NETWORK WAIT FIX ----
sudo systemctl disable systemd-networkd-wait-online.service 2>/dev/null || true
sudo systemctl mask systemd-networkd-wait-online.service 2>/dev/null || true

# ---- PERFORMANCE TUNING ----
SYSCTL_FILE="/etc/sysctl.d/99-trex.conf"

echo "Applying performance tuning..."

sudo tee "$SYSCTL_FILE" > /dev/null <<EOF
vm.swappiness=10
vm.dirty_background_ratio=5
vm.dirty_ratio=10
EOF

sudo sysctl --system

echo "TReX OS configuration complete."
