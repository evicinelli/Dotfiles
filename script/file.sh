# find files
[[ -f ~/Dotfiles/dmenurc ]] && . ~/Dotfiles/dmenurc || DMENU=dmenu
xdg-open "$(find $HOME \
-not -iwholename "$HOME/.*"  \
-not -iwholename "$HOME/**/.*" \
-not -iwholename "$HOME/Scaricati/App*" \
-not -iwholename "$HOME/AndroidStudioProjects*" \
-not -iwholename "$HOME/Workspace/Android*" \
-not -iwholename "$HOME/**/*node_modules*" \
-not -iwholename "$HOME/*nltk_data*" \
| eval ${DMENU} -p "File ")"
