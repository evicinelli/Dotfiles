# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Global variables
export EDITOR='vim'
export VISUAL='gvim'
export DOTS='/home/vic/Dotfiles'
export UNI="/home/vic/Documenti/AppuntiUni"
export UNR="/home/vic/Documenti/AppuntiUni/Reti/Vic"
export UNS="/home/vic/Documenti/AppuntiUni/SO/Vic"
export OC="/home/vic/ownCloud"
export PWS="/home/vic/ownCloud/Archivio/Password-store"
export TODO="/home/vic/ownCloud/todo.txt"
export DONE="/home/vic/ownCloud/done.txt"
# Fish vi key bindings
fish_vi_key_bindings
