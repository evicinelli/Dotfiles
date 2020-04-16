#! /usr/bin/env bash

BATTERY_FILE=/sys/class/power_supply/BAT0/uevent

# Get battery info
source $BATTERY_FILE
IFS=$'\n'

if [[ $POWER_SUPPLY_CAPACITY -gt 50 ]]; then 
    COLOR=lightgreen
elif [[ $POWER_SUPPLY_CAPACITY -gt 20 ]]; then
    COLOR=yellow
else
    COLOR=red
    if [[ $POWER_SUPPLY_CAPACITY -le 15 ]] && [[ $POWER_SUPPLY_STATUS == "Discharging" ]]; then
        echo $(acpi -V | head -n1 | cut -d, -f3)
    fi
fi
if [[ $POWER_SUPPLY_STATUS == "Charging" ]]; then COLOR=cyan; fi

echo "⚡️ $POWER_SUPPLY_CAPACITY % | color=$COLOR"
echo "---"
for line in $(acpi -V | grep "Battery"); do
    echo "$line | font=Monospace"
done

echo "---"

echo "Temp"

for line in $(sensors); do
    echo "$line | font=Monospace"
done

