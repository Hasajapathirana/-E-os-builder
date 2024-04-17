#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Load KVM modules
modprobe kvm
modprobe kvm_intel  # For Intel processors
# Uncomment the line below if using AMD processors
# modprobe kvm_amd

# Check KVM module status
if ! lsmod | grep kvm; then
    echo "KVM modules not loaded properly"
    exit 1
fi

# Check ownership of /dev/kvm
if [[ ! -e /dev/kvm ]]; then
    echo "/dev/kvm not found"
    exit 1
fi

# Add user to kvm group
if ! getent group kvm | grep -q "\b$USER\b"; then
    usermod -aG kvm $USER
    echo "User added to kvm group. Please logout and login again."
    exit 0
fi

# Install Docker Desktop for Ubuntu
wget -O docker-desktop.deb https://desktop.docker.com/linux/debian/dists/stable/amd64/docker-desktop.deb
dpkg -i docker-desktop.deb
apt-get install -f

echo "Docker Desktop installed successfully. Launch it from your Applications menu."
