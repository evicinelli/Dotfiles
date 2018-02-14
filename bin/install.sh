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
# sudo apt remove gedit

# Installo le cose
sudo apt update
sudo apt install i3 i3blocks rofi vim vim-gtk3 rxvt-unicode-256color fonts-inconsolata compton arandr dunst spotify-client lxappearance xfce4-power-manager pavucontrol build-essential curl redshift-gtk vlc zip ufw tree xbacklight pass xclip rsync owncloud-client gnome-sushi gufw ranger at apt-transport-https libnotify-bin mplayer dh-autoreconf sxiv moreutils gcalcli texlive-latex-extra

# Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Modifichine ai file di configurazione in giro
sudo tee -a /usr/share/bash-completion/completions/pass << EOF
complete -o filenames -o nospace -F _pass p
EOF

# Aggiorno e pulisco tutto
sudo apt upgrade
sudo apt dist-upgrade
sudo apt clean
sudo apt autoremove
sudo apt autoclean

# Collego i dotfiles
mkdir $HOME/.config/dunst
cd $HOME/.config/                   ; ln -sf $HOME/Dotfiles/i3
cd $HOME/.config/                   ; ln -sf $HOME/Dotfiles/terminator
cd $HOME/                           ; ln -sf $HOME/Dotfiles/bashrc
cd $HOME/.config/                   ; ln -sf $HOME/Dotfiles/rofi
cd $HOME/                           ; ln -sf $HOME/Dotfiles/vim/vimrc
cd $HOME/                           ; ln -sf $HOME/Dotfiles/compton.conf
cd $HOME/                           ; ln -sf $HOME/Dotfiles/gtkrc-2.0.mine .gtkrc-2.0
cd $HOME/.local/share/applications/ ; ln -sf $HOME/Dotfiles/mimeinfo.cache
cd $HOME/.config/dunst/             ; ln -sf $HOME/Dotfiles/dunstrc

echo "Fatto, fai meglio a controllare però"
