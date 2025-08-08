#!/bin/bash

refresh_workspace() {
    # Get the connected monitors
    CONNECTED=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

    # Identify external monitor (anything not eDP-1)
    EXTERNAL=""
    for m in $CONNECTED; do
        if [[ "$m" != "eDP-1" ]]; then
            EXTERNAL=$m
            break
        fi
    done

    # Fallback if no external monitor is found
    if [[ -z "$EXTERNAL" ]]; then
        echo "No external monitor connected."
        exit 0
    fi

    # Assign workspaces 6–0 to the external monitor
    for ws in 6 7 8 9 0; do
        hyprctl dispatch moveworkspacetomonitor "$ws $EXTERNAL"
        echo "Moved workspace $ws to monitor $EXTERNAL"
    done
}


handle() {
  case $1 in
    monitoradded*) refresh_workspace ;;
    monitorremoved*) refresh_workspace ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done