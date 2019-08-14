#! /bin/bash

perc="$(acpi -V | grep -vi "unavailable" | head -n1 | cut -d"," -f2 | sed "s/%//")"
# status="$(`acpi -V | grep Charging` && echo ↑ || echo ↓)"
txt="🔋 $perc % $status"

if [[ $perc -le 25 ]]; then
    echo "$txt | color='red'"
elif [[ $perc -le "50" ]]; then 
    echo "$txt" "| color='yellow'"
else
    echo "$txt" " | color='light green'"
fi
echo "---"
if [[ $ARGOS_MENU_OPEN ]]; then
    acpi -V | grep "\(Battery\|Adapter\|Thermal\)" | grep -v "trip point"
fi
