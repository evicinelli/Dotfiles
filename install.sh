#! /bin/bash

# Install roba essential  
sudo apt install git wget i3 i3lock vim vim-gtk3 lxappearance arandr zip unzip xfce4-power-manager xfce4-volumed compton redshift-gtk dunst

# Install more stuff
sudo apt install fonts-inconsolata

# Install greenclip: the clipboard manager

# Install playerctl

# Setting up Dotfiles
cd $HOME
ln -sfn $HOME/.config/i3 ./i3
ln -sfn $HOME/.config/fish ./fish
ln -sfn $HOME/.config/rofi ./rofi
ln -sfn $HOME/.config/terminator -/terminator
ln -sfn $HOME/.config/sublime-text-3 ./sublime-text-3
ln -sfn $HOME/.compton.conf ./compton
ln -sfn $HOME/.gvim ./vim/gvim
ln -sfn $HOME/.vim ./vim/vim
ln -sf $HOME/.gvimrc ./vim/gvimrc
sudo ln -sf /etc/xdg/dunst/dunstrc ./dunstrc
