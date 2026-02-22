#!/bin/bash

swaymsg -mrt subscribe '["input"]' | jq -r --unbuffered 'select(.change == "xkb_keymap") | .input | select(.name == "Telink Trust Input Device") | .xkb_active_layout_name | .[0:2]' | uniq
