# vim: fdm=marker
#! /bin/bash

IFS=$' '

ESSENTIALS="git neovim tmux make at pass coreutils moreutils curl apt-transport-https fd-find flatpak python"
PANDOC="pandoc texlive-lang-italian pandoc-citeproc poppler-utils pdfgrep texlive-latex-recommended texlive-xetex texlive-luatex texlive-latex-extra librsvg2-bin texlive-fonts-extra"
UTILS="kitty mpv meld imagemagick-6.q16hdri potrace ffmpeg ruby-notify playerctl gnome-sushi"
APPS="youtube-dl qutebrowser qbittorrent brave-browser obs-studio"
FLATPAK="telegram spotify com.microsoft.Teams parlatype anki com.gigitux.gtkwhats us.zoom.Zoom com.anydesk.Anydesk com.skype.Client com.rafaelmardojai.Blanket"
PIP3="subliminal ComplexHTTPServer"
# SNAPS="spotify telegram teams"

# Repositories {{{

## Brave
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# ## Typora
# wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# sudo add-apt-repository 'deb https://typora.io/linux ./'

sudo apt update

# }}}

# Install packages/flatpak/snap {{{
sudo apt install -y $ESSENTIALS $PANDOC $UTILS $APPS
sudo pip3 install $PIP3

if [[ $(which flatpak) ]]; then
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install $FLATPAK
elif [[ $(which snap) ]]; then
	for snap in $SNAP; do
		snap install $snap
	done
else
	echo "==== WARNING: NO SNAP/FLATPAK INSTALLED ===="
	fi
# }}}

# Vim plug {{{
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +PlugUpdate +qa!
# }}}

# Small bits {{{
sudo ln -s /bin/fdfind /bin/fd
xdg-mime default nvim.desktop text/*
# }}}
