# Setup  {{{
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE= HISTFILESIZE= # Infinite history
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Bash completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Is fzf already installed?
[[ -d $HOME/.fzf ]] || (echo "Installing fzf... " && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install)

[[ -d $HOME/Dotfiles ]] && export PATH=${PATH}:$HOME/Dotfiles/script
export PATH="${PATH}:${HOME}/.local/bin/:${HOME}/Scaricati/Apps/Telegram"
set -o vi
# }}}

# Variables {{{
[[ -e /usr/bin/nvim ]] && export EDITOR=nvim || export EDITOR=vim
# [[ -e /usr/bin/nvim-qt ]] && export VISUAL="nvim-qt" || export VISUAL="$EDITOR -g"
# export EDITOR=vim
# export VISUAL=vim
export TERMINAL=urxvt
export BROWSER=qutebrowser
export OPEN=xdg-open
unset VISUAL

# Folder
export OC="$HOME/ownCloud"
export DF="$HOME/Dotfiles"
export DN="$OC/Dropbox/done.txt"
export DOC="$OC/Documenti"
export GVS="$DBX/GVS"
export DBX="$OC/Dropbox"
export DOWN="$HOME/Scaricati"
export MED="$OC/Uni/AppuntiUni/Medicina/Med1"
export MEDIA="$OC/Media"
export MODELS="$OC/Archivio/Modelli"
export NOTES="$DBX/Notes"
export P="$OC/Workspace/TW2018"
export PW="$OC/Archivio/Password-store"
export TD="$OC/Dropbox/todo.txt"
export UNI="$OC/Uni/AppuntiUni"
export WS="$OC/Workspace"

# Ip address home server
export SRV="192.168.1.197"

# Pattern
export EMPTY_LINES="^$"

# Se abbiamo variabili locali da ridefinire, usiamo quelle
[[ -r ~/.bashrc_local ]] && source ~/.bashrc_local
# }}}

# Completions & fzf {{{
complete -o bashdefault -o default -F _fzf_path_completion o # xdg-open alias completes with fzf when run o **
[ -f /usr/share/bash-completion/completions/pass ] &&source /usr/share/bash-completion/completions/pass

# [[ -x /usr/bin/fd ]] && export FZF_DEFAULT_COMMAND='/usr/bin/env fd --type f --no-ignore'
# [[ -x /usr/bin/fd ]] && export FZF_CTRL_T_COMMAND='/usr/bin/env fd --type f --no-ignore'
[[ -d $HOME/.fzf ]] && export FZF_DEFAULT_OPTS='--height 40% --reverse --border --cycle'
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
# }}}

# Keybindings {{{
bind TAB:menu-complete
bind C-e:complete
bind Control-l:clear-screen
bind '"\C-p": "\C-x\C-a$a \C-x\C-addi`__fzf_select__`\C-x\C-e\C-x\C-a0Px$a \C-x\C-r\C-x\C-axa"' # Select files
bind '"\C-o": " fo"' # Open files
bind '"\C-k": " fj"' # Job control, C-j unavailable

# }}}

# Shell options {{{
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s direxpand
shopt -s dirspell
shopt -s cdspell
shopt -s globstar
shopt -s extglob
shopt -s checkwinsize
shopt -s histappend
# }}}

# Colorscheme (pywal) {{{
# [ -f ~/.cache/wal/colors.sh ] && . "${HOME}/.cache/wal/colors.sh"
# ( [ -f ~/.cache/wal/sequences ] && cat ~/.cache/wal/sequences &)
# }}}

# Prompt {{{
export PROMPT_COMMAND=prompt
prompt() {
    [[ -e $TD ]] && toDo=$(tl | grep -v "^x .*"| wc -l) || toDo="x"
    [[ -e $TD ]] && toDoUrgent=$(tl | sort | grep "^(.*" | wc -l) || toDoUrgent="x"
    [[ ! $(jobs -ls | wc -l ) = 0 ]] && bg_jobs="(`jobs -ls | wc -l`) "|| bg_jobs=""
    end=">"
    if [[ $TERM = "dumb" ]]; then 
        export PS1="$bg_jobs[$toDo, [$toDoUrgent!]] $(ps1_hostname)\W $end " # Gvim terminal
    else
        export PS1="\[\e[1;34m\]$bg_jobs\[\e[1;31m\][$toDo, [$toDoUrgent!]]\[\e[1;36m\] $(ps1_hostname)\W $end \[\e[0m\]"
    fi
}

ps1_hostname() {
    host=$(hostname)
    user=$(whoami)
    [[ "$host" != "pelican" || "$user" != "vic" ]] && echo "\[\e[1;30m\]$user\[\e[0;37m\]@\[\e[1;36m\]$host"
}

# }}}

# Functions {{{

