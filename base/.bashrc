# Setup  {{{
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# History
HISTCONTROL="ignoredups:erasedups:ignoreboth" # Avioid duplicates
HISTSIZE= HISTFILESIZE= # Infinite history
HISTTIMEFORMAT='%F %T '
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:fj:fo:unsplash" # Do not append this to history

# Colors
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

# Vim
set -o vi
# }}}

# Variables {{{
export PATH="${PATH}:$HOME/Dotfiles/bin/:${PATH}:${HOME}/.local/bin/:${HOME}/Scaricati/Apps/Telegram"
[[ -e /usr/bin/nvim ]] && export EDITOR=nvim || export EDITOR=vim
export TERMINAL=kitty
export BROWSER=quantum
export OPEN=xdg-open

# Folder
export P="/home/vic/pCloudDrive"
export DF="$HOME/Dotfiles"
export DN="$P/Documenti/Todo/done.txt"
export DOC="$P/Documenti"
export DOWN="$HOME/Scaricati"
export GVS="$P/Gvs"
export MEDIA="$P/Media"
export NOTES="$P/Notes"
export PW="$P/Documenti/Password-store"
export TD="$P/Documenti/Todo/todo.txt"
export UNI="$P/Uni/AppuntiUni"

# Appunti Medicina
export MED="$P/Uni/Appunti/Medicina/Med2"
export MED1="$P/Uni/Appunti/Medicina/Med1"

# Altro
export SRV="192.168.1.197"
export EMPTY_LINES="^$"
export BATTERY_NUMBER=1
export BREAK_LENGTH=5
export WORK_LENGTH=25

# Se abbiamo variabili locali da ridefinire, usiamo quelle
[[ -r ~/.bashrc_local ]] && source ~/.bashrc_local
# }}}

# Alias {{{
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias rm="rm -I"
alias sort="sort -n"
alias pandoc="pandoc --pdf-engine=xelatex"

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
alias audio-rec="ffmpeg -f alsa -ac 2 -i hw:0"
alias bashrc="vi $HOME/.bashrc && source $HOME/.bashrc"
alias bc="bc -l"
alias beamer="pandoc -t beamer -H $P/Modelli/beamer.tex"
alias bell="echo -e '\a' && tmux display-message 'BELL <3' && notify-send --urgency=critical 'BELL'"
alias clipboard="xclip -selection PRIMARY"
alias cp="rsync --archive --verbose --human-readable"
alias gcal="gcalcli --calendar=\"Personale\""
alias httpserver="python -m SimpleHTTPServer 8000"
alias l='ls'
alias ll="ls -l"
alias mkdir="mkdir -pv"
alias mn="notability $MED"
alias myip="curl http://myip.dnsomatic.com && echo ''"
alias n="notability $NOTES"
alias netoff="nmcli networking off"
alias neton="nmcli networking on &"
alias o="$OPEN"
alias open="$OPEN"
# alias pdfjoin=" pdfjoin --paper a4paper --rotateoversize false"
alias pandoc-gvs="pandoc --standalone --reference-doc=$GVS/res/reference-doc.odt "
alias py="python"
alias quantum="/home/vic/Scaricati/Apps/firefox/firefox"
alias scp="rsync --archive --checksum --compress --human-readable --itemize-changes --rsh=ssh --stats --verbose"
alias unicode='echo "✓   ™   ♪   ♫   ☃   °   Ɵ   ∫   ❤   ☤   ⚕   ‘  ’   “  ”   ‚  „   ′  ″  ‹›   «  »   -  –  (  /  )  [  |  ]  {  \  }   *   †  ‡  §  ¶  |  ‖   @   №   $  £  ¥  €  ₹  ₺  ₽  ¢  ƒ   %  ‰   ¼  ½  ¾  ⅓  ⅔  ⅛  ⅜  ⅝   +  −  ×  ÷  ∙  =  <  >  ≤  ≥  ±  ^  ≠  ~  ≈  ¬   #  π  ∞  µ  ∂  ∫  √   •  ◦  ▪  ▫  ▴  ▸  ▾  ◂  ▵  ▹  ▿  ◃   ●  ○  ■  □  ▲  ▶  ▼  ◀  △  ▷  ▽  ◁  ❒  ◆  ►  ◄  ◙  ◉  ◘   ←  ↖  ↑  ↗  →  ↘  ↓  ↙   ⇐  ⇑  ⇒  ⇓   ↔  ↕  ↨   ♀  ♂   ☼  ⌂   ☑   ✓   ☻   ☕   💩   🤖   🔒  🍺  🚑  👍  👌  💪                 "'
alias vimrc="vi $HOME/.config/nvim/vimrc"
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

