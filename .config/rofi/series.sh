#!/usr/bin/env bash

set -euo pipefail


# -----------------------------
# Configuration
# -----------------------------

VPN_ID="us-free-13.protonvpn.tcp"
BOOKMARK_FOLDER="Strim"


firefoxbookmarks() {
  mkdir -p /tmp/bookmark/ && \
  cp ~/.mozilla/firefox/qudq071a.default-release/places.sqlite /tmp/bookmark && \
  sqlite3 -tabs /tmp/bookmark/places.sqlite \
    "select moz_places.url, moz_bookmarks.title
            from moz_bookmarks
            join moz_places on moz_bookmarks.fk = moz_places.id
            where moz_bookmarks.parent = (
                select id from moz_bookmarks
                where title = '$BOOKMARK_FOLDER'
            )" && \
  rm /tmp/bookmark/places.sqlite
}

declare -A URLS
titles=()

url=""
title=""

while IFS=$'\t' read -r url title; do
    title="${title%\"}"
    title="${title#\"}"
    titles+=("$title")
    URLS["$title"]="$url"
done < <(firefoxbookmarks | tac)

# ------------------------------------------------------------
# Rofi mode
# ------------------------------------------------------------

if [[ $# -eq 0 ]]; then
    printf '%s\n' "${titles[@]}"
    exit 0
fi

selection="$1"
url="${URLS[$selection]:-}"

[[ -n "$url" ]] || exit 1

# ------------------------------------------------------------
# Connect VPN (if necessary)
# ------------------------------------------------------------

if ! nmcli -t -f NAME con show --active | grep -Fxq "$VPN_ID"; then
    if ! nmcli con up id "$VPN_ID"; then
        notify-send "VPN" "Failed to connect"
        exit 1
    fi
fi

# ------------------------------------------------------------
# Launch Firefox
# ------------------------------------------------------------

firefox \
    --private-window \
    "$url" &
