#! /usr/bin/env bash

IFS=$'\n'

powered="$(bluetoothctl show | grep Powered | sed "s,\tPowered: ,,")"
[[ $powered == "yes" ]] && color="white" || color="gray"
echo "B | color=$color"

if [[ $ARGOS_MENU_OPEN == "true" ]]; then
    echo "---"

    devices=($(bluetoothctl paired-devices | cut -d' ' -f3-))
    bluetooth_id=$(rfkill list | grep Bluetooth | grep hci0 | cut -d: -f1)

    for device in ${devices[*]}; do
        echo "$device | bash=\"rfkill unblock $bluetooth_id && bluetoothctl power on && bluetoothctl connect $(bluetoothctl paired-devices | grep $device | cut -d' ' -f2)\""
    done

    echo "--"
    bluetoothctl show $(bluetoothctl list | grep default | cut -d' ' -f2) | head -n5

    echo "--"
    echo "Power off | bash='bluetoothctl power off' terminal=false refresh=true"
    echo "Power on | bash='rfkill unblock $bluetooth_id && bluetoothctl power on' terminal=false refresh=true"
fi
