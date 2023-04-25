# vim: fdm=marker

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

[ -f /System/Volumes/Data/usr/local/Cellar/pass/1.7.4/etc/bash_completion.d/pass ] && source /System/Volumes/Data/usr/local/Cellar/pass/1.7.4/etc/bash_completion.d/pass && complete -o filenames -F _pass p
# }}}

# Keybindings {{{
bind TAB:menu-complete
bind C-e:complete
bind C-l:clear-screen

# Make C-z work -- https://www.reddit.com/r/vim/comments/gxoupg/on_the_use_of_vim_in_slow_and_restricted/ft52cvb?utm_source=share&utm_medium=web2x
# stty susp undef # Terminal magic, sadly not working in macos
# bind '"\C-z": " fj\n "'
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
txtblk='\[\033[0;30m\]' # Black - Regular
txtred='\[\033[0;31m\]' # Red
txtgrn='\[\033[0;32m\]' # Green
txtylw='\[\033[0;33m\]' # Yellow
txtblu='\[\033[0;34m\]' # Blue
txtpur='\[\033[0;35m\]' # Purple
txtcyn='\[\033[0;36m\]' # Cyan
txtwht='\[\033[0;37m\]' # White
bldblk='\[\033[1;30m\]' # Black - Bold
bldred='\[\033[1;31m\]' # Red
bldgrn='\[\033[1;32m\]' # Green
bldylw='\[\033[1;33m\]' # Yellow
bldblu='\[\033[1;34m\]' # Blue
bldpur='\[\033[1;35m\]' # Purple
bldcyn='\[\033[1;36m\]' # Cyan
bldwht='\[\033[1;37m\]' # White
txtbriblk='\[\033[0;90m\]' # Black - Regular - Bright
txtbrired='\[\033[0;91m\]' # Red
txtbrigrn='\[\033[0;92m\]' # Green
txtbriylw='\[\033[0;93m\]' # Yellow
txtbriblu='\[\033[0;94m\]' # Blue
txtbripur='\[\033[0;95m\]' # Purple
txtbricyn='\[\033[0;96m\]' # Cyan
txtbriwht='\[\033[0;97m\]' # White
bldbriblk='\[\033[1;90m\]' # Black - Bold - Bright
bldbrired='\[\033[1;91m\]' # Red
bldbrigrn='\[\033[1;92m\]' # Green
bldbriylw='\[\033[1;93m\]' # Yellow
bldbriblu='\[\033[1;94m\]' # Blue
bldbripur='\[\033[1;95m\]' # Purple
bldbricyn='\[\033[1;96m\]' # Cyan
bldbriwht='\[\033[1;97m\]' # White
txtrst='\[\033[0m\]'    # Text Reset
# }}}

prompt() {
	jobColor=${bldblu}
	todoColor=${bldgrn}
	dirColor=${bldpur}

	# Today's todos
	[[ -e $TD ]] && toDo=$(todo ls | wc -l | sed "s/ //g") || toDo="x"
	[[ -e $TD ]] && toDoUrgent=$(todo urgent | wc -l | sed "s/ //g") || toDoUrgent="x"
	[[ $toDo -gt 0 ]] && todoColor=${bldbriylw}
	[[ $toDoUrgent -gt 0 ]] && todoColor=${bldbrired}

	# suspended jobs
	[[ $(jobs | wc -l ) -gt 0 ]] && bg_jobs="(\j) " || bg_jobs=""

	# end="🍺" end=":" end="💰" end="⚕" end="▶" end=">" end="🩺"
	# end=">"
	end="\$"

	export PS1="${jobColor}$bg_jobs${todoColor}[$toDo, $toDoUrgent!]${dirColor} $(ps1_hostname)\W ${todoColor}$end ${txtrst}"
}

ps1_hostname() {
	# host=$(hostname)
	# user=$(whoami)
	# [[ ! "$host" =~ pelican|lenovino || "$user" != "vic" ]] && echo "$user@$host "
	echo ''
}
# }}}

# Alias {{{
# Useful options
alias dir='dir --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias gtd="gtd -t -n"
alias la="ls -a"
alias less='less -R'
alias ll="ls -l"
alias lla="ls -la"
# alias ls='ls -h --color=auto --group-directories-first --sort=version'
# alias mkdir="mkdir -pv"
# alias pandoc="pandoc --filter=pandoc-citeproc -V subparagraph"
# alias rm="rm -I"
alias sl='ls'

# Troppo lunghi da scrivere (o li sbaglio sempre)
alias amn="nv \"$MED\""
alias ascii="man ascii | tail -n 42 | head -n 20"
alias audio-rec="ffmpeg -f alsa -ac 2 -i hw:0"
alias bashrc="$EDITOR $HOME/.bashrc && source $HOME/.bashrc"
alias bc="bc -l"
alias beamer="pandoc -t beamer -H $P/Modelli/beamer.tex"
alias brownnoise="play -t sl -r48000 -c2 -n synth -1 brownnoise .1 60"
alias clipboard="xclip -selection PRIMARY"
alias cp="rsync --archive --verbose --human-readable --progress --whole-file"
alias enit="trans en:it"
alias g="git"
alias httpserver="python -m ComplexHTTPServer 8000"
alias l='ls'
alias ll="ls -l"
alias mn2="nv \"$MED2\""
alias mn="nv \"$MED_CURRENT\""
alias myip="wget -qO - http://myip.dnsomatic.com && echo ''"
alias n="nv \"$NOTES\""
alias netoff="nmcli networking off"
alias neton="nmcli networking on &"
alias o=open
alias pandoc-gvs="pandoc --standalone --reference-doc=\"$GVS\"/res/reference-doc.odt "
alias pdfgrep="pdfgrep -i --color=always"
alias py="python"
alias qr="qrencode --type=UTF8 -o -"
alias scp="rsync --archive --checksum --compress --human-readable --itemize-changes --rsh=ssh --stats --verbose"
alias tm="tmux attach || tmux"
alias te="todo edit"
alias unicode='echo -e "   \n # () * + - / < = > @ [ \ ] ^ { | } \n ~ § « ¬ ° ± ¶ » × ÷ – ‖ \n ‘ ’ ‚ “ ” „ † ‡ • ‰ ′ ″ ‹› \n ← ↑ → ↓ ↔ ↕ ↖ ↗ ↘ ↙ ↨ ⇐ ⇑ ⇒ ⇓ \n ∂ − ∙ √ ∞ ∫ ≈ ≠ ≤ ≥ \n ⌂ ■ □ ▪ ▫ ▲ △ ▴ ▵ ▶ ▷ ▸ ▹ ► ▼ ▽ ▾ ▿ ◀ ◁ ◂ ◃ ◄ ◆ ◉ ○ ● ◘ ◙ ◦ ☃ ☑ \n ☕ ☤ ☻ ☼ ♀ ♂ ♪ ♫ ⚕ ✓ ❒ ❤ ❤️ 🍺 👌 👍 💩 💪 🔒 🚑 🤖 ¢\n  $ £ ¥ € ₹ ₺ ₽ \n ½ ⅓ ¼ ⅛ ⅔ ¾ ⅜ ⅝ \n ƒ № Ɵ µ π "'

# Special Todo.txt files
alias unitodo="TD=$P/Documenti/Todo/_uni.todo.txt todo"
alias mambutodo="TD=$P/Documenti/Todo/_mambu.todo.txt todo"

# }}}

# Misc {{{
#[[ -z $NVIM_LISTEN_ADDRESS && ! $TERM == "screen-256color" && $(which tmux) ]] && tmux new-session -A -s $(hostname)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# }}}