# Altra roba {{{
revealjs () {
    INPUT=$1
    shift
    wget https://github.com/hakimel/reveal.js/archive/master.tar.gz
    tar -xzvf master.tar.gz
    mv reveal.js-master reveal.js && rm master.tar.gz
    pandoc -t revealjs -s --self-contained $* $INPUT -o index.html
    # rm -r reveal.js
}

clean-swp () {
    find $HOME -name "*.swp" -ok rm "{}" \;
    find $HOME -name "*.swo" -ok rm "{}" \;
}

# }}}

# Todo manager {{{
todo-edit() {
    [[ $# -gt 0 ]] && \
        vim $TD -c "/$(sed "s/ /.*/g" <<< "$*")" -c "normal zR" || \
        vim $TD
}

todo-add(){
if [[ $# -gt 0 ]]; then
    echo "$*" >> $TD
fi
}

todo-ls() {
if [[ $# -gt 0 ]]; then
    case "$1" in
        "agenda")
            # tl agenda [ # days ]
            end=${2:-6} # if not $2, by default print todos for next 6 days
            if [[ $end -ge 0 ]]; then
                for (( i=0; i<$end; i++ )) do
                    t=$(todo-ls $i days);
                    [[ ! -z "$t" ]] && (echo -ne "\n- $(date +%a\ %x -d "$i days") --- \n"; echo "$t";);
                done;
            else
                for (( i=$end; i<0; i++ )) do
                    t=$(todo-ls $i days);
                    [[ ! -z "$t" ]] && (echo -ne "\n- $(date +%a\ %x -d "$i days") ($i days ago) --- \n"; echo "$t";);
                done;
            fi
            echo ;;
        "past")
            # tl past [# days]
            local IFS=""
            end=${2:-100} # if not $2, by default print todos for the past 100 days
            for (( i=$end; i>0; i-- )) do
                t=$(todo-ls -$i days);
                [[ ! -z "$t" ]] && echo $t;
            done;
            ;;
        "someday") cat $TD | grep -v "due:.*$";;
        "tags")
            # local IFS=""
            readarray tags < <(grep -o "@.[a-z]*" $TD | sort | uniq)
            for tag in ${tags[*]}; do
                echo -ne "\n- $tag --- \n"
                cat $TD | grep -v "^x" | grep "$tag"
            done
            ;;

        "projects")
            readarray tags < <(grep -o "\+.[a-z]*" $TD | sort | uniq)
            for tag in ${tags[*]}; do
                echo -ne "\n- $tag --- \n"
                cat $TD | grep -v "^x" | grep "$tag"
            done
            ;;
        *)
            if date -d "$*" > /dev/null 2>&1; then
                cat $TD | grep -v "^x .*" | grep -Gi "due:$(date +%F --date="$*")"
            else
                args="$(sed -e "s/\ /.*/g" <<< "$*")" # space -> .*
                cat $TD | grep -v "^x" | grep -Gi "$args" $TD
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

# Password manager {{{
p () {

    edit_key=ctrl-v
    view_key=ctrl-c
    pipe_key=ctrl-p

    # [[ $1 -eq "generate" || $1 -eq "add" ]] && (pass "$*"; exit 0)

    FILTER="s:${PW}/::;s:.gpg::"
    readarray PWS < <(/usr/bin/find $PW -type f | sed -e $FILTER)

    fzfOut=$(echo ${PWS[*]} | sed "s/ /\\n/g" | fzf --no-exact -0 --expect=$edit_key,$view_key,$pipe_key --query="$@" --header="$edit_key to edit, $view_key to cat, $pipe_key to copy the entry, Enter to copy the password")
    first=$(echo $fzfOut | cut -d" " -f1)
    second=$(echo $fzfOut | cut -d" " -f2)

    case "$first" in
        $edit_key) pass edit "$second";;
        $view_key) pass "$second";;
        $pipe_key) echo $second | xclip -selection primary;;
        *)pass -c "$first";;
    esac

}
# }}}

