#! /bin/bash

perc="$(acpi -V | grep -vi "unavailable" | head -n1 | cut -d"," -f2 | sed "s/%//")"
txt="🔋 $perc %"

if [[ $perc -le 20 ]]; then
    echo "$txt | color='red'"
elif [[ $perc -le "50" ]]; then 
    echo "$txt | color='yellow'"
else
    echo "$txt | color='light green'"
fi
echo "---"
if [[ $ARGOS_MENU_OPEN ]]; then
    acpi -V | grep "\(Battery\|Adapter\|Thermal\)" | grep -v "trip point"
fi
