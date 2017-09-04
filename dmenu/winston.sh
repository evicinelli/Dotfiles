#!/usr/bin/env bash
# author: unknown
# sentby: MoreChannelNoise (https://www.youtube.com/user/MoreChannelNoise)
# editby: gotbletu (https://www.youtube.com/user/gotbletu)

# demo: https://www.youtube.com/watch?v=kxJClZIXSnM

declare -A LABELS
declare -A COMMANDS
# List of defined 'bangs'
# launch programs
COMMANDS["Apps"]="i3-dmenu-desktop -dmenu="dmenu -i -p "Apps" -fn "Inconsolata-13"""
LABELS["Apps"]=""

# find files
COMMANDS["File"]="/home/$(whoami)/Dotfiles/dmenu/file.sh"
LABELS["File"]=""

# open custom web searches
COMMANDS["Web"]="/home/$(whoami)/Dotfiles/dmenu/web.sh"
LABELS["Web"]=""

# clipboard manager
COMMANDS["Clipboard"]="bash /home/$(whoami)/Dotfiles/dmenu/clipmenu/clipmenu -i -p "Clipboard" -fn "Inconsolata""
LABELS["Clipboard"]=""

# bins
COMMANDS["Bin"]="dmenu_run -fn "Inconsolata-13""
LABELS["Bin"]=""

################################################################################
# do not edit below
################################################################################

function print_menu()
{
    for key in ${!LABELS[@]}
    do
    echo "$key    ${LABELS}"
    done
}

function start()
{
    print_menu | dmenu -i -p "Winston" -fn "Inconsolata-13" 
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
