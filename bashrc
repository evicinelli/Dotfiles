# Variables {{{
export EDITOR=vim
export GIT_EDITOR=vim
export DF="$HOME/Dotfiles"
export UNI="$HOME/ownCloud/Uni"
export UG="$HOME/ownCloud/Uni/AppuntiUni"
export OC="$HOME/ownCloud"
export PW="$HOME/ownCloud/Archivio/Password-store"
export TD="$HOME/ownCloud/todo.txt"
export DN="$HOME/ownCloud/done.txt"
export DOCUMENTS="$HOME/ownCloud/Documenti"
export DOWNLOADS="$HOME/Scaricati"
export NOTES="$HOME/ownCloud/Notes"
export WS="$HOME/ownCloud/Workspace"
export MEDIA="$HOME/ownCloud/Media"
export P="$HOME/ownCloud/Workspace/TW2018"
export SRV="192.168.1.197"
# Se abbiamo variabili locali da ridefinire, usiamo quelle
[[ -r .bashrc_local ]] && source .bashrc_local
# }}}

# Defaults  {{{
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
#     xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" ;;
#     *) ;;
# esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
    fi
fi
# }}}

# Vim keys and general keybindings {{{
set -o vi
bind TAB:menu-complete
bind Control-l:clear-screen
bind 'Control-k:"clear; l\n"'
# }}}

# Shell options {{{
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s direxpand
shopt -s direxpand
shopt -s dirspell
shopt -s cdspell
shopt -s autocd
shopt -s globstar
shopt -s extglob
shopt -s checkwinsize
shopt -s histappend
# }}}

# Prompt and colorscheme {{{
export PROMPT_COMMAND=prompt

prompt() {
    toDo=$(tl | grep -v "^x .*"| wc -l)
    toDoUrgent=$(tl | sort | grep "^(.*" | wc -l)
        export PS1="$(ps1_hostname)\[\e[1;36m\]\W\[\e[1;31m\] [$toDo, [$toDoUrgent!]]:\[\e[0m\] "
}

ps1_hostname() {
    host=$(hostname)
    user=$(whoami)
    [[ "$host" != "pelican" || "$user" != "vic" ]] && echo "\[\e[1;30m\]$user\[\e[0;37m\]@\[\e[1;36m\]$host "
}

# Base16 colorscheme stuff
case $TERM in
    rxvt*)
        BASE16_SHELL=$HOME/Scaricati/Apps/base16-shell/
        [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)" ;;
    *) ;;
esac
# }}}

# Alias {{{
# Colori {{{
alias ls='ls -s --color=auto --group-directories-first -h'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
# }}}

# Troppo lunghi da scrivere (o li sbaglio sempre) {{{
alias android-emulator="/home/vic/Workspace/Android/Sdk/emulator/emulator -avd Nexus_5X_API_27_x86 -use-system-libs -no-snapshot"
alias android-studio="/home/vic/Scaricati/Apps/android-studio/bin/studio.sh"
alias bashr="source ~/.bashrc"
alias cp="rsync --archive --verbose --human-readable"
alias fdate="date +%F -d"
alias gcal="gcalcli --calendar=\"Personale\""
alias gi="gvim"
alias gtd="bash ~/Scaricati/Apps/gtd/gtd -n"
alias l='pwd;ls -l'
alias maketemp="mktemp"
alias myip="curl http://myip.dnsomatic.com && echo ''"
alias o="xdg-open"
alias p="pass"
alias pandoc="pandoc --latex-engine=lualatex --smart --normalize --standalone"
alias t="tree -L 1"
alias tt="tree -L 2"
alias ttt="tree -L 3"
alias tr="tree -R"
alias srv-poweroff="ssh root@$SRV 'systemctl poweroff'"
alias srv-shh="ssh root@$SRV"
alias srv-upnp-down="sudo umount /media/vic/Upnp\ Salotto/"
alias srv-upnp-up="/home/vic/Dotfiles/script/mount-upnp-server.sh"
# }}}

# Git {{{
alias g="git"
alias gs="git status"
alias gd="git diff"
alias grm="git remove"
alias ga="git add"
alias gc="git commit"
alias gpush="git push"
alias gpull="git pull"
alias glog="git log --graph --oneline"
# }}}

# Todo {{{
alias ta="todo-add"
alias tl="todo-ls"
alias td="todo-done"
alias te="vi $TD"
alias ge="gvim $TD"
alias remindme="bash /home/vic/Dotfiles/script/remindme.sh"
# }}}
# }}}

# Functions {{{
# Find wrapper {{{
ffind() {
    find $1 -type f -iwholename "*$2*" 2> /dev/null
}

dirfind() {
    find $1 -type d -iwholename "*$2**" 2> /dev/null
}

clean-swp () {
    find $HOME -name "*.swp" -ok rm "{}" \;
    find $HOME -name "*.swo" -ok rm "{}" \;
}
# }}}

# Todo {{{
todo-add(){
    if [[ $# -gt 0 ]]; then
	    echo "$*" >> $TD
    fi
}

todo-ls() {
    if [[ $# -gt 0 ]]; then
		case "$*" in
			"w") 
				for i in {0..7}; do tl $i days; done | grep -v "^x .*";;
			"past") 
				for i in {-100..0}; do tl $i days; done | grep -v "^x .*";;
			"month")
				for i in {0..31}; do tl $i days; done | grep -v "^x .*";;
			*) 
				if date -d "$*" > /dev/null 2>&1; then 
					grep -Gi due:$(date +%F --date="$*") $TD 
				else grep -Gi "$*" $TD
				fi
		esac
	else
		cat $TD | grep "due:$(date +%F)"
    fi
}

todo-done () {
if [[ $# -gt 0 ]]; then
    ENTRIES_NO=$(sed -n "/$*/p" $TD | grep -v "^x .*" | wc -l)
    ENTRY=$(sed -n "/$*/p" $TD | grep -v "^x .*")
    if [[ $ENTRIES_NO -eq 1 ]]; then
            # Marchiamo quell'entry come completata in todo.txt
            echo -e "Marco come completato: "$ENTRY
            sed -in "s/${ENTRY}/x $(date +%F)\ &/" $TD
        else 
        # Trovare un modo più carino per fare pure questo
            if [[ $ENTRIES_NO -gt 1 ]]; then
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
    MAX_DOWN=${2:-3}; # if not $2, then default to 3 downloads
    MAX_DAYS=${3:-2}; # if not $3, then default to 2 days
    if [ $# -eq 0 ]; then
        echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
        return 1;
    fi
    tmpfile=$( mktemp -t transferXXX );
    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
        curl -H "Max-Downloads: $MAX_DOWN" -H "Max-Days: $MAX_DAYS" --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    else curl -H "Max-Downloads: $MAX_DOWN" -H "Max-Days: $MAX_DAYS" --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
    fi;
    cat $tmpfile | xclip -selection c; # copy to x clipboard
    cat $tmpfile | xclip -selection primary; # copy to primary clipboard
    cat $tmpfile;
    echo -e "\n"
    rm -f $tmpfile;
}

function fix-mimecache () {
    cd ~/.local/share/applications/
    rm mimeinfo.cache
    ln -s $DF/mimeinfo.cache
    cd ~-
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
# }}}

# Altro {{{
source /usr/share/bash-completion/completions/pass
# }}}

# vim: fdm=marker
