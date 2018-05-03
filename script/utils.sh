#! /bin/bash
[[ -f ~/Dotfiles/dmenurc ]] && . ~/Dotfiles/dmenurc || DMENU=dmenu
declare -a commands=(
    "i3 border toggle #i3 border toggle"
    "i3 floating toggle; i3 sticky toggle #sticky window"
    "firefox https://web.whatsapp.com && i3 [class = "Firefox*"] focus #whatsapp web"
    "/home/vic/Scaricati/Apps/gtd/gtd -n 25 5 #pomodoro"
    "gksudo service network-manager restart #nmr"
    " firefox https://sites.google.com/a/vallelavino.it/area-soci/calendario-turni-zola-61 https://sites.google.com/a/vallelavino.it/area-soci/inserimento-turni https://sites.google.com/a/vallelavino.it/area-soci/calendari-turni/emanuele-vicinelli && i3 [class="Firefox"] focus #gvs #zola61 #ambulanza #turno"
    "redshift-gtk -x #reset #day"
    "redshift-gtk -O 2000 #red #night"
    "firefox --private-window #incognito"
)
toExecute=$(for i in ${!commands[*]}; do echo ${commands[$i]}; done | eval ${DMENU} -p "Utils " -l 8)
eval $toExecute