# Todo manager {{{
alias t="todo"
alias ta="todo add"
alias tl="todo ls"
alias tla="todo ls agenda"
alias td="todo done"
alias te="todo edit"
# }}}

# }}}

# Completions & fzf {{{
complete -o bashdefault -o default -F _fzf_path_completion o # xdg-open alias completes with fzf when run o **
[ -f /usr/share/bash-completion/completions/pass ] && source /usr/share/bash-completion/completions/pass

[[ -d $HOME/.fzf ]] && export FZF_DEFAULT_OPTS='--tiebreak=end,length,index --color=16 --height 33% --reverse --border --cycle'
# [[ -d $HOME/.fzf ]] && export FZF_DEFAULT_COMMAND='fdfind'
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
# }}}

# Keybindings {{{
bind TAB:menu-complete
bind C-e:complete
bind Control-l:clear-screen
bind '"\C-a": " fj"'
bind '"\C-o": " fo"'
# }}}

# Shell options {{{
shopt -s autocd
shopt -s dirspell
shopt -s direxpand
shopt -s dirspell
shopt -s cdspell
shopt -s globstar
shopt -s extglob
shopt -s checkwinsize
shopt -s histappend
shopt -s cdable_vars
# }}}

# Functions {{{

# Altra roba {{{
dict() {
    curl dict://dict.org/d:${1} | less
}

devdocs () {
    $BROWSER "\!devdocs $*" && i3 [class=$BROWSER] focus
}

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
    # find $HOME -name "*.swp" -ok rm "{}" \;
    # find $HOME -name "*.swo" -ok rm "{}" \;
    rm -r ~/.local/share/nvim/swap/*
}

nack () {
    $EDITOR +Nack\ "$*"
}

# }}}

# Password manager {{{
p () {
    if [[ $1 =~ ls|find|grep|add|generate|show|insert|edit|rm|mv|cp|git|help|version ]]; then
        pass $*
    else
        edit_key=ctrl-v
        view_key=ctrl-c

        FILTER="s:${PW}/::;s:.gpg::"
        readarray PWS < <(/usr/bin/find $PW -type f | sed -e $FILTER)

        fzfOut=$(echo ${PWS[*]} | sed "s/ /\\n/g" | fzf --no-exact \
                --expect=$edit_key,$view_key,$pipe_key --query="$@"\
                --header="enter to copy, $edit_key to edit, $view_key to cat")
        first=$(echo $fzfOut | cut -d" " -f1)
        second=$(echo $fzfOut | cut -d" " -f2)

        if [[ ! -z $second ]]; then
            case "$first" in
                $edit_key) pass edit "$second";;
                $view_key) pass "$second";;
                *) pass -c "$second";;
            esac
        fi
    fi
}
# }}}

# Utility {{{

ding () {
    file=$P/Res/ping.opus
    mpv $file &>/dev/null &
}

# 25/5 - https://github.com/connermcd/gtd
gtd () {

    trap 'echo -ne "\nBrev, hai lavorato per $i cicli ($(( $i*25 )) minuti)"' 2 3 9 15
    i=0;
    getopts ":p" opt


    case ${opt} in 
        p)
            echo "$(date): 🍅 🎉 PAUSA"
            notify-send --urgency=critical "🍅 🎉" "Pausina" && ding && sleep $(( 60*5 ))
            ;;
    esac
    while :
    do
        echo "$(date): 🍅 💻 LAVORO"
        notify-send --urgency=critical "🍅 💻" "Lavora!" && ding && sleep $(( 60*25 ))
        i=$(( $i+1 ))
        echo "$(date): 🍅 🎉 PAUSA"
        notify-send --urgency=critical "🍅 🎉" "Pausina" && ding && sleep $(( 60*5 ))
    done;
}

share-home-network () {
    sqr "WIFI:S:Network Casa Vicinelli;T:WPA;P:$(pass Casa/wifi | head -n 1);;"
}

tny () {
    [[ $# -gt 0 ]] && ( wget -q -O - http://tny.im/yourls-api.php?action=shorturl\&format=simple\&url=$1; echo;) || echo "tny nttps://url.com"
}

wifi () {
    nmcli -a device wifi connect "$( nmcli --color no device wifi | grep -v ".*--.*" | fzf --query="$*" -1 --ansi --header-lines=1 | sed -r 's/^\s*\*?\s*//; s/\s*(Ad-Hoc|Infra).*//')"
}

