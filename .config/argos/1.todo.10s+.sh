#! /usr/bin/env bash

PATH=$PATH:$HOME/.bin
IFS=$'\n'
color="MediumSeaGreen"
todos=($(TD=~/pCloudDrive/Documenti/Todo/todo.txt todo ls | sort -n))
urgent=($(TD=~/pCloudDrive/Documenti/Todo/todo.txt todo urgent))

[[ ${#todos[*]} -gt 0 ]] && color="Orange"
[[ ${#urgent[*]} -gt 0 ]] && color="Crimson"

echo "<span color=\"$color\"> ${#todos[*]}, ${#urgent[*]}!</span>"


echo "---"

if [[ $ARGOS_MENU_OPEN == "true" ]]; then
    for t in ${todos[*]}; do
        if [[ $t =~ ^\( ]]; then
            color="Crimson"
        elif [[ $t =~ .*@gvs.* ]]; then
            color="RoyalBlue"
	elif [[ $t =~ .*@med.* ]]; then
	    color="Tomato"
        else
            color="white"
        fi
        echo "<span color=\"$color\">$t </span> | bash='TD=~/pCloudDrive/Documenti/Todo/todo.txt todo done \"$t\"' refresh=true terminal=false"
    done

    for t in $(TD=~/pCloudDrive/Documenti/Todo/todo.txt todo done); do
        echo "$t | color=gray"
    done

    echo "--"

    echo "Edit todo file | bash='${EDITOR:-vim} /home/vic/pCloudDrive/Documenti/Todo/todo.txt'"
fi
