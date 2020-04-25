#! /usr/bin/env bash

BATTERY_FILE=/sys/class/power_supply/BAT0/uevent

# Get battery info
source $BATTERY_FILE
IFS=$'\n'

BAT_HI_COLOR=MediumSeaGreen
BAT_OK_COLOR=Orange
BAT_LO_COLOR=Crimson
BAT_UP_COLOR=SkyBlue


echo $BAT_TRESHOLD

if [[ $POWER_SUPPLY_CAPACITY -gt 50 ]]; then 
    COLOR=$BAT_HI_COLOR
elif [[ $POWER_SUPPLY_CAPACITY -gt 20 ]]; then
    COLOR=$BAT_OK_COLOR
else
    COLOR=$BAT_LO_COLOR
    if [[ $POWER_SUPPLY_CAPACITY -le $BAT_TRESHOLD ]] && [[ $POWER_SUPPLY_STATUS == "Discharging" ]]; then
        echo $(acpi -V | head -n1 | cut -d, -f3)
    fi
fi
if [[ $POWER_SUPPLY_STATUS == "Charging" ]]; then COLOR=$BAT_UP_COLOR; fi

echo "⚡️ $POWER_SUPPLY_CAPACITY % | color=$COLOR"
echo "---"
for line in $(acpi -V | grep "Battery"); do
    echo "$line | font=Monospace color=$COLOR"
done

echo "---"

for line in $(sensors | grep "Adapter\|°C"); do
    echo "$line | font=Monospace color=gray"
done

