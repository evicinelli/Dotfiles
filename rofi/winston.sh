#!/usr/bin/env bash
# author: unknown
# sentby: MoreChannelNoise (https://www.youtube.com/user/MoreChannelNoise)
# editby: gotbletu (https://www.youtube.com/user/gotbletu)

# demo: https://www.youtube.com/watch?v=kxJClZIXSnM
# info: this is a script to launch other rofi scripts,
#       saves us the trouble of binding multiple hotkeys for each script,
#       when we can just use one hotkey for everything.

# FUNZIONAMENTO
# Con l'opzione autoselect di rofi lo si rende praticamente uguale al sistema
# di parole chiave con cui lavora alfred per mac: 
# - a  - applicazioni
# - f  - file
# - b  - binari                                                                          
# - wi - finestre aperte                                                                 
# w - ww - ricerca sul www (con duckduckgo + bangs si cerca in praticamente qualsiasi sito)
###

declare -A LABELS
declare -A COMMANDS
# List of defined 'bangs'
# launch programs
COMMANDS["apps"]="rofi -no-levenshtein-sort -combi-modi window,drun -show combi"
LABELS["apps"]=""

# find files
COMMANDS["file"]="/home/$(whoami)/Dotfiles/rofi/file.sh"
LABELS["file"]=""

# open custom www searches
COMMANDS["www"]="/home/$(whoami)/Dotfiles/rofi/web.sh"
LABELS["www"]=""

# bins
COMMANDS["bin"]="rofi -show run -no-levenshtein-sort"
LABELS["bin"]=""

# Pass
COMMANDS["password"]="~/Dotfiles/rofi/pass.sh"
LABELS["password"]="prova"

# Recent
 COMMANDS["recent"]="~/Dotfiles/rofi/recent.sh"
 LABELS["recent"]=""

# Utils
COMMANDS["utils"]="~/Dotfiles/rofi/misc.sh"
LABELS["utils"]=""

################################################################################
# do not edit below
################################################################################
##
# Generate menu
##
function print_menu()
{
    for key in ${!LABELS[@]}
    do
        echo "$key    ${LABELS}" # ${LABELS[$key]}"
    done
}
##
# Show rofi.
##
function start()
{
    print_menu | sort | rofi -dmenu -i -p "Winston ▶ " -matching fuzzy -lines ${#LABELS[*]} -auto-select
}


# Run it
value="$(start)"

# Split input.
# grab upto first space.
choice=${value%%\ *}
# graph remainder, minus space.
input=${value:$((${#choice}+1))}

##
# Cancelled? bail out
##
if test -z ${choice}
then
    exit
fi

# check if choice exists
if test ${COMMANDS[$choice]+isset}
then
    # Execute the choice
    eval echo "Executing: ${COMMANDS[$choice]}"
    eval ${COMMANDS[$choice]}
else
    eval  $choice | rofi
    # prefer my above so I can use this same script to also launch apps like geany or leafpad etc (DK) 
    #   echo "Unknown command: ${choice}" | rofi -dmenu -p "error"
fi
