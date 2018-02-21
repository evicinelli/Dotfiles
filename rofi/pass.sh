#! /bin/bash
pass -c $(find ~/ownCloud/Archivio/Password-store/ -type f -not -name ".*" | sed -n 's:/home/vic/ownCloud/Archivio/Password-store/::;s:.gpg::p' | rofi -levenshtein-sort -matching fuzzy -dmenu -i -p "Pass ")
