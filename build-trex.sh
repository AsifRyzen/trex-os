#!/bin/bash

echo "Starting TReX OS build process..."

# Update system
sudo apt update
sudo apt upgrade -y

# Install TReX identity packages
sudo xargs -a trex-identity-packages.txt apt install -y

# Apply configuration layer
./trex-config.sh

echo "TReX OS build process complete."
