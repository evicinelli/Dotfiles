# vim: fdm=marker

# Personal bin {{{
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.bin" ]] && export PATH="$HOME/.bin:$PATH"
# }}}

# Env {{{
export P="$HOME/pCloudDrive"
export DN="$P/Documenti/Todo/done.txt"
export DOC="$P/Documenti"
export DOWN="$HOME/Scaricati"
export GVS="$P/Gvs"
export LIB="$P/Libreria"
export MEDIA="$P/Media"
export NOTES="$P/Notes"
export TD="$P/Documenti/Todo/todo.txt"
export UNI="$P/Uni/"

# Uni
export MED="$UNI/Med-Notes"
export MED1="$MED/Med1"
export MED2="$MED/Med2"
export MED3="$MED/Med3"

# Current course
export MED_CURRENT=$MED3
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
alias ls='ls -h --color=auto --group-directories-first --sort=version'
alias mkdir="mkdir -pv"
alias pandoc="pandoc --filter=pandoc-citeproc -V subparagraph"
alias rm="rm -I"
alias sl='ls'

# Troppo lunghi da scrivere (o li sbaglio sempre)
alias amn="nv $MED"
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
alias gcal="gcalcli --calendar=\"Personale\""
alias httpserver="python -m ComplexHTTPServer 8000"
alias l='ls'
alias ll="ls -l"
alias mn2="nv $MED2"
alias mn="nv $MED_CURRENT"
alias myip="wget -qO - http://myip.dnsomatic.com && echo ''"
alias n="nv $NOTES"
alias netoff="nmcli networking off"
alias neton="nmcli networking on &"
alias o=open
alias pandoc-gvs="pandoc --standalone --reference-doc=$GVS/res/reference-doc.odt "
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

# Bashrc {{{
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
# }}}
