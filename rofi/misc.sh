#! /bin/bash

declare -a commands=(
    "i3 border toggle #i3 border toggle"
    "i3 floating toggle; i3 sticky toggle #sticky window"
    "firefox https://web.whatsapp.com && i3 [class = "Firefox*"] focus #whatsapp web"
    "/home/vic/Scaricati/Apps/gtd/gtd -n 25 5 #pomodoro"
    "gksudo service network-manager restart #nmr"
)
toExecute=$(for i in ${!commands[*]}; do echo ${commands[i]}; done | rofi -dmenu -i -p "Wokflows ")
eval $toExecute
