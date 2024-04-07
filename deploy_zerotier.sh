#!/bin/bash

# Install ZeroTier
curl -s https://install.zerotier.com | sudo bash

# Prompt user to enter ZeroTier network ID
echo "Please enter the ZeroTier network ID:"
read network_id

# Join ZeroTier network
sudo zerotier-cli join $network_id

# Start ZeroTier service
sudo systemctl start zerotier-one

# Check ZeroTier service status
sudo systemctl status zerotier-one
