#!/bin/bash

# Get path to new background image
new_path="$(cat ~/.config/waypaper/config.ini | grep "wallpaper =" | sed 's/wallpaper = ~//')"

# Generate color schemes for all templates
matugen image "$HOME"$new_path

# Set new wallpaper in hyprpanel for the internal matugen to generate the colorscheme
hyprpanel setWallpaper "$HOME"$new_path

# Generate theme for Chromium browsers
. "$(dirname "${BASH_SOURCE[0]}")"/generate_chromium.sh