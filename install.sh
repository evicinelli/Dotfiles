sudo apt install fish i3 rofi terminator vim vim-gtk3 fonts-inconsolata

ln -sf $HOME/Dotfiles/i3 $HOME/.config/i3
ln -sf $HOME/Dotfiles/terminator $HOME/.config/terminator
ln -sf $HOME/Dotfiles/fish $HOME/.config/fish
ln -sf $HOME/Dotfiles/rofi $HOME/.config/rofi
ln -sf $HOME/Dotfiles/sublime-text $HOME/.config/sublime-text
ln -sf $HOME/Dotfiles/vim/gvim $HOME/.gvim
ln -sf $HOME/Dotfiles/vim/vim $HOME/.vim
ln -sf $HOME/Dotfiles/vim/gvimrc $HOME/.gvimrc
ln -sf $HOME/Dotfiles/compton.conf $HOME/.compton.conf
mkdir $HOME/.config/dunst
sudo ln -sf $HOME/Dotfiles/dunstrc $HOME/.config/dunst/dunstrc
ln -sf $HOME/Dotfiles/mimeapps.list $HOME/.config/mimeapp.list
echo "Fatto"
