## Script di post installazione e configurazione 

# Configuriamo git {{{
git config --global user.email "emanuele.vicinelli@gmail.com"
git config --global user.name "Emanuele Vicinelli"
# }}}

# Apt {{{
# Installo i pacchettini deb tattici
apt install dirmngr
cd /tmp
# Libssl
wget -O libssl.deb "http://ftp.it.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb"
dpkg -i libssl.deb

# Playerctl
wget -O playerctl5.deb "https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb"
dpkg -i playerctl5.deb

# TODO fd -- very fast find

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

# Rimuovo le cose non necessarie
apt remove gedit

# Installo le cose
apt update
apt install i3 i3blocks vim vim-gtk3 rxvt-unicode-256color compton arandr dunst spotify-client xfce4-power-manager pavucontrol build-essential curl redshift-gtk vlc zip ufw tree xbacklight pass xclip rsync owncloud-client gufw ranger at apt-transport-https libnotify-bin dh-autoreconf sxiv moreutils gcalcli texlive-latex-extra mpv sshfs nautilus-dropbox kodi python3-pip

# Aggiorno e pulisco tutto
apt upgrade
apt dist-upgrade
apt clean
apt autoremove
apt autoclean


#}}}

# Altro {{{
# Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Modifichine ai file di configurazione in giro
touch ~/.inputrc
echo -ne "set editing-mode vi\nset completion-ignore-case on\nset show-all-if-ambiguous on" >> ~/.inputrc

echo -ne "source $HOME/.bashrc" >> $HOME/.bash_profile

# Pywal
pip3 install --user pywal

# Collego i dotfiles
mkdir $HOME/.config/dunst
cd $HOME/.config/                   ; ln -sf $HOME/Dotfiles/i3
cd $HOME/                           ; ln -sf $HOME/Dotfiles/bashrc ./.bashrc
cd $HOME/                           ; ln -sf $HOME/Dotfiles/vim ./.vim
cd $HOME/                           ; ln -sf $HOME/Dotfiles/compton.conf ./.compton.conf
cd $HOME                            ; ln -s ~/Dotfiles/i3/i3blocks.conf ./.i3blocks.conf
cd $HOME/.local/share/applications/ ; ln -sf $HOME/Dotfiles/mimeinfo.cache
cd $HOME/.config/dunst/             ; ln -sf $HOME/Dotfiles/dunstrc
# }}}

echo "Fatto, fai meglio a controllare però. Poi riavvia"
# vim: fdm=marker