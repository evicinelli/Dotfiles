# Initial setup  {{{

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# History
HISTCONTROL="ignoredups:erasedups:ignoreboth" # Avoid duplicates
HISTSIZE= HISTFILESIZE= # Infinite history
HISTTIMEFORMAT='%F %T '
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:fj:fo:unsplash" # Do not append to history

# Colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Fzf <3
[[ -d $HOME/.fzf ]]     || (echo "Installing fzf... " && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install)
[[ -d $HOME/.fzf ]]     && export FZF_DEFAULT_OPTS='--tiebreak=end,length,index --color=16 --height 33% --reverse --border --cycle --multi'
[[ -f ~/.fzf.bash ]]    && source ~/.fzf.bash
[[ fd ]]                && export FZF_DEFAULT_COMMAND="fd -I --color never" && export FZF_ALT_C_COMMAND="fd -I -t d --color never" && export FZF_CTRL_T_COMMAND="fd -I --color never"

# export PATH=${PATH}:$HOME/.bin/:$HOME/.local/bin/
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=kitty
[[ nvim ]] && export MANPAGER='nvim +Man!'
# }}}

# Completions {{{
# Bash default completion
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Fzf completion
complete -o bashdefault -o default -F _fzf_path_completion o
complete -o bashdefault -o default -F _fzf_path_completion open

# Pass completion
[ -f /usr/share/bash-completion/completions/pass ] && source /usr/share/bash-completion/completions/pass && complete -o filenames -F _pass p
# }}}

# Keybindings {{{
bind TAB:menu-complete
bind C-e:complete
bind C-l:clear-screen

# Make C-z work -- https://www.reddit.com/r/vim/comments/gxoupg/on_the_use_of_vim_in_slow_and_restricted/ft52cvb?utm_source=share&utm_medium=web2x
stty susp undef # Terminal magic
bind '"\C-z": " fj
"'
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

# Job control
fj () {
	job=$(jobs -ls | fzf -1 --query="$*" | cut -d" " -f1 | grep -Eo "[0-9]+")
	[[ ! -z $job ]] && fg $job

	# TODO
	# C-B: background selected jobs
	# C-K: kill selected job
	# C-D: disown selected job
}

# Other functions
source ~/.bash_functions

# }}}

# Prompt {{{

# http://unix.stackexchange.com/a/18443/27433
export PROMPT_COMMAND="history -a;history -n;prompt"
# export BG=light

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
txtbriblk='\[\e[0;90m\]' # Black - Regular - Bright
txtbrired='\[\e[0;91m\]' # Red
txtbrigrn='\[\e[0;92m\]' # Green
txtbriylw='\[\e[0;93m\]' # Yellow
txtbriblu='\[\e[0;94m\]' # Blue
txtbripur='\[\e[0;95m\]' # Purple
txtbricyn='\[\e[0;96m\]' # Cyan
txtbriwht='\[\e[0;97m\]' # White
bldbriblk='\[\e[1;90m\]' # Black - Bold - Bright
bldbrired='\[\e[1;91m\]' # Red
bldbrigrn='\[\e[1;92m\]' # Green
bldbriylw='\[\e[1;93m\]' # Yellow
bldbriblu='\[\e[1;94m\]' # Blue
bldbripur='\[\e[1;95m\]' # Purple
bldbricyn='\[\e[1;96m\]' # Cyan
bldbriwht='\[\e[1;97m\]' # White
txtrst='\[\e[0m\]'    # Text Reset
# }}}

prompt() {
	jobColor=${bldblu}
	todoColor=${bldgrn}
	dirColor=${bldpur}

	# Today's todos
	[[ -e $TD ]] && toDo=$(todo ls | wc -l) || toDo="x"
	[[ -e $TD ]] && toDoUrgent=$(todo urgent | wc -l) || toDoUrgent="x"
	[[ $toDo -gt 0 ]] && todoColor=${bldbriylw}
	[[ $toDoUrgent -gt 0 ]] && todoColor=${bldbrired}

	# suspended jobs
	[[ $(jobs | wc -l ) -gt 0 ]] && bg_jobs="(\j) " || bg_jobs=""

	# end="🍺" end=":" end="💰" end="⚕" end="▶" end=">" end="🩺"
	end=">"

	export PS1="${jobColor}$bg_jobs${todoColor}[$toDo, $toDoUrgent!]${dirColor} $(ps1_hostname)\W ${todoColor}$end ${txtrst}"
}

ps1_hostname() {
	# host=$(hostname)
	# user=$(whoami)
	# [[ ! "$host" =~ pelican|lenovino || "$user" != "vic" ]] && echo "$user@$host "
	echo ''
}
# }}}

# Tmux
# [[ -z $NVIM_LISTEN_ADDRESS && ! $TERM == "screen-256color" && $(which tmux) ]] && tmux new-session -A -s $(hostname)

# vim: fdm=marker
