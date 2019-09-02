#! /usr/bin/env bash

BATTERY_FILE=/sys/class/power_supply/BAT0/uevent

# Get battery info
source $BATTERY_FILE

if [[ $POWER_SUPPLY_CAPACITY -gt 50 ]]; then 
    COLOR=lightgreen
elif [[ $POWER_SUPPLY_CAPACITY -gt 30 ]]; then
    COLOR=yellow
else
    COLOR=red
fi
if [[ $POWER_SUPPLY_STATUS == "Charging" ]]; then COLOR=cyan; fi

echo "⚡️ $POWER_SUPPLY_CAPACITY % | color=$COLOR"
echo "---"
acpi -V | grep -v "no state information available" | grep -v "Cooling"
