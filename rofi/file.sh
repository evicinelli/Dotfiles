# find files
xdg-open "$(find /tmp /home/$(whoami) /media/$(whoami) -not -path "/home/$(whoami)/.*" -not -path "/home/$(whoami)/Scaricati/App*" | dmenu -i -p "File " -fn "Inconsolata-13")"
