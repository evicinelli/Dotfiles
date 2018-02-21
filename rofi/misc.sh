#! /bin/bash

declare -a commands;
commands=(
    "i3 border toggle"
    "systemctl reboot"
    "systemctl poweroff"
)
toExecute=$(echo $commands | rofi -dmenu -i)
eval $toExecute
