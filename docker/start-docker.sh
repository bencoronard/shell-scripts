#!/bin/bash

# Auto-elevate
if [ "$EUID" -ne 0 ]; then
  echo "🔒 Re-running with sudo..."
  exec sudo "$0" "$@"
fi

echo "▶️ Starting containerd..."
systemctl start containerd

echo "▶️ Starting docker.socket..."
systemctl unmask docker.socket 2>/dev/null
systemctl enable docker.socket
systemctl start docker.socket

echo "▶️ Starting docker.service..."
systemctl enable docker.service
systemctl start docker.service

echo
echo "🔍 docker.service: $(systemctl is-active docker)"
echo "🔍 docker.socket:  $(systemctl is-active docker.socket)"
