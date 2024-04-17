#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Install gnome-terminal if not already installed
if ! dpkg -l | grep -q gnome-terminal; then
    apt-get update
    apt-get install -y gnome-terminal
fi

# Download Docker Desktop DEB package
wget -O docker-desktop.deb https://desktop.docker.com/linux/debian/dists/stable/amd64/docker-desktop.deb

# Install Docker Desktop DEB package
apt-get update
apt-get install -y ./docker-desktop.deb

# Start Docker Desktop
systemctl --user start docker-desktop

echo "Docker Desktop installed and started successfully."
