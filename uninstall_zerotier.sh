#!/bin/bash

# Stop ZeroTier service
sudo systemctl stop zerotier-one

# Unjoin ZeroTier network
sudo zerotier-cli leaveall

# Uninstall ZeroTier
sudo apt purge zerotier-one -y

# Remove ZeroTier configuration and data
sudo rm -rf /var/lib/zerotier-one
sudo rm -rf /etc/zerotier-one

echo "ZeroTier 卸载完成。"
