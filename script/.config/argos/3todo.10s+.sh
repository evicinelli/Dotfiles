#! /bin/bash

source $HOME/Dotfiles/script/bin/todo

tdn=$(todo-ls | wc -l)
tdun=$(todo-ls | grep "^(" | wc -l)

txt="$tdn, $tdun!"
if [[ $tdun -gt 0 ]]; then
    echo "$txt | color='red'"
elif [[ $tdn -gt 0 ]]; then
    echo "$txt | color='yellow'"
else
    echo "$txt | color='light green'"
fi

if [[ $ARGOS_MENU_OPEN ]]; then
    IFS=$'\n'
    echo "---"
    if [[ $tdn -gt 0 ]]; then
        for f in $(todo-ls); do
            echo "$f | bash='source ~/Dotfiles/script/bin/todo && todo-done \"$f\"' terminal='false'"
        done
    else
        echo "Relax <3"
    fi
    echo "---"
    echo "@gvs"
    gvs="$(todo-ls | grep @gvs)"
    for l in $gvs; do echo "--$l"; done
    echo "Urgent"
    for l in $(todo-ls | grep "^(A)"); do echo "--$l"; done
    echo -e "Done"
    for l in $(cat $TD | grep "^x `date +%F`"); do echo "--$l"; done
    echo -e "PAST"
    for l in $(todo-ls past); do echo "--$l"; done
fi
