# Defaults  {{{
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
BASH_ENV=~/.profile

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
    *)
	;;
esac

# Do we want color?
case "$TERM" in
    xterm-*color|rxvt-unicode-256color) color_prompt=yes;;
    *) color_prompt=no;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
    fi
fi
# }}}

# Mia robina {{{

# Source stuff
source ~/Dotfiles/bash_alias
source ~/Dotfiles/bash_functions
source /usr/share/bash-completion/completions/pass
[[ -r .bashrc_local ]] && source .bashrc_local

# Vim keys and general keybindings
set -o vi
bind TAB:menu-complete
bind Control-l:clear-screen
bind 'Control-k:"clear; l\n"'

# Shell options
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

# Prompt
export PROMPT_COMMAND=prompt

prompt() {
    toDo=$(tl | grep -v "^x .*"| count)
    toDoUrgent=$(tl | sort | grep "^(.*" | count)
    if [ "$color_prompt" = "yes" ]; then
        export PS1="$(ps1_hostname)\[\e[1;36m\]\W\[\e[1;31m\] [$toDo, [$toDoUrgent!]]:\[\e[0m\] "
    else
        export PS1="$(ps1_hostname)\W [$toDo, [$toDoUrgent!]]: "
    fi
}

ps1_hostname() {
    host=$(hostname)
    user=$(whoami)
    if [[ "$host" != "pelican" || "$user" != "vic" ]]; then
        if ["$color_prompt" = "yes"]; then
            echo "\[\e[1;30m\]$user\[\e[0;37m\]@\[\e[1;36m\]$host "
        else
            echo "$user@$host "
        fi
    fi
}

# Base16 colorscheme stuff
if [ "$color_prompt" = "yes" ]; then
    BASE16_SHELL=$HOME/Scaricati/Apps/base16-shell/
    [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

# vim: fdm=marker