push () {
    # Push a notification to all the devices connected by pushbullet
    [[ -z $PB_TOKEN ]] && echo "Devi impostare l'autenticazione per pushbullet! (https://docs.pushbullet.com/#api-quick-start)" && exit 1
    curl -s --header "Access-Token: $PB_TOKEN" \
        --header "Content-Type: application/json" \
        --data-binary "{\"body\":\"$*\",\"title\":\"Broadcasted Push\",\"type\":\"note\"}" \
        --request POST \
        https://api.pushbullet.com/v2/pushes \
        && exit 0 || exit 1
    echo
}

_qr () {
    if [[ $# -gt 0 ]]; then
        file=$(mktemp);
        qrencode -s 20 "$*" -o $file
        $OPEN $file
    fi
}

qr () {
    if [[ $# -gt 0 ]]; then
        MSG="$(echo $* | sed "s/ /\\ /g")"
        curl qrenco.de/"$*"
    else
        curl -F-=\<- qrenco.de
    fi
}

# Foreground a job searching the process name
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
    echo "Non ancora!"
}

function fix-mimecache () {
    cd ~/.local/share/applications/
    rm mimeinfo.cache
    ln -s $DF/mimeinfo.cache
    cd ~-
}

function gong () {
    if [[ $# -gt 0 ]]; then
        case $1 in
            "-g")
                time=$2
                shift
                shift
                mess=$*
                at $time <<<"notify-send --urgency=critical \"REMINDME\" \"$mess\" && mpv /usr/lib/libreoffice/share/gallery/sounds/gong.wav --speed=3.5";;# --volume=60";;
            *)
                time=$1
                shift
                mess=$*
                at $time <<<"notify-send --urgency=critical \"REMINDME\" \"$mess\"";;
        esac
    else
        echo "
gong [-g] <time_at_witch_to_gong> <message>

OPTIONS:
	-g : actually gong
"
    fi
}

# }}}

# }}}

# Prompt  & colors{{{

# http://unix.stackexchange.com/a/18443/27433
export PROMPT_COMMAND="history -a;history -n;prompt"

# Tomnomnom dotfiles {{{
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
txtrst='\[\e[0m\]'    # Text Reset
# }}}
prompt() {
    jobColor=${bldblu}
    todoColor=${bldgrn}
    dirColor=${bldpur}

    # Today's todos
    [[ -e $TD ]] && toDo=$(todo ls | wc -l) || toDo="x"
    [[ -e $TD ]] && toDoUrgent=$(todo ls | grep "^(A" | wc -l) || toDoUrgent="x"
    [[ $toDo -gt 0 ]] && todoColor=${bldylw}
    [[ $toDoUrgent -gt 0 ]] && todoColor=${bldred}

    # suspended jobs
    [[ ! $(jobs -ls | wc -l ) = 0 ]] && bg_jobs="(\j) "|| bg_jobs=""

    end="⚕"
    # end="🍺"
    # end="▶"
    # end=">"
    # end=":"
    # end="💰"

    if [[ $TERM = "dumb" ]]; then
        export PS1="[$toDo, [$toDoUrgent!]] $(ps1_hostname)\W $end " # Dumb terminal
    else
        export PS1="${jobColor}$bg_jobs${todoColor}[$toDo, [$toDoUrgent!]]${dirColor} $(ps1_hostname)\W ${todoColor}$end ${txtrst}"
    fi
}

ps1_hostname() {
    host=$(hostname)
    user=$(whoami)
    [[ ! "$host" =~ pelican|lenovo || "$user" != "vic" ]] && echo "$user@$host"
}
# }}}

# Tmux
# [[ -z $NVIM_LISTEN_ADDRESS && ! $TERM == "screen-256color" ]] && tmux new-session -A -s $(hostname)

# vim: fdm=marker
