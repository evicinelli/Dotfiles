#! /bin/bash

(
#cd $NOTES
base_dir="$1"
cd $base_dir
shift
note=`fzf -1 --header="$base_dir" --preview='head -$LINES {}' --print-query --query="$*"`
if [[ $? -eq 0 ]]; then
    # edit note
    $EDITOR "`tail -n1 <<< "$note"`"
elif [[ $? -eq 1 ]]; then
    # add new note
    touch "$note.md"
    $EDITOR "$note.md"
fi
)
