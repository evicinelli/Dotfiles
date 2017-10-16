#! /bin/bash

# Install roba essential  
apt install git wget i3 i3lock vim gvim lxappearance arandr zip unzip xfce4-power-manager xfce4-volumed compton redshift-gtk dunst

# Install more stuff
apt install fonts-inconsolata

# Install greenclip: the clipboard manager
# -- Not very urgente

# Install playerctl
# -- Not very urgente

# Cloning Dotfiles
cd $HOME
git clone https://github.com/evicinelli/Dotfiles.git
ln -sfn i3 $HOME/.config/i3
ln -sfn fish $HOME/.config/fish
ln -sfn rofi $HOME/.config/rofi
ln -sfn terminator $HOME/.config/terminator
ln -sfn sublime-text $HOME/.config/sublime-text-3
ln -sfn compton.conf $HOME/.compton.conf
ln -sfn vim/gvim $HOME/.gvim
ln -sfn vim/vim $HOME/.vim
ln -sf vim/gvimrc $HOME/.gvimrc
sudo ln -sf dunstrc /etc/xdg/dunst/dunstrc
