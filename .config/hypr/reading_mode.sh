#!/usr/bin/env bash

# Path to shader
SHADER="grayscale"

# Check active shader
if hyprshade current | grep -q "grayscale"; then
    # Deactivate and Reload
    hyprshade off
    hyprctl reload
    blight set 60%
else
    # ACTIVATES
    hyprshade on "$SHADER"
    blight set 37% 
    hyprctl keyword decoration:dim_inactive 0
fi