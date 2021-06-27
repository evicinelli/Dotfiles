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

# Fzf
export FZF_DEFAULT_OPTS='--color=16 --height 33% --reverse --border --cycle --multi'
[[ fd ]] && export FZF_DEFAULT_COMMAND="fd -I --color never" && export FZF_ALT_C_COMMAND="fd -I -t d --color never" && export FZF_CTRL_T_COMMAND="fd -I --color never"
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
