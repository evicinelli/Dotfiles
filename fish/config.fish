# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Setting gvim as editor
export EDITOR='gvim'
export VISUAL='gvim'
export DOTFILES='/home/vic/Dotfiles'

# Fish vi key bindings
fish_vi_key_bindings
