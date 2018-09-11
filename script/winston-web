#! /bin/bash
# web
[[ -f ~/Dotfiles/dmenurc ]] && . ~/Dotfiles/dmenurc || DMENU=dmenu
chromium --app "https://duckduckgo.com/?q=$(cat /home/vic/ownCloud/Archivio/ddgbangs.txt | eval ${DMENU} -p "Web ")"
i3 [class = "Chromium"] focus
