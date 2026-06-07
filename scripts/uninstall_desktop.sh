#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Jordi Pons
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail

# Remove only user-local launcher files; preserve settings and connections.
APP_ID="local.termia"
DATA_HOME="${XDG_DATA_HOME:-"${HOME}/.local/share"}"
DESKTOP_DIR="${DATA_HOME}/applications"
ICON_DIR="${DATA_HOME}/icons/hicolor/scalable/apps"
DESKTOP_FILE="${DESKTOP_DIR}/${APP_ID}.desktop"

# Removing missing files is intentionally harmless.
rm -f "${DESKTOP_FILE}" "${ICON_DIR}/${APP_ID}.svg"

# Refresh caches when the optional desktop utilities are available.
if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "${DESKTOP_DIR}" >/dev/null 2>&1 || true
fi
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
  gtk-update-icon-cache -f -t "${DATA_HOME}/icons/hicolor" >/dev/null 2>&1 || true
fi

echo "Removed: ${DESKTOP_FILE}"
