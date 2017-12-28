## Script di post installazione e configurazione 

# Configuriamo git
git config --global user.email "emanuele.vicinelli@gmail.com"
git config --global user.name "Emanuele Vicinelli"

# Installo i pacchettini deb tattici
sudo apt install dirmngr
cd /tmp
wget -O libssl.deb "http://ftp.it.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb"
sudo dpkg -i libssl.deb
wget -O playerctl5.deb "https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb"
sudo dpkg -i playerctl5.deb

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Rimuovo le cose non necessarie
sudo apt remove gedit

# Installo le cose
sudo apt update
sudo apt install i3 i3blocks rofi vim vim-gtk3 terminator fonts-inconsolata compton arandr dunst spotify-client lxappearance xfce4-power-manager pavucontrol build-essential curl redshift-gtk vlc zip ufw tree xbacklight pass xclip rsync owncloud-client gnome-sushi gufw ranger at apt-transport-http libnotify-bin

# Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Aggiorno e pulisco tutto
sudo apt upgrade
sudo apt dist-upgrade
sudo apt clean
sudo apt autoremove
sudo apt autoclean

# Collego i dotfiles
mkdir $HOME/.config/dunst
ln -sf $HOME/Dotfiles/i3 $HOME/.config/i3
ln -sf $HOME/Dotfiles/terminator $HOME/.config/terminator
ln -sf $HOME/Dotfiles/bashrc $HOME/.bashrc
ln -sf $HOME/Dotfiles/rofi $HOME/.config/rofi
ln -sf $HOME/Dotfiles/vim/vimrc $HOME/.vimrc
ln -sf $HOME/Dotfiles/compton.conf $HOME/.compton.conf
ln -sf $HOME/Dotfiles/mimeapps.cache $HOME/.local/share/applications/mimeinfo.cache
sudo ln -sf $HOME/Dotfiles/dunstrc $HOME/.config/dunst/dunstrc

echo "Fatto, fai meglio a controllare però"
