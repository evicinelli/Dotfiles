#! /bin/bash

ESSENTIALS="git neovim make at pass coreutils moreutils curl apt-transport-https fd-find"
PANDOC="pandoc texlive-lang-italian pandoc-citeproc poppler-utils pdfgrep texlive-latex-recommended texlive-xetex texlive-luatex texlive-latex-extra librsvg2-bin"
UTIlS="kitty mpv meld imagemagick ffmpeg ruby-notify"
APPS="youtube-dl qutebrowser qbittorrent brave-browser obs-studio typora"
FLATPAK="spotify telegram teams parlatype anki"
SNAPS="spotify telegram teams"

# Dotfiles
cd
git init
git remote add origin https://github.com/evicinelli/Dotfiles
source ~/.bashrc

# Vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Repositories

## Brave
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

## Typora
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'

sudo apt update

# Apt
sudo apt install -y -m $ESSENTIALS
sudo apt install -y -m $PANDOC
sudo apt install -y -m $UTILS
sudo apt install -y -m $APPS

# Small bits
sudo ln -s /bin/fdfind /bin/fd

# Snaps
if [[ $(which snap) ]]; then
    for snap in $SNAP; do
        snap install $snap
    done
elif [[ $(which flatpak) ]]; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    for flatpak in $FLATPAK; do
        flatpak install $flatpak
    done
else
    echo "!! NO SNAP/FLATPAK INSTALLED"
fi

