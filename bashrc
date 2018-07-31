# Variables {{{
export EDITOR=vim
export TERMINAL=urxvt
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --cycle'
# Folder
export OC="$HOME/ownCloud"
export DF="$HOME/Dotfiles"
export DN="$OC/Dropbox/done.txt"
export DOC="$OC/Documenti"
export DBX="$OC/Dropbox"
export DOWN="$HOME/Scaricati"
export MED="$OC/Uni/Medicina"
export MEDIA="$OC/Media"
export MODELS="$OC/Archivio/Modelli"
export NOTES="$OC/Notes"
export P="$OC/Workspace/TW2018"
export PW="$OC/Archivio/Password-store"
export TD="$OC/Dropbox/todo.txt"
export UG="$OC/Uni/AppuntiUni"
export UNI="$OC/Uni"
export WS="$OC/Workspace"
# Ip address serverino casa
export SRV="192.168.1.197"
# Se abbiamo variabili locali da ridefinire, usiamo quelle
[[ -r ~/.bashrc_local ]] && source ~/.bashrc_local
# }}}

# Completions {{{
source /usr/share/bash-completion/completions/pass
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
complete -o bashdefault -o default -F _fzf_path_completion o # xdg-open alias completes with fzf when run o **
# }}}

# Defaults  {{{
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000000
HISTFILESIZE=1000000
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
bind 'C-e:"vim\n"'
bind '"\C-o": "fzf | (xargs -0I{} xdg-open \"{}\" &) \n"'
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
# Colorscheme (if set $COLORSCHEME and $BASE16_SHELL)
case $TERM in
    screen|rxvt*)
        if [[ ! -z $COLORSCHEME ]] && [[ ! -z $BASE16_SHELL ]]; then
            [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)" ;
            eval $COLORSCHEME;
        fi;;
    *) ;;
esac

# Prompt
export PROMPT_COMMAND=prompt
prompt() {
    toDo=$(tl | grep -v "^x .*"| wc -l)
    toDoUrgent=$(tl | sort | grep "^(.*" | wc -l)
    export PS1="$(ps1_hostname) \[\e[1;36m\]\W\[\e[1;31m\] [$toDo, [$toDoUrgent!]]:\[\e[0m\] "
    [[ $TERM = "dumb" ]] && export PS1="$(ps1_hostname)\W [$toDo, [$toDoUrgent!]]:" # Gvim terminal
    # Se è più tardi delle 20:00 passiamo al tema scuro
    [ $TERM = "rxvt-unicode-256color" -a $(date +%H%M) -ge  2000 ] && eval $COLORSCHEME_DARK || eval $COLORSCHEME_LIGHT
}

ps1_hostname() {
    host=$(hostname)
    user=$(whoami)
    [[ "$host" != "pelican" || "$user" != "vic" ]] && echo "\[\e[1;30m\]$user\[\e[0;37m\]@\[\e[1;36m\]$host"
}

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
        "w") for i in {0..7}; do todo-ls $i days; done;;
        "past") for i in {-93..-1}; do todo-ls $i days; done;;
        "month") for i in {0..31}; do todo-ls $i days; done;;
        "someday") cat $TD | grep -v "due:.*$";;
        *) 
            if date -d "$*" > /dev/null 2>&1; then 
                cat $TD | grep -v "^x .*" | grep -Gi "due:$(date +%F --date="$*")"
            else 
                cat $TD | grep -v "^x .*" | grep -Gi "$*" $TD
            fi
    esac
else
    cat $TD  | grep -v "^x .*" | grep "due:$(date +%F --date="today")"
fi
}

