#!/bin/bash

# Initialize
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import scripts
source "$SCRIPT_DIR/../common/control.sh"

# Auto-elevate
auto_elevate "$@"

echo "Running as root: $(whoami)"