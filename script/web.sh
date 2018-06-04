#! /bin/bash
# web
[[ -f ~/Dotfiles/dmenurc ]] && . ~/Dotfiles/dmenurc || DMENU=dmenu
/home/vic/Scaricati/Apps/Firefox\ Dev/firefox "https://duckduckgo.com/?q=$(cat /home/vic/ownCloud/Archivio/ddgbangs.txt | eval ${DMENU} -p "Web ")"
i3 [class = "Firefox*"] focus
