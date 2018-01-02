# Defaults  {{{
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
    xterm-*color) color_prompt=yes;;

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

# Vim keys and general keybindings
set -o vi
bind TAB:menu-complete
bind Control-l:clear-screen

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
shopt -s checkwinsize
shopt -s histappend

# Source alias and variables
source ~/Dotfiles/bash_alias

# Source functions
source ~/Dotfiles/bash_functions

# Prompt
ps1_hostname() {
    host=$(hostname)
    user=$(whoami)
}

if [ "$color_prompt" = "yes" ]; then
    PS1="$(ps1_hostname)\[\e[1;36m\]\W\[\e[1;31m\]:\[\e[0m\] "
else
    PS1="$(ps1_hostname)\W: "
fi
# Sourcing external files
source /usr/share/bash-completion/completions/pass

# Motivational quote
# echo -ne "\n\n"
# echo -ne "\t\t\t\t\t $(motivation)"
# echo -ne "\n\n"
