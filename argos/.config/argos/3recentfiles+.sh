#! /usr/bin/env bash

echo "F"
echo "---"
if [[ $ARGOS_MENU_OPEN == "true" ]]; then
    IFS=$'\n'
    files=(find ~ -mtime="-3")
    echo $files
fi
