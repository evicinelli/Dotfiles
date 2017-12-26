# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Defaults  {{{
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
    *)
	;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
    fi
fi
# }}}

# Mia robina {{{

# Vim keys
set -o vi
bind TAB:menu-complete
bind Control-l:clear-screen

# VARS
export EDITOR=vim
export DF='/home/vic/Dotfiles'
export UNI="/home/vic/Documenti/AppuntiUni"
export UNR="/home/vic/Documenti/AppuntiUni/Reti/Vic"
export UNS="/home/vic/Documenti/AppuntiUni/SO/Vic"
export OC="/home/vic/ownCloud"
export PW="/home/vic/ownCloud/Archivio/Password-store"
export TD="/home/vic/ownCloud/todo.txt"
export DN="/home/vic/ownCloud/done.txt"
source $DF/bash_alias

source $DF/bash_functions

# Prompt
ps1_hostname() {
    host=$(hostname)
    user=$(whoami)
    if [[ "$host" != "pelican" || "$user" != "vic" ]]; then
	echo "\[\e[1;30m\]$user\[\e[0;37m\]@\[\e[1;36m\]$host "
    fi
}

PS1="$(ps1_hostname)\[\e[1;36m\]\W\[\e[1;31m\]:\[\e[0m\] "


# Funzioni
ffind() {
    find $1 -type f -name $2 2> /dev/null
}

dirfind() {
    find $1 -type d -name $2 2> /dev/null
}

todo-add(){
    echo "$1 @background">> $TD
}

# Sourcing external files
source /usr/share/bash-completion/completions/pass

# Alias definitions.
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='pwd;ls --group-directories-first -l -h'
alias gi="gvim"
alias o="xdg-open"
alias t="tree . -L 1"
alias tt="tree . -L 2"
alias ttt="tree . -L 3"
alias h="man"
alias pfind="bash /home/vic/Dotfiles/bin/fpass"
