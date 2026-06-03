#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Jordi Pons
# SPDX-License-Identifier: MIT
set -euo pipefail

# Verify the Python introspection bindings required by the GTK application.
check_python_modules() {
  python3 - <<'PY_CHECK'
import sys

PACKAGE_HINTS = {
    "Gtk": "gir1.2-gtk-4.0",
    "Gdk": "gir1.2-gtk-4.0",
    "Pango": "gir1.2-pango-1.0",
    "Vte": "gir1.2-vte-3.91",
}


def fail(message):
    print(message, file=sys.stderr)
    print("Install Termia dependencies with: ./scripts/install_dependencies.sh", file=sys.stderr)
    print(
        "Debian/Ubuntu/Linux Mint package hint: sudo apt install python3-gi "
        "gir1.2-gtk-4.0 gir1.2-vte-3.91 python3-yaml openssh-client sshpass",
        file=sys.stderr,
    )
    print("Termia requires GTK 4 VTE (Vte 3.91); Vte 2.91 is not enough.", file=sys.stderr)
    sys.exit(1)


try:
    import gi
except ImportError:
    fail("Missing Python GObject bindings: python3-gi / python3-gobject is not installed.")

requirements = [
    ("Gtk", "4.0"),
    ("Gdk", "4.0"),
    ("Pango", "1.0"),
    ("Vte", "3.91"),
]
for namespace, version in requirements:
    try:
        gi.require_version(namespace, version)
    except ValueError:
        fail(
            f"Missing GObject namespace {namespace} {version}. "
            f"Install package: {PACKAGE_HINTS.get(namespace, 'distribution-specific package')}."
        )

try:
    from gi.repository import Gtk, Gdk, Pango, Vte
except (ImportError, ValueError) as exc:
    fail(f"Could not load GTK/VTE bindings: {exc}")

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
