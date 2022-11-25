# vim: fdm=marker

# Fzf <3
[[ -d $HOME/.fzf ]]     || (echo "Installing fzf... " && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install)
[[ -f ~/.fzf.bash ]]    && source ~/.fzf.bash

# MacOs wtf {{{
# Fuck MacOs that has BSD coreutils and fuck hombrew that will not install GNU coreutils with their default name

for d in "$(brew --prefix)"/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
# }}}

# Personal bin {{{
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.bin" ]] && export PATH="$HOME/.bin:$PATH"
# }}}

# Env {{{
export EDITOR=nvim
# export VISUAL=vimr
[[ nvim ]] && export MANPAGER='nvim +Man!'

export P="$HOME/pCloud Drive"
export DN="${P}/Documenti/Todo/done.txt"
export DOC="${P}/Documenti"
export DOWN="$HOME/Scaricati"
export GVS="${P}/Gvs"
export LIB="${P}/Libreria"
export MEDIA="${P}/Media"
export NOTES="${P}/Notes"
export TD="${P}/Documenti/Todo/todo.txt"
export UNI="${P}/Uni/"

# Uni
export MED="${UNI}/Med-Notes"
export MED1="${MED}/Med1"
export MED2="${MED}/Med2"
export MED3="${MED}/Med3"
export MED4="${MED}/Med4"
export MED5="${MED}/Med5"
export MED6="${MED}/Med6"

# Current course
export MED_CURRENT=$MED4

# Fzf
export FZF_DEFAULT_OPTS='--color=16 --height 33% --reverse --border --cycle --multi'
[[ fd ]] && export FZF_DEFAULT_COMMAND="fd --color never" && export FZF_ALT_C_COMMAND="fd -t d --color never" && export FZF_CTRL_T_COMMAND="fd --color never"
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
