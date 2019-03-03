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

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

# Rimuovo le cose non necessarie
apt remove gedit

# Installo le cose
apt update
apt install stow i3 i3blocks vim rxvt-unicode-256color compton arandr dunst spotify-client xfce4-power-manager pavucontrol build-essential curl redshift-gtk mpv zip ufw tree pass xclip rsync owncloud-client gufw at apt-transport-https libnotify-bin dh-autoreconf sxiv moreutils gcalcli texlive-latex-extra sshfs nautilus-dropbox kodi python3-pip

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

cd ~/Dotfiles
stow *
# }}}

echo "Fatto, fai meglio a controllare però. Poi riavvia"
# vim: fdm=marker
