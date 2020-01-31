#! /usr/bin/env bash

IFS=$'\n'
color="green"
todos=($(todo ls | sort -n))
urgent=($(todo urgent))

[[ ${#todos[*]} -gt 0 ]] && color="yellow"
[[ ${#urgent[*]} -gt 0 ]] && color="red"

echo "<span color=\"$color\"> ${#todos[*]}, ${#urgent[*]}!</span>"

echo "---"

for t in ${todos[*]}; do
    if [[ $t =~ ^\( ]]; then
        color="red"
    elif [[ $t =~ .*@gvs.* ]]; then
        color="#139"
    else
        color="black"
    fi
    echo "$t | bash='todo done \"$t\"' terminal=false refresh=true color=$color"
done

echo "--"

echo "Edit todo file | bash='kitty nvim /home/vic/pCloudDrive/Documenti/Todo/todo.txt'"
