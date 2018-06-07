# find files
[[ -f ~/Dotfiles/dmenurc ]] && . ~/Dotfiles/dmenurc || DMENU=dmenu
xdg-open "$(find $HOME \
-not -iwholename "$HOME/.*"  \
-not -iwholename "$HOME/**/.*" \
-not -iwholename "$HOME/Tutto*" \
-not -iwholename "$HOME/Scaricati/App*" \
-not -iwholename "$HOME/**/*node_modules*" \
| eval ${DMENU} -p "File ")"
