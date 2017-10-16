# find files
xdg-open "$(find /home/$(whoami) /tmp /media/$(whoami) -not -path "/home/$(whoami)/.*" -not -path "/home/$(whoami)/Scaricati/App*" | rofi -levenshtein-sort -dmenu -i -p "File ")"
