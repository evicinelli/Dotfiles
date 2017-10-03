# find files
xdg-open "$(find /tmp /home/$(whoami) /media/$(whoami) -not -path "/home/$(whoami)/.*" -not -path "/home/$(whoami)/Scaricati/App*" | rofi -levenshtein-sort -dmenu -i -p "File ")"
