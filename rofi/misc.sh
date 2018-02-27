#! /bin/bash

declare -a commands=(
    "i3 border toggle"
    "firefox https://web.whatsapp.com && i3 [class = "Firefox*"] focus"
)
toExecute=$(for i in ${!commands[*]}; do echo ${commands[i]}; done | rofi -dmenu -i -p "Wokflows ")
eval $toExecute
