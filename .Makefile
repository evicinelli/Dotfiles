all: applications modules config

applications: base utils pandoc app

modules: npm python

flatpak:
	sudo apt install flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install telegram spotify com.microsoft.Teams parlatype anki com.gigitux.gtkwhats us.zoom.Zoom com.anydesk.Anydesk com.skype.Client com.rafaelmardojai.Blanket

base: cmdline nvim

cmdline:
	sudo apt install -y git tmux make at pass coreutils moreutils curl apt-transport-https fd-find

nvim:
	sudo apt install -y neovim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +PlugUpdate +qa!

utils:
	sudo apt install -y kitty mpv meld imagemagick-6.q16hdri potrace ffmpeg ruby-notify playerctl gnome-sushi translate-shell

pandoc:
	sudo apt install -y pandoc texlive-lang-italian pandoc-citeproc poppler-utils pdfgrep texlive-latex-recommended texlive-xetex texlive-luatex texlive-latex-extra librsvg2-bin texlive-fonts-extra dot2tex graphviz

app: repos
	sudo apt install -y youtube-dl qutebrowser qbittorrent brave-browser obs-studio

repos:
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	# wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
	# sudo add-apt-repository 'deb https://typora.io/linux ./'
	sudo apt update

npm:

python:
	sudo apt install python3 python3-pip
	sudo pip3 install subliminal ComplexHTTPServer

config:
	sudo ln -s /bin/fdfind /bin/fd
	xdg-mime default nvim.desktop text/*
