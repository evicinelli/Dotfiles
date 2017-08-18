#! /bin/bash

# Install roba essential  
apt install git wget i3 i3lock vim gvim lxappearance arandr zip unzip xfce4-power-manager xfce4-volumed compton redshift-gtk rofi dunst

# Install more stuff
apt install fonts-inconsolata

# Install greenclip: the clipboard manager
# -- Not very urgente

# Install playerctl
# -- Not very urgente

# Cloning Dotfiles
cd $HOME
git clone https://github.com/evicinelli/Dotfiles.git
ln -sf i3 $HOME/.config/i3
ln -sf fish $HOME/.config/fish
ln -sf rofi $HOME/.config/rofi
ln -sf terminator $HOME/.config/terminator
ln -sf sublime-text $HOME/.config/sublime-text-3
ln -sf compton.conf $HOME/.compton.conf
ln -sf dunstrc /etc/xdg/dunst/dunstrc
