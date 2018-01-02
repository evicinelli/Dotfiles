ffind() {
    find $1 -type f -iwholename "*$2*" 2> /dev/null
}

dirfind() {
    find $1 -type d -iwholename "*$2**" 2> /dev/null
}

todo-add(){
    if [[ $# -gt 0 ]]; then
	echo "$1 +background" >> $TD
    else 
	echo "Nope, dammi qualcosa da fare!"
    fi
}

todo-ls() {
#    echo -ne "\n"
    if [[ $# -gt 0 ]];
    then
	grep -Gi "$1" $TD
#	grep "due:*$1" $TD
    else
	grep "due:$(date +%F)" $TD
    fi
#    echo -ne "\n"
}

recent () {
    find $OC -type f -mtime -"$1" -not -path "/home/vic/ownCloud/.*" -exec echo {} \;
}

edit-recent () {
    find $OC -type f -regex ".*\.\(md\|txt\)" -mtime -"$1" -not -path "/home/vic/ownCloud/.*" -exec vim -p {} \+
}

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
    "The best time to plant a tree was 20 years ago. The second best time is now. –Chinese Proverb"
    "I've missed more than 9000 shots in my career. I've lost almost 300 games. 26 times I've been trusted to take the game winning shot and missed. I've failed over and over and over again in my life. And that is why I succeed. –Michael Jordan"
    "If you hear a voice within you say “you cannot paint,” then by all means paint and that voice will be silenced. –Vincent Van Gogh"
    "I attribute my success to this: I never gave or took any excuse. –Florence Nightingale"
    "People often say that motivation doesn’t last. Well, neither does bathing.  That’s why we recommend it daily. –Zig Ziglar"
    "Believe you can and you’re halfway there. –Theodore Roosevelt"
    "Everything you’ve ever wanted is on the other side of fear. –George Addair"
    "You take your life in your own hands, and what happens? A terrible thing, no one to blame –Erica Jong"
    "Whether you think you can or you think you can’t, you’re right. –Henry Ford"
    )

    I=${QUOTES["RANDOM%${#QUOTES[@]}"]}
    echo -ne "   $I\n"
}

