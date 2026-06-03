#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Jordi Pons
# SPDX-License-Identifier: MIT
set -euo pipefail

# Verify the Python introspection bindings required by the GTK application.
check_python_modules() {
  python3 - <<'PY_CHECK'
import gi
gi.require_version("Gtk", "4.0")
gi.require_version("Gdk", "4.0")
gi.require_version("Pango", "1.0")
gi.require_version("Vte", "3.91")
from gi.repository import Gtk, Gdk, Pango, Vte
print("Python/GTK dependencies OK")
PY_CHECK
}

# Check-only mode is useful for development and troubleshooting.
if [[ "${1:-}" == "--check" ]]; then
  check_python_modules
  command -v ssh >/dev/null || { echo "Missing ssh in PATH" >&2; exit 1; }
  command -v sshpass >/dev/null || { echo "Missing sshpass in PATH" >&2; exit 1; }
  echo "ssh and sshpass clients OK"
  exit 0
fi

# Install equivalent system packages for the detected Linux distribution.
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y \
    python3 \
    python3-gi \
    python3-yaml \
    gir1.2-gtk-4.0 \
    gir1.2-vte-3.91 \
    openssh-client \
    sshpass \
    desktop-file-utils
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y \
    python3 \
    python3-gobject \
    python3-pyyaml \
    gtk4 \
    vte291-gtk4 \
    openssh-clients \
    sshpass \
    desktop-file-utils
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed \
    python \
    python-gobject \
    python-yaml \
    gtk4 \
    vte4 \
    openssh \
    sshpass \
    desktop-file-utils
else
  echo "Could not detect apt-get, dnf, or pacman." >&2
  echo "Install manually: Python 3, PyGObject, GTK 4, VTE GTK 4, openssh-client, sshpass, and desktop-file-utils." >&2
  exit 1
fi

check_python_modules
command -v ssh >/dev/null || { echo "Missing ssh in PATH" >&2; exit 1; }
command -v sshpass >/dev/null || { echo "Missing sshpass in PATH" >&2; exit 1; }
echo "ssh and sshpass clients OK"
echo "Dependencies installed successfully"
