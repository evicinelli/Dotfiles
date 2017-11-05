# 
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
TAIL="collection/890836"
rm img
notify-send "Prendo lo sfondo da unsplash"
echo https://source.unplash.com/$TAIL
wget -O img "https://source.unsplash.com/$TAIL"
notify-send "Fatto :)"
gsettings set org.gnome.desktop.background picture-uri file:///$(pwd)/img
gsettings set org.gnome.desktop.screensaver picture-uri file:///$(pwd)/img
feh --bg-fill $(pwd)/img


# wget -O img "https://source.unsplash.com/collection/149064/1600x900"
# wget -O img "https://source.unsplash.com/1600x900/?nature,water"
