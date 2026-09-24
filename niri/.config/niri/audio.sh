#!/bin/bash

# List available sinks with human-readable descriptions
sinks=$(pactl --format json list sinks | jq -r '.[] | "\(.description)\t\(.name)"')
selected=$(echo "$sinks" | fuzzel --dmenu)

# Extract the sink name (second field, after tab) and set as default
if [ -n "$selected" ]; then
    selected_name=$(echo "$selected" | cut -f2)
    pactl set-default-sink "$selected_name"
fi
