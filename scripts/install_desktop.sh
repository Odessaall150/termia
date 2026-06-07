#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Jordi Pons
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail

# Install a user-local desktop launcher that points to this source checkout.
APP_ID="local.termia"
APP_NAME="Termia"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_SCRIPT="${PROJECT_DIR}/run_termia.py"
APP_ICON_SOURCE="${PROJECT_DIR}/src/termia/assets/termia.svg"
DATA_HOME="${XDG_DATA_HOME:-"${HOME}/.local/share"}"
DESKTOP_DIR="${DATA_HOME}/applications"
ICON_DIR="${DATA_HOME}/icons/hicolor/scalable/apps"
DESKTOP_FILE="${DESKTOP_DIR}/${APP_ID}.desktop"
ICON_FILE="${ICON_DIR}/${APP_ID}.svg"

if [[ ! -f "${APP_SCRIPT}" ]]; then
  echo "Could not find ${APP_SCRIPT}" >&2
  exit 1
fi
if [[ ! -f "${APP_ICON_SOURCE}" ]]; then
  echo "Could not find ${APP_ICON_SOURCE}" >&2
  exit 1
fi

# Keep installation user-local; no root privileges are required.
mkdir -p "${DESKTOP_DIR}" "${ICON_DIR}"
chmod +x "${APP_SCRIPT}"
cp "${APP_ICON_SOURCE}" "${ICON_FILE}"
chmod 0644 "${ICON_FILE}"

# Desktop entries use an absolute launcher path, so reinstall after moving the clone.
cat > "${DESKTOP_FILE}" <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=${APP_NAME}
Comment=SSH connection manager with embedded terminals
Exec=python3 ${APP_SCRIPT}
Path=${PROJECT_DIR}
Icon=${APP_ID}
Terminal=false
Categories=Network;RemoteAccess;GTK;
StartupNotify=true
StartupWMClass=${APP_ID}
EOF

chmod 0644 "${DESKTOP_FILE}"
# Refresh caches when the optional desktop utilities are available.
if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "${DESKTOP_DIR}" >/dev/null 2>&1 || true
fi
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
  gtk-update-icon-cache -f -t "${DATA_HOME}/icons/hicolor" >/dev/null 2>&1 || true
fi

echo "Installed: ${DESKTOP_FILE}"
