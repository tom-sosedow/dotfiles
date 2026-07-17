##!/bin/bash
#
#if [ x"$@" = x"Schließen" ]; then
#  exit 0
#elif [[ x"$@" = x"Aktivieren" ]]; then
#  nmcli con up id us-free-13.protonvpn.tcp
#fi
#
#echo "Aktivieren"
#echo "Schließen"

#!/usr/bin/env bash

set -euo pipefail

# -----------------------------
# Configuration
# -----------------------------

VPN_ID="us-free-13.protonvpn.tcp"

# Format: "Title|URL"
BOOKMARKS=(
  "Xena|https://serienstream.to/serie/xena/staffel-2"
  "Blindspot|https://serienstream.to/serie/blindspot"
  "Blue Lock|https://aniworld.to/anime/stream/blue-lock"
)

# -----------------------------
# Rofi mode
# -----------------------------

if [[ $# -eq 0 ]]; then
  for entry in "${BOOKMARKS[@]}"; do
    printf '%s\n' "${entry%%|*}"
  done
  exit 0
fi

selection="$1"

url=""

for entry in "${BOOKMARKS[@]}"; do
  title="${entry%%|*}"
  link="${entry#*|}"

  if [[ "$title" == "$selection" ]]; then
    url="$link"
    break
  fi
done

[[ -n "$url" ]] || exit 1

# -----------------------------
# Connect VPN
# -----------------------------

if ! nmcli con up id "$VPN_ID"; then
  notify-send "VPN" "Failed to connect to '$VPN_ID'"
  exit 1
fi

# -----------------------------
# Launch Firefox
# -----------------------------

firefox \
  --private-window \
  "$url" &
