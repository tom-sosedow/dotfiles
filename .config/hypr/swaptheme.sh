#!/bin/bash

waypaper --random

new_background="$(cat ~/.config/waypaper/config.ini | grep "wallpaper =" | sed 's/wallpaper = //')"

wpg -a "$new_background" --sat 0.4 --backend colorz
wpg -ns "$new_background"
pywalfox update

#killall -SIGUSR2 waybar