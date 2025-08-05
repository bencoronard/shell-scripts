#!/bin/bash

# Auto-elevate
if [ "$EUID" -ne 0 ]; then
  echo "🔒 Re-running with sudo..."
  exec sudo "$0" "$@"
fi

echo "⛔ Stopping docker.service..."
systemctl stop docker.service
systemctl disable docker.service

echo "⛔ Stopping docker.socket..."
systemctl stop docker.socket
systemctl disable docker.socket
systemctl mask docker.socket

echo "⛔ Stopping containerd..."
systemctl stop containerd

echo
echo "🔍 docker.service: $(systemctl is-active docker)"
echo "🔍 docker.socket:  $(systemctl is-active docker.socket)"
