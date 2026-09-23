#!/bin/bash

while true; do
    bluetoothctl power on >/dev/null

    # Get currently known devices
    devices=$(bluetoothctl devices)

    menu="󰂰  Scan for new devices\n"

    while read -r _ mac name; do
        [ -z "$mac" ] && continue

        connected=$(bluetoothctl info "$mac" 2>/dev/null |
            grep -q "Connected: yes" && echo yes || echo no)

        paired=$(bluetoothctl info "$mac" 2>/dev/null |
            grep -q "Paired: yes" && echo yes || echo no)

        if [ "$connected" = "yes" ]; then
            menu+="󰂱  $name  [Connected]\n"
        elif [ "$paired" = "yes" ]; then
            menu+="󰂯  $name  [Connect]\n"
        else
            menu+="󰂯  $name  [Pair]\n"
        fi
    done <<< "$devices"

    choice=$(printf '%b' "$menu" |
        fuzzel --dmenu --prompt "Bluetooth  ")

    [ -z "$choice" ] && exit

    # Scan for new devices
    if [[ "$choice" == "󰂰  Scan for new devices" ]]; then
        (
            bluetoothctl scan on >/dev/null 2>&1
            sleep 8
            bluetoothctl scan off >/dev/null 2>&1
        ) &

        # Show scanning message
        notify-send "Bluetooth" "Scanning for devices..."

        # Give bluetoothctl time to discover devices
        sleep 9
        continue
    fi

    # Remove icon and status to get the device name
    name="${choice#*  }"
    name="${name%  \[*}"

    # Find MAC address
    mac=$(bluetoothctl devices |
        grep -F " $name" |
        head -n1 |
        awk '{print $2}')

    [ -z "$mac" ] && continue

    # Disconnect
    if [[ "$choice" == *"[Connected]"* ]]; then
        bluetoothctl disconnect "$mac" >/dev/null
        notify-send "Bluetooth" "Disconnected: $name"

    # Pair
    elif [[ "$choice" == *"[Pair]"* ]]; then
        if bluetoothctl pair "$mac"; then
            bluetoothctl trust "$mac" >/dev/null 2>&1
            bluetoothctl connect "$mac" >/dev/null 2>&1
            notify-send "Bluetooth" "Connected: $name"
        else
            notify-send "Bluetooth" "Failed to pair: $name"
        fi

    # Connect
    else
        if bluetoothctl connect "$mac"; then
            notify-send "Bluetooth" "Connected: $name"
        else
            notify-send "Bluetooth" "Failed to connect: $name"
        fi
    fi
done

