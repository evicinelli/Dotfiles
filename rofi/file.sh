# find files
xdg-open "$(find /tmp /home/$(whoami) /media/$(whoami) -not -path "/home/$(whoami)/.*" -not -path "/home/$(whoami)/Scaricati/App*" | rofi -threads 0 -dmenu -i -p "find:")"