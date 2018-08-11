#! /bin/bash 
#	get wallpaper randomly from unsplash

# API DOC --  https://source.unsplash.com  {{{
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
# }}}

COLLECTION_NUMBER="629911"
rm img
wget -O img "https://source.unsplash.com/collection/$COLLECTION_NUMBER/1600x900"
feh --bg-scale $(pwd)/img


/home/vic/.local/bin/wal $HOME/img

# vim: fdm=marker
