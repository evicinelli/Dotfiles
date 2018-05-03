#!/usr/bin/env bash
# author: unknown
# sentby: MoreChannelNoise (https://www.youtube.com/user/MoreChannelNoise)
# editby: gotbletu (https://www.youtube.com/user/gotbletu)

# demo: https://www.youtube.com/watch?v=kxJClZIXSnM
# info: this is a script to launch other scripts via dmenu,
#       saves us the trouble of binding multiple hotkeys for each script,
#       when we can just use one hotkey for everything.
###
[[ -f ~/Dotfiles/dmenurc ]] && . ~/Dotfiles/dmenurc || DMENU=dmenu
declare -A LABELS
declare -A COMMANDS
COMMANDS["apps"]="i3-dmenu-desktop --dmenu='${DMENU}'"
LABELS["apps"]=""

# find files
COMMANDS["file"]="/home/$(whoami)/Dotfiles/script/file.sh"
LABELS["file"]=""

# open custom www searches
COMMANDS["www"]="/home/$(whoami)/Dotfiles/script/web.sh"
LABELS["www"]=""

# Pass
COMMANDS["password"]="~/Dotfiles/script/pass.sh"
LABELS["password"]="prova"
# Utils
COMMANDS["utils"]="~/Dotfiles/script/utils.sh"
LABELS["utils"]=""

function print_menu()
{
    for key in ${!LABELS[@]}
    do
        echo "$key    ${LABELS}" # ${LABELS[$key]}"
    done
}

function start()
{
    print_menu | sort | eval ${DMENU} -p "Winston "
}


# Run it
value="$(start)"

# Split input.
# grab upto first space.
choice=${value%%\ *}
# graph remainder, minus space.
input=${value:$((${#choice}+1))}

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
    eval  $choice | eval ${DMENU}
fi
