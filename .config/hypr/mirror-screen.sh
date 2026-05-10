#!/usr/bin/env bash

STATE_FILE="/tmp/screen-mirror-state"

if [[ -f "$STATE_FILE" ]]; then
    # Currently ON → turn OFF
    rm "$STATE_FILE"
    hyprctl keyword monitor ,preferred,auto-center-up,1
    hyprctl reload
else
    # Currently OFF → turn ON
    touch "$STATE_FILE"
    hyprctl keyword monitor ,preferred,auto-center-up,1,mirror,eDP-1
fi