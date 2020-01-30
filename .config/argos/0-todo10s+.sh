#! /usr/bin/env bash

IFS=$'\n'
color="green"
todos=($(todo ls))
urgent=($(todo urgent))

[[ ${#todos[*]} -gt 0 ]] && color="yellow"
[[ ${#urgent[*]} -gt 0 ]] && color="red"

echo "<span color=\"$color\"> ${#todos[*]}, ${#urgent[*]}!</span>"

echo "---"

for t in ${todos[*]}; do
    echo $t
done

echo "--"

echo "Edit todo file | bash='kitty nvim /home/vic/pCloudDrive/Documenti/Todo/todo.txt'"
