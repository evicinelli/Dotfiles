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

# Fzf
[[ -d $HOME/.fzf ]] || (echo "Installing fzf... " && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install)
[[ -d $HOME/.fzf ]] && export FZF_DEFAULT_OPTS='--tiebreak=end,length,index --color=16 --height 33% --reverse --border --cycle'
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Ultime cose
export PATH=${PATH}:$HOME/.local/bin
export EDITOR=vim
# }}}

# Variables {{{
export TERMINAL=kitty
export OPEN=mimeopen

export P="/home/vic/pCloudDrive"
export DN="$P/Documenti/Todo/done.txt"
export DOC="$P/Documenti"
export DOWN="$HOME/Scaricati"
export GVS="$P/Gvs"
export MEDIA="$P/Media"
export NOTES="$P/Notes"
export PW="$P/Documenti/Password-store"
export TD="$P/Documenti/Todo/todo.txt"
export UNI="$P/Uni/AppuntiUni"

# Uni
export MED="$P/Uni/Appunti/Medicina/Med2"
export MED1="$P/Uni/Appunti/Medicina/Med1"

[[ -r ~/.bashrc_local ]] && source ~/.bashrc_local
# }}}

# Alias {{{
alias dir='dir --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias ls='ls -h --color=auto --group-directories-first'
alias pandoc="pandoc --pdf-engine=xelatex"
alias rm="rm -I"
alias sl='ls'
alias sort="sort -n"
alias vdir='vdir --color=auto'

# Troppo lunghi da scrivere (o li sbaglio sempre)
alias audio-rec="ffmpeg -f alsa -ac 2 -i hw:0"
alias bashrc="$EDITOR $HOME/.bashrc && source $HOME/.bashrc"
alias bc="bc -l"
alias beamer="pandoc -t beamer -H $P/Modelli/beamer.tex"
alias clipboard="xclip -selection PRIMARY"
alias cp="rsync --archive --verbose --human-readable"
alias gcal="gcalcli --calendar=\"Personale\""
alias httpserver="python -m SimpleHTTPServer 8000"
alias l='ls'
alias ll="ls -l"
alias mkdir="mkdir -pv"
alias mn="notability $MED/.."
alias myip="wget -qO - http://myip.dnsomatic.com && echo ''"
alias n="notability $NOTES"
alias netoff="nmcli networking off"
alias neton="nmcli networking on &"
alias o="$OPEN"
alias open="$OPEN"
alias pandoc-gvs="pandoc --standalone --reference-doc=$GVS/res/reference-doc.odt "
alias py="python"
alias scp="rsync --archive --checksum --compress --human-readable --itemize-changes --rsh=ssh --stats --verbose"
alias unicode='echo "✓   ™   ♪   ♫   ☃   °   Ɵ   ∫   ❤   ☤   ⚕   ‘  ’   “  ”   ‚  „   ′  ″  ‹›   «  »   -  –  (  /  )  [  |  ]  {  \  }   *   †  ‡  §  ¶  |  ‖   @   №   $  £  ¥  €  ₹  ₺  ₽  ¢  ƒ   %  ‰   ¼  ½  ¾  ⅓  ⅔  ⅛  ⅜  ⅝   +  −  ×  ÷  ∙  =  <  >  ≤  ≥  ±  ^  ≠  ~  ≈  ¬   #  π  ∞  µ  ∂  ∫  √   •  ◦  ▪  ▫  ▴  ▸  ▾  ◂  ▵  ▹  ▿  ◃   ●  ○  ■  □  ▲  ▶  ▼  ◀  △  ▷  ▽  ◁  ❒  ◆  ►  ◄  ◙  ◉  ◘   ←  ↖  ↑  ↗  →  ↘  ↓  ↙   ⇐  ⇑  ⇒  ⇓   ↔  ↕  ↨   ♀  ♂   ☼  ⌂   ☑   ✓   ☻   ☕   💩   🤖   🔒  🍺  🚑  👍  👌  💪                 "'
alias vimrc="vi $HOME/.config/vim/vimrc"

# Git
alias g="git"
alias gs="git status"
alias gd="git diff"
alias grm="git remove"
alias ga="git add"
alias gc="git commit"
alias gpush="git push"
alias gpull="git pull"
alias glog="git log --graph --oneline"

# Todo
alias ta="todo add"
alias tl="todo ls"
alias tg="todo agenda"
alias td="todo done"
alias te="todo edit"

# }}}

# Completions {{{
complete -o bashdefault -o default -F _fzf_path_completion o
complete -o bashdefault -o default -F _fzf_path_completion open
[ -f /usr/share/bash-completion/completions/pass ] && source /usr/share/bash-completion/completions/pass
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
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkjobs
shopt -s checkwinsize
shopt -s direxpand
shopt -s dirspell
shopt -s extglob
shopt -s globstar
shopt -s histappend
# }}}

# Functions {{{
dict() {
    wget -qO - dict://dict.org/d:${1} | less
}

cswp () {
    [[ $(ls ~/.local/share/nvim/swap/ | wc -l) -gt 0 ]] && rm -r ~/.local/share/nvim/swap/*
}

nack () {
    $EDITOR +Nack\ "$*"
}

ding () {
    file=$P/Res/ping.opus
    mpv $file &>/dev/null &
}

share-home-network () {
    sqr "WIFI:S:Network Casa Vicinelli;T:WPA;P:$(pass Casa/wifi | head -n 1);;"
}

tny () {
    [[ $# -gt 0 ]] && ( wget -q -O - http://tny.im/yourls-api.php?action=shorturl\&format=simple\&url=$1; echo;) || echo "tny https://url.com"
}

wifi () {
    nmcli -a device wifi connect "$( nmcli --color no device wifi | grep -v ".*--.*" | fzf --query="$*" -1 --ansi --header-lines=1 | sed -r 's/^\s*\*?\s*//; s/\s*(Ad-Hoc|Infra).*//')"
}

# Foreground a job searching the process name
fj () {
    job=$(jobs -ls | fzf -1 -0 --query="$*" | cut -d" " -f1 | grep -Eo "[0-9]+")
    [[ ! -z $job ]] && fg $job
}

wttr () {
    CITY=`sed "s/ /+/g" <<< "$*"`
    wget -qO - "https://wttr.in/~$CITY"
}

daysuntil () {
    echo $(( ($(date "+%s" -d "$*") - $(date "+%s" -d "today")) / (60*60*24) ))
}

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
    [[ -e $TD ]] && toDoUrgent=$(todo urgent | wc -l) || toDoUrgent="x"
    [[ $toDo -gt 0 ]] && todoColor=${bldylw}
    [[ $toDoUrgent -gt 0 ]] && todoColor=${bldred}

    # suspended jobs
    [[ $(jobs | wc -l ) -gt 0 ]] && bg_jobs="(\j) " || bg_jobs=""

    # end="⚕" end="🍺" end=">" end=":" end="💰"
    end="▶"

    if [[ $TERM = "dumb" ]]; then
        export PS1="[$toDo, [$toDoUrgent!]] $(ps1_hostname)\W $end " # Dumb terminal
    else
        export PS1="${jobColor}$bg_jobs${todoColor}[$toDo, [$toDoUrgent!]]${dirColor} $(ps1_hostname)\W ${todoColor}$end ${txtrst}"
    fi
}

ps1_hostname() {
    host=$(hostname)
    user=$(whoami)
    [[ ! "$host" =~ pelican || "$user" != "vic" ]] && echo "$user@$host "
}
# }}}

# vim: fdm=marker