todo-done () {
if [[ $# -gt 0 ]]; then
    QUERY=$(sed -e "s/\ /.*/g" <<< $*) # Insensitive match with space repleaced with .*
    ENTRIES_NO=$(sed -n "/$QUERY/p" $TD | grep -v "^x .*" | wc -l)
    ENTRY=$(sed -n "/$QUERY/p" $TD | grep -v "^x .*")
    if [[ $ENTRIES_NO -eq 1 ]]; then
        # Marchiamo quell'entry come completata in todo.txt
        echo -e "Marco come completato: "$ENTRY
        sed -in "s/${ENTRY}/x $(date +%F)\ &/" $TD
    else 
        # Trovare un modo più carino per fare pure questo
        if [[ $ENTRIES_NO -gt 1 ]]; then
            sed -in "s/$( sed -n "/$QUERY/p" $TD | grep -v "^x .*" | fzf)/x $(date +%F)\ &/" $TD
        else
            echo -e "Nada de nada, mi sa che hai scritto male"
        fi
    fi
else
    sed -in "s/$(cat $TD | fzf)/x $(date +%F)\ &/" $TD
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
wttr () {
    curl "https://wttr.in/~$*"
}

fd () {
    date +%F -d  "$*"
}

testscore () {
    if [[ $# -gt 0 ]]; then
        echo -ne "`date`
        $1 errate
        $2 non date
        $3 corrette
        TOT: `bc <<< "-0.4*$1 + 0 * $2 + 1.5*$3"`\n---\n" | tee -a  ~/ownCloud/Uni/Medicina/Ammissione/Prove.md
        echo
    else echo "Usage: testscore #NO, #NIL, #OK"
    fi

}

daysuntil () {
    curl -s https://daycalc.appspot.com/`date +%m/%d/%Y --date "$*"` | grep -Eo "[0-9]+ days" | head -n 1
}

transfer() {
    MAX_DAYS=${2:-"2d"}; # if not $3, then default to 2 days allowed
    if [ $# -eq 0 ]; then
        cat << EOF
No arguments specified. 

USAGE:
transfer file [# days] 

OPTIONS:
Default: $MAX_DAYS max

INFO:
https://file.io
5G max
EOF
        return 1;
    fi
    tmpfile=$( mktemp -t transferXXX );
    # if tty -s; then
    #     basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
    #     curl -H "Max-Downloads: $MAX_DOWN" -H "Max-Days: $MAX_DAYS" --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    # else
    #     curl -H "Max-Downloads: $MAX_DOWN" -H "Max-Days: $MAX_DAYS" --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
    # fi;
    curl -F "file=@$1" https://file.io/?expires=$MAX_DAYS
    # cat $tmpfile | xclip -selection c; # copy to x clipboard
    # cat $tmpfile | xclip -selection primary; # copy to primary clipboard
    # cat $tmpfile;
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

function gong () {
    at $* <<< " mpv /usr/lib/libreoffice/share/gallery/sounds/gong.wav"
}
# }}}

# Motivation {{{
wakeup () {
    sleepingHours=8
    sleepingMinutes=20
    sleepingSeconds=$(((sleepingHours*60+sleepingMinutes)*60))
    morningTime=${1:-"8:30"}
    morningSeconds=$(date +%s -d "tomorrow $morningTime")
    duration=$((morningSeconds-sleepingSeconds))
    # echo $duration
    sleepTime=$(date -d "@$duration")
    echo $sleepTime
}

motivation() {
    QUOTES=(
    "La terza: considerare come se mi trovassi in punto di morte la forma e misura che allora vorrei aver tenuto nel compiere la presente scelta, e in base a ciò regolandomi, io prenda in tutto la mia decisione"
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
    "No greater opportunity or obligation can fall the lot of a human being than to be a physician. In the care of suffering he needs technical skill, scientific knowledge and human understanding. He who uses these with courage, humility and wisdom will provide a unique service to his fellow man and will build an enduring edifice of character within himself. The physician should ask of his destiny no more than this and he should be content with no less -Tinsley Randolph Harrison, Harrison's principles of Internal Medicine"
    )
    I=${QUOTES["RANDOM%${#QUOTES[@]}"]}
    echo "$I"
    echo
}
# }}}

# Fzf helpers {{{
__fzf_pws__ () {
    FILTER="s:${PW}/::;s:.gpg::"
    readarray PWS < <(find $PW -type f -iwholename "*$1*.gpg" | sed -e $FILTER)
    echo ${PWS[*]} | sed "s/ /\\n/g" | fzf
}
bind '"\C-v": "\C-x\C-a$a \C-x\C-addi`__fzf_pws__`\C-x\C-e\C-x\C-a0Px$a \C-x\C-r\C-x\C-axa"' #wtf?! Just works, no question asked
# }}}

# }}}

# Alias {{{
# Colori {{{
alias ls='ls -h --color=auto --group-directories-first'
alias sl='ls'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
# }}}

# Troppo lunghi da scrivere (o li sbaglio sempre) {{{
alias android-emulator="$HOME/Workspace/Android/Sdk/emulator/emulator -avd Nexus_5X_API_27_x86 -use-system-libs -no-snapshot"
alias android-studio="$HOME/Scaricati/Apps/android-studio/bin/studio.sh"
alias audio-rec="ffmpeg -f alsa -ac 2 -i hw:0"
alias bashr="source $HOME/.bashrc"
alias cp="rsync --archive --verbose --human-readable"
alias fj='fg $(jobs | fzf | cut -d" " -f1 | grep -Eo "[0-9]+")'
alias gcal="gcalcli --calendar=\"Personale\""
alias gi="gvim"
alias gtd="bash ~/Scaricati/Apps/gtd/gtd -T"
alias gv="gvim"
alias httpserver="python -m SimpleHTTPServer 8000"
alias l='pwd;ls -l'
alias maketemp="mktemp"
alias myip="curl http://myip.dnsomatic.com && echo ''"
alias notability="bash /home/vic/Dotfiles/script/notability.sh"
alias n="notability $NOTES"
alias o="xdg-open"
alias p='pass'
alias pandoc="pandoc --latex-engine=lualatex --smart --normalize --standalone"
alias pc='pass -c'
alias pdfjoin=" pdfjoin --paper a4paper --rotateoversize false"
alias py="python"
alias scp="rsync --archive --checksum --compress --human-readable --itemize-changes --rsh=ssh --stats --verbose"
alias srv-poweroff="ssh root@$SRV 'systemctl poweroff'"
alias srv-ssh="ssh root@$SRV"
alias srv-upnp-down="sudo umount /media/vic/Upnp\ Salotto/"
alias srv-upnp-up="$HOME/Dotfiles/script/mount-upnp-server.sh"
alias t="tree -L 1"
alias tr="tree -R"
alias tt="tree -L 2"
alias ttt="tree -L 3"
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
alias tlrem="cat $OC/remember.todo.txt"
# }}}

# }}}

# Tmux {{{
# if [ -z "$TMUX" ]; then
#     tmux
#     eval $COLORSCHEME
# fi
# }}}

# vim: fdm=marker
