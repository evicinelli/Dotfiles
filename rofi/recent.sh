#! /bin/bash

xdg-open $(find ~ -type f -mtime -7 -not -path "*.git*" | rofi -matching regex -dmenu -i -p "Recent ")