# Utility {{{
share-home-network () {
    share "WIFI:S:Network Casa Vicinelli;T:WPA;P:$(pass Casa/wifi | head -n 1);;"
}
tny () {
    [[ $# -gt 0 ]] && ( wget -q -O - http://tny.im/yourls-api.php?action=shorturl\&format=simple\&url=$1; echo;) || echo "tny nttps://url.com"
}

wifi () {
    nmcli -a device wifi connect "$( nmcli --color no device wifi | grep -v ".*--.*" | fzf --query="$*" -1 --ansi --header-lines=1 | sed -r 's/^\s*\*?\s*//; s/\s*(Ad-Hoc|Infra).*//')"
}

push () {
    # Push a notification to all the devices connected by pushbullet
    curl -s --header "Access-Token: $PB_TOKEN" \
        --header "Content-Type: application/json" \
        --data-binary "{\"body\":\"$*\",\"title\":\"Broadcasted Push\",\"type\":\"note\"}" \
        --request POST \
        https://api.pushbullet.com/v2/pushes \
        && exit 0 || exit 1
    echo
}

share () {
    if [[ $# -gt 0 ]]; then
        file=$(mktemp);
        qrencode -s 20 "$*" -o $file
        $OPEN $file
    fi
}

fj () {
    job=$(jobs -ls | fzf -1 -0 --query="$*" | cut -d" " -f1 | grep -Eo "[0-9]+")
    [[ ! -z $job ]] && fg $job
}

wttr () {
    CITY=`sed "s/ /+/g" <<< "$*"`
    curl "https://wttr.in/~$CITY"
}

df () {
    date +%F -d "$*"
}

daysuntil () {
    curl -s https://daycalc.appspot.com/`date +%m/%d/%Y --date "$*"` | grep -Eo "[0-9]+ days" | head -n 1
}

transfer () {
    MAX_DAYS=${2:-"2d"}; # Default: 2days
    if [ $# -eq 0 ]; then
        cat << EOF
No arguments specified.

USAGE:
transfer file [# days]

OPTIONS:
Default: $MAX_DAYS max

INFO:
https://file.io
100MB max
EOF
        return 1;
    fi
    tmpfile=$( mktemp -t transferXXX );
    curl -F "file=@$1" https://file.io/?expires=$MAX_DAYS
    echo -e "\n"
    rm -f $tmpfile;
}

function fix-mimecache () {
    cd ~/.local/share/applications/
    rm mimeinfo.cache
    ln -s $DF/mimeinfo.cache
    cd ~-
}

function gong () {
    bash $HOME/Dotfiles/script/remindme $* "GONG: TIME IS UP (`date +%H:%M`)"
    at $* <<< " mpv /usr/lib/libreoffice/share/gallery/sounds/gong.wav"
}

function fo () {
    f=$(fzf --query="$*")
   [[ ! -z $f ]] && eval "$OPEN \"$f\""
}
# }}}

# }}}

# Alias {{{

# Vim and neovim {{{
    alias vi="$EDITOR"
    alias vim="$EDITOR"
    alias vimdiff="$EDITOR -d"
    alias gv="$VISUAL"
# }}}

# Colori {{{
alias ls='ls -h --color=auto --group-directories-first'
alias sl='ls'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
# }}}

# Troppo lunghi da scrivere (o li sbaglio sempre) {{{
# alias android-emulator="$HOME/Workspace/Android/Sdk/emulator/emulator -avd Nexus_5X_API_27_x86 -use-system-libs -no-snapshot"
# alias android-studio="$HOME/Scaricati/Apps/android-studio/bin/studio.sh"
alias ll="ls -l"
alias tm="tmux -f $DF/tmux.conf"
alias audio-rec="ffmpeg -f alsa -ac 2 -i hw:0"
alias bashrc="vi $HOME/.bashrc; source $HOME/.bashrc"
alias cp="rsync --archive --verbose --human-readable"
alias clipboard="xclip -selection PRIMARY"
alias gcal="gcalcli --calendar=\"Personale\""
alias gi="gvim"
alias gtd="bash ~/Scaricati/Apps/gtd/gtd -T"
alias gv="gvim"
alias httpserver="python -m SimpleHTTPServer 8000"
alias l='ls'
alias mkdir="mkdir -pv"
alias myip="curl http://myip.dnsomatic.com && echo ''"
alias n="notability $NOTES"
alias neton="nmcli networking on &"
alias netoff="nmcli networking off"
alias o="$OPEN"
alias pandoc="pandoc --latex-engine=lualatex --smart --normalize --standalone"
alias beamer="pandoc -t beamer -H /home/vic/ownCloud/Modelli/beamer.tex"
alias pdfjoin=" pdfjoin --paper a4paper --rotateoversize false"
alias py="python"
alias scp="rsync --archive --checksum --compress --human-readable --itemize-changes --rsh=ssh --stats --verbose"
alias srv-poweroff="ssh root@$SRV 'systemctl poweroff'"
alias srv-ssh="ssh root@$SRV"
alias srv-upnp-down="sudo umount /media/vic/Upnp\ Salotto/"
alias srv-upnp-up="$HOME/Dotfiles/script/mount-upnp-server"
alias t="tree -L 1"
alias tr="tree -R"
alias tt="tree -L 2"
alias ttt="tree -L 3"
alias unicode='echo ✓ ™ ♪ ♫ ☃ ° Ɵ ∫ 💙'
alias vimrc="vi $HOME/.vim/vimrc"
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
alias tla="todo-ls agenda"
alias td="todo-done"
alias te="todo-edit"
alias ge="gvim $TD"
alias tlrem="cat $OC/remember.todo.txt"
# }}}
# }}}

# vim: fdm=marker
