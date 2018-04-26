#! /bin/bash
pass -c $(find ~/ownCloud/Archivio/Password-store/ -type f -not -name ".*" | sed -n 's:/home/vic/ownCloud/Archivio/Password-store/::;s:.gpg::p' | dmenu -i -p "Pass " -fn "Ubuntu Mono-13")
