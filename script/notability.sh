#! /bin/bash

(
#cd $NOTES
cd $*
note=`fzf --print-query`
if [[ $? -eq 0 ]]; then
    # edit note
    $EDITOR "`tail -n1 <<< "$note"`"
elif [[ $? -eq 1 ]]; then
    # add new note
    touch "$note.md"
    $EDITOR "$note.md"
fi
)
