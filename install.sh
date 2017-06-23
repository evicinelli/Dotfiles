#! /bin/bash

# Install essentials
apt install git wget i3 i3lock vim lxappearance arandr zip unzip xfce4-power-manager xfce4-volumed compton redshift-gtk

# Gtk theme + icon theme
add-apt-repository ppa:system76-dev/stable
apt update
apt install system76-pop-theme

# Install font

# Install rofi

# Install greenclip

# Install i3lock-fancy

# Install playerctl

# Install bonus

# Cloning Dotfiles
cd $HOME
git clone https://github.com/evicinelli/Dotfiles.git
ln -s i3 $HOME/.config/i3
ln -s fish $HOME/.config/fish
ln -s rofi $HOME/.config/rofi
ln -s terminator $HOME/.config/terminator
ln -s sublime-text $HOME/.config/sublime-text-3
ln -s compton.conf $HOME/.compton.conf
ln -s dunstrc /etc/

