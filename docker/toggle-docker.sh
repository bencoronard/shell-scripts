#!/bin/bash

# Auto-elevate
if [ "$EUID" -ne 0 ]; then
  echo "🔒 Re-running with sudo..."
  exec sudo "$0" "$@"
fi

# Check current status
docker_status=$(systemctl is-active docker)

if [ "$docker_status" = "active" ]; then
    echo "🛑 Docker is running — stopping services..."

    systemctl stop docker.service
    systemctl disable docker.service

    systemctl stop docker.socket
    systemctl disable docker.socket
    systemctl mask docker.socket

    systemctl stop containerd

    echo "✅ Docker and dependencies stopped."
else
    echo "▶️ Docker is not running — starting services..."

    systemctl unmask docker.socket
    systemctl enable docker.socket
    systemctl start docker.socket

    systemctl enable docker.service
    systemctl start docker.service

    systemctl start containerd

    echo "✅ Docker and dependencies started."
fi

# Show final statuses
echo
echo "🔍 docker.service:  $(systemctl is-active docker)"
echo "🔍 docker.socket:   $(systemctl is-active docker.socket)"
echo "🔍 containerd:      $(systemctl is-active containerd)"
