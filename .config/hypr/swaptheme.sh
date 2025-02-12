#!/bin/bash

# new background
new_path="$(cat ~/.config/waypaper/config.ini | grep "wallpaper =" | sed 's/wallpaper = ~//')"

echo "$HOME"$new_path

wal -n -i "$HOME"$new_path --backend haishoku --saturate 0.82

. "$(dirname "${BASH_SOURCE[0]}")"/generate_chromium.sh

hyprpanel useTheme ".cache/wal/colors-hyprpanel.json"