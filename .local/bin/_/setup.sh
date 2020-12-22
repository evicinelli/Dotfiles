#! /bin/bash

add-repo () {
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

	# ## Typora
	# wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
	# sudo add-apt-repository 'deb https://typora.io/linux ./'

	sudo apt update
}

install-apt () {
	ESSENTIALS="git neovim tmux make at pass coreutils moreutils curl apt-transport-https fd-find"
	PANDOC="pandoc texlive-lang-italian pandoc-citeproc poppler-utils pdfgrep texlive-latex-recommended texlive-xetex texlive-luatex texlive-latex-extra librsvg2-bin texlive-fonts-extra"
	UTILS="kitty mpv meld imagemagick-6.q16hdri potrace ffmpeg ruby-notify playerctl gnome-sushi translate-shell"
	APPS="youtube-dl qutebrowser qbittorrent brave-browser obs-studio"
	sudo apt install -y $ESSENTIALS $PANDOC $UTILS $APPS
}
install-python () {
	sudo apt install python3 python3-pip
	PIP3="subliminal ComplexHTTPServer"
	sudo pip3 install $PIP3
}

install-flatpak () {
	sudo apt install flatpak
	FLATPAK="telegram spotify com.microsoft.Teams parlatype anki com.gigitux.gtkwhats us.zoom.Zoom com.anydesk.Anydesk com.skype.Client com.rafaelmardojai.Blanket"
	# SNAPS="spotify telegram teams"
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
}

install-setup-nvim() {
	sudo apt instlal neovim tmux
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +PlugUpdate +qa!
	xdg-mime default nvim.desktop text/*
}

bits-and-pieces () {
	sudo ln -s /bin/fdfind /bin/fd
}

add-repo
install-apt
install-python
install-flatpack
install-setup-nvim
bits-and-pieces
