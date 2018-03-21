# find files
xdg-open "$(find /home/$(whoami) /tmp /media/$(whoami) \
-not -path "/tmp/.*" \
-not -path "/home/$(whoami)/.*"  \
-not -path "/home/$(whoami)/**/.*" \
-not -path "/home/$(whoami)/Scaricati/App*" \
-not -path "/home/vic/AndroidStudioProjects*" \
-not -path "/home/vic/Workspace/Android*" \
| rofi -levenshtein-sort -dmenu -i -p "File ")"
