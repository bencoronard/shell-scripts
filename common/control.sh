auto_elevate() {
  if [ "$EUID" -ne 0 ]; then
    echo "🔒 Re-running with sudo..."
    exec sudo -E "$SHELL" "$(realpath "$0")" "$@"
  fi
}