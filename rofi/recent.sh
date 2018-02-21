#! /bin/bash

xdg-open $(find ~ -type f -mtime -7 -not -path "*.git*" | rofi -matching regeregex -dmenu -i -p "Recent ")
