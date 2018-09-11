#! /bin/bash
[[ -f ~/Dotfiles/dmenurc ]] && . ~/Dotfiles/dmenurc || DMENU=dmenu
pass -c $(find ~/ownCloud/Archivio/Password-store/ -type f -not -name ".*" | sed -n 's:/home/vic/ownCloud/Archivio/Password-store/::;s:.gpg::p' | eval ${DMENU} -p "Pass ")
