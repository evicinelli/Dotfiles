#! /bin/bash 
#	get wallpaper randomly from unsplash
#
# https://source.unsplash.com/random/{SIZE}
# https://source.unsplash.com/user/{USERNAME}/{SIZE}
# https://source.unsplash.com/user/{USERNAME}/likes/{SIZE}
# https://source.unsplash.com/collection/{COLLECTION ID}/{SIZE}
# https://source.unsplash.com/category/{CATEGORY}/?{SEARCH,TERM}
# https://source.unsplash.com/?{KEYWORD}
# https://source.unsplash.com/daily|weekly
# https://source.unsplash.com/featured/?{KEYWORD},{KEYWORD}
# https://source.unsplash.com/1600x900/{?SEARCH,TERM}
# https://source.unsplash.com/{PHOTO ID}/1600x900
# https://source.unsplash.com/ -- API documentation
COLLECTION_NUMBER="148982"
rm img
notify-send --urgency=low "Prendo lo sfondo dalla collezione $COLLECTION_NUMBER"
wget -O img "https://source.unsplash.com/collection/$COLLECTION_NUMBER/1600x900"
# gsettings set org.gnome.desktop.background picture-uri file:///$(pwd)/img
# gsettings set org.gnome.desktop.screensaver picture-uri file:///$(pwd)/img
# feh --bg-fill $(pwd)/img
feh --bg-scale $(pwd)/img
