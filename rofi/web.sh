#! /bin/bash
# web
/home/vic/Scaricati/Apps/Firefox\ Dev/firefox "https://duckduckgo.com/?q=$(cat /home/vic/ownCloud/Archivio/ddgbangs.txt| rofi -dmenu -p "Web ")"
i3 [class = "Firefox*"] focus
