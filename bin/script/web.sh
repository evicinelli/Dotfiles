#! /bin/bash
# web
/home/vic/Scaricati/Apps/Firefox\ Dev/firefox "https://duckduckgo.com/?q=$(rofi -dmenu -p "Web ")"
i3 [class = "Firefox*"] focus
