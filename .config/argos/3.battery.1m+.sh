#! /usr/bin/env bash

BATTERY_FILE=/sys/class/power_supply/BAT0/uevent

# Get battery info
source $BATTERY_FILE
IFS=$'\n'

BAT_HI_COLOR=MediumSeaGreen
BAT_OK_COLOR=Orange
BAT_LO_COLOR=Crimson
BAT_UP_COLOR=SkyBlue

# if [[ $POWER_SUPPLY_CAPACITY -gt 50 ]]; then 
#     COLOR=$BAT_HI_COLOR
# elif [[ $POWER_SUPPLY_CAPACITY -gt 20 ]]; then
#     COLOR=$BAT_OK_COLOR
# else
#     COLOR=$BAT_LO_COLOR
#     if [[ $POWER_SUPPLY_CAPACITY -le $BAT_TRESHOLD ]] && [[ $POWER_SUPPLY_STATUS == "Discharging" ]]; then
#         echo $(acpi -V | head -n1 | cut -d, -f3)
#     fi
# fi

[[ $POWER_SUPPLY_STATUS == "Charging" ]] && STATUS=▲ || STATUS=▼

echo "⚡️ $POWER_SUPPLY_CAPACITY % $STATUS"

echo "---"

if [[ $ARGOS_MENU_OPEN="true" ]]; then
	acpi -V | grep "Battery"
	echo "---"
	sensors | grep "°C"
	echo "---"
	nvidia-smi -q -d temperature | grep "Current Temp" | head -n 1 | sed "s/\ *GPU/GPU/"
fi

