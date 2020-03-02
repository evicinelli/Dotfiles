#! /usr/bin/env bash

IFS=$'\n'

printmono(){
    for line in $*; do
        echo "$line | font=Monospace"
    done
}

powered="$(bluetoothctl show | grep Powered | sed "s,\tPowered: ,,")"
[[ $powered == "yes" ]] && color="white" || color="gray"
[[ $(bluetoothctl info | grep "Paired" | awk -F': ' '{print $2}') == "yes" ]] && label="∙B∙" || label="B"
echo "$label | color=$color refresh=true"

if [[ $ARGOS_MENU_OPEN == "true" ]]; then
    echo "---"

    devices=($(bluetoothctl paired-devices | cut -d' ' -f3-))
    # bluetooth_id=$(rfkill list | grep Bluetooth | grep hci0 | cut -d: -f1)

    for device in ${devices[*]}; do
        echo "$device | bash=\"bluetoothctl power on && bluetoothctl connect $(bluetoothctl paired-devices | grep $device | cut -d' ' -f2)\" refresh=true"
    done

    echo "--"
    printmono "$(bluetoothctl show $(bluetoothctl list | grep default | cut -d' ' -f2) | head -n5)"

    echo "--"
    echo "Power off | bash='bluetoothctl power off' terminal=false refresh=true"
    echo "Power on | bash='bluetoothctl power on' terminal=false refresh=true"
fi
