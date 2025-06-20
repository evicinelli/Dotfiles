# vim: fdm=marker

# Fzf <3
[[ -d $HOME/.fzf ]]     || (echo "Installing fzf... " && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install)
[[ -f ~/.fzf.bash ]]    && source ~/.fzf.bash

# MacOs wtf {{{
# Fuck MacOs that has BSD coreutils and fuck hombrew that will not install GNU coreutils with their default name

$(which brew) && for d in "$(brew --prefix)"/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
# }}}

# Personal bin {{{
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.bin" ]] && export PATH="$HOME/.bin:$PATH"
# }}}

# Env {{{
# export VISUAL=vimr
[[ $(which nvim) ]] && export MANPAGER='nvim +Man!' && export EDITOR=nvim

export P="$HOME/pCloudDrive"
export DN="${P}/Notes/done.txt"
export DOC="${P}/Documenti"
export DOWN="$HOME/Scaricati"
export GVS="${P}/Gvs"
export LIB="${P}/Libreria"
export MEDIA="${P}/Media"
export NOTES="${P}/Notes"
export S="${P}/Backups/Google Photos - Emanuele Vicinelli/Screenshot"
export TD="${P}/Notes/todo.txt"

# Uni
export UNI="${P}/Uni/"
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
