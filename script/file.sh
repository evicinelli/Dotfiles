# find files
[[ -f ~/Dotfiles/dmenurc ]] && . ~/Dotfiles/dmenurc || DMENU=dmenu
xdg-open "$(find /home/$(whoami) /tmp /media/$(whoami) \
-not -path "/tmp/.*" \
-not -path "/home/$(whoami)/.*"  \
-not -path "/home/$(whoami)/**/.*" \
-not -path "/home/$(whoami)/Scaricati/App*" \
-not -path "/home/vic/AndroidStudioProjects*" \
-not -path "/home/vic/Workspace/Android*" \
| eval ${DMENU} -p "File ")"
