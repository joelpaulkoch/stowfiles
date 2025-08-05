#!/bin/bash

SCHEMA="org.gnome.desktop.interface"
KEY="color-scheme"

CURRENT_SCHEME=$(gsettings get $SCHEMA $KEY)

if [[ $CURRENT_SCHEME == "'default'" || $CURRENT_SCHEME == "'prefer-light'" ]]; then
    gsettings set $SCHEMA $KEY "'prefer-dark'"
else
    gsettings set $SCHEMA $KEY "'default'"
fi

