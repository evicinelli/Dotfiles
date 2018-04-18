# Find wrapper {{{
ffind() {
    find $1 -type f -iwholename "*$2*" 2> /dev/null
}

dirfind() {
    find $1 -type d -iwholename "*$2**" 2> /dev/null
}

recent () {
    find $OC -type f -mtime -"$1" -not -path "/home/vic/ownCloud/.*" -exec echo {} \;
}

edit-recent () {
    find $OC -type f -regex ".*\.\(md\|txt\)" -mtime -"$1" -not -path "/home/vic/ownCloud/.*" -exec vim "{}" \+
}

clean-swp () {
    find $HOME -name "*.swp" -ok rm "{}" \;
    find $HOME -name "*.swo" -ok rm "{}" \;
}
# }}}

# Todo {{{
todo-add(){
    if [[ $# -gt 0 ]]; then
	if [[ "$*" == "" ]]; then
	    echo >> $TD
	else
	    echo "$*" >> $TD
	fi
    else
	echo "Nope, dammi qualcosa da fare!"
    fi
}

todo-ls() {
    if [[ $# -gt 0 ]]; then
    [[ "$*" = "w" ]] && (echo -e "# Todo per i prossimi 7 giorni #"; for i in {0..7}; do tl $i days; echo; done)
	if date -d "$*" > /dev/null 2>&1; then
	    grep -Gi "due:$(date +%F --date="$*")" $TD
	else
	    grep -Gi "$1" $TD
	fi
    else
        [[ -f ~/oggi.txt ]] && cat ~/oggi.txt && echo -ne "\n"
        cat $TD | grep "due:$(date +%F)"
    fi
}

todo-done () {
if [[ $# -gt 0 ]]; then
    ENTRIES_NO=$(sed -n "/$*/p" $TD | grep -c "")
    ENTRY=$(sed -n "/$*/p" $TD)
    # echo $ENTRIES
    # echo $ENTRIES_NO
    if [[ $ENTRIES_NO -eq 1 ]]; then
            # Marchiamo quell'entry come completata in todo.txt
            echo -e "Marco come completato: "$ENTRY
            sed -in "s/${ENTRY}/x $(date +%F)\ &/" $TD
            # Se esiste anche un file ~/oggi.txt, rimuoviamo l'entry anche da lì
            if [[ -f ~/oggi.txt ]]; then
                ENTRY_OGGI=$(sed -n "/$*/p" ~/oggi.txt)
                sed -in "s/{$ENTRY_OGGI}//" ~/oggi.txt
            fi
        else 
        # Trovare un modo più carino per fare pure questo
            if [[ $ENTRIES_NO -gt 1 && $ENTRY_OGGI = "" ]]; then
                echo -e "Più di un match, specifica meglio cosa vuoi marcare come compleato"
                grep "$*" $TD
            else
                echo -e "Nada de nada, mi sa che hai scritto male"
            fi
    fi
else
   echo "Scrivi cosa vuoi che venga marcato come fatto, testina!" 
fi

# Trovare un modo più carino per farlo
if [ -w /home/vic/ownCloud/todo.txtn ]; then
    rm /home/vic/ownCloud/todo.txtn
fi
if [ -w ~/oggi.txtn ]; then
    rm ~/oggi.txtn
fi

}

function todo-ls-tags() {
    grep -o "@.[a-z]*" $TD | sort | uniq
    grep -o "\+.[a-z]*" $TD | sort | uniq
}

# }}}

# Utility {{{
transfer() {
    if [ $# -eq 0 ]; then
	echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
	return 1;
    fi
    tmpfile=$( mktemp -t transferXXX );
    if tty -s; then
	basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
	curl -H "Max-Downloads: 3" -H "Max-Days: 2" --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    else curl -H "Max-Downloads: 3" -H "Max-Days: 2" --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
    fi;
    cat $tmpfile | xclip -selection c;
    cat $tmpfile;
    echo -e "\n"
    rm -f $tmpfile;
}

function count () {
    if [[ $# -eq 1 ]]; then 
	grep -c "$1"
    else
	grep -c ".*"
    fi
}

function fix-mimecache () {
    cd ~/.local/share/applications/
    rm mimeinfo.cache
    ln -s $DF/mimeinfo.cache
}

function emoji () {
    grep -Ei "$*" /home/vic/ownCloud/Archivio/emoji.txt
}
# }}}

# Motivation {{{
motivation() {
    QUOTES=(
    "Ever tried. Ever failed. No matter. Try Again. Fail again. Fail better. -Samuel Beckett "
    "Never give up, for that is just the place and time that the tide will turn. -Harriet Beecher Stowe "
    "Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time. -Thomas A. Edison"
    "Life isn't about getting and having, it's about giving and being. -Kevin Kruse"
    "Strive not to be a success, but rather to be of value. -Albert Einstein"
    "You miss 100% of the shots you don't take. -Wayne Gretzky"
    "People who are unable to motivate themselves must be content with mediocrity, no matter how impressive their other talents. -Andrew Carnegie"
    "Only those who dare to fail greatly can ever achieve greatly. -Robert F. Kennedy"
    "All our dreams can come true, if we have the courage to pursue them. -Walt Disney "
    "Success consists of going from failure to failure without loss of enthusiasm. -Winston Churchill"
    "The start is what stops most people. -Don Shula"
    "Genius: one percent inspiration and 99 percent perspiration -Thomas Edison"
    "The best time to plant a tree was 20 years ago. The second best time is now. -Chinese Proverb"
    "I've missed more than 9000 shots in my career. I've lost almost 300 games. 26 times I've been trusted to take the game winning shot and missed. I've failed over and over and over again in my life. And that is why I succeed. -Michael Jordan"
    "If you hear a voice within you say “you cannot paint,” then by all means paint and that voice will be silenced. -Vincent Van Gogh"
    "I attribute my success to this: I never gave or took any excuse. -Florence Nightingale"
    "People often say that motivation doesn’t last. Well, neither does bathing.  That’s why we recommend it daily. -Zig Ziglar"
    "Believe you can and you’re halfway there. -Theodore Roosevelt"
    "Everything you’ve ever wanted is on the other side of fear. -George Addair"
    "You take your life in your own hands, and what happens? A terrible thing, no one to blame -Erica Jong"
    "Whether you think you can or you think you can’t, you’re right. -Henry Ford"
    "If the wind will not serve, take to the oars. -Latin Proverb"
    "Fall seven times and stand up eight. -Japanese Proverb"
    "Start where you are. Use what you have. Do what you can. -Arthur Ashe"
    "When I stand before God at the end of my life, I would hope that I would not have a single bit of talent left and could say, I used everything you gave me. -Erma Bombeck"
    "The only person you are destined to become is the person you decide to be. -Ralph Waldo Emerson"
    )
    I=${QUOTES["RANDOM%${#QUOTES[@]}"]}
    echo -ne "   $I\n"
}
# }}}

# vim: ft=sh fdm=marker
