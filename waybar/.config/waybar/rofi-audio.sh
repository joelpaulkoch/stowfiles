#!/bin/bash

# List available sinks and let the user select one
sinks=$(pactl --format json list sinks | jq -r 'map(.name) | .[]')
selected=$(echo "$sinks" | rofi -dmenu -i)

# Set the selected sink as the default
if [ -n "$selected" ]; then
    pactl set-default-sink "$selected"
fi
