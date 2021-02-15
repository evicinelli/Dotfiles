# vim: fdm=indent foldignore=

SHELL=/bin/bash

all: install config
install: update base applications

base: essentials nvim
applications: utils pandoc app flatpak modules
modules: npm python

update:
	# Update the system
	sudo apt update
	sudo apt upgrade

essentials:
	# Install essential cmd utilities
	sudo apt install -y git tmux make at pass coreutils moreutils curl apt-transport-https fd-find

nvim:
	# Install nvim
	sudo apt install -y neovim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +PlugUpdate +qa!
	xdg-mime default nvim.desktop text/*
	mkdir ~/.local/share/nvim/backup
	mkdir ~/.local/share/nvim/swap
	mkdir ~/.local/share/nvim/undo

utils:
	# Install various utilities
	sudo apt install -y kitty mpv imagemagick-6.q16hdri potrace ffmpeg ruby-notify playerctl translate-shell

pandoc: python
	# Install pandoc and latex + latex italian language settings
	sudo apt install -y pandoc texlive-lang-italian pandoc-citeproc poppler-utils pdfgrep texlive-latex-recommended texlive-xetex texlive-luatex texlive-latex-extra librsvg2-bin texlive-fonts-extra dot2tex graphviz
	mkdir -p .local/share/filters/
	curl https://raw.githubusercontent.com/kuba-orlik/pandoc-dot2tex-filter/master/dot2tex-filter.py >> .local/share/filters/dot2tex
	chmod +x .local/share/filters/dot2tex

app: repos
	# Install gui apps i use
	sudo apt install -y youtube-dl qutebrowser qbittorrent brave-browser obs-studio meld gnome-sushi flameshot drawing gnome-shell-pomodoro

repos:
	# Add external repos
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	# wget -qO - https://typora.io/linux/public-key.asc | apt-key add -
	# add-apt-repository 'deb https://typora.io/linux ./'
	sudo apt update

flatpak:
	# Install flatpak applications
	sudo apt install -y flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install telegram spotify com.microsoft.Teams parlatype anki com.gigitux.gtkwhats us.zoom.Zoom com.anydesk.Anydesk com.skype.Client com.rafaelmardojai.Blanket org.zotero.Zotero

python:
	sudo apt install -y python3 python3-pip python-is-python3
	pip3 install pandocfilters subliminal ComplexHTTPServer

npm:
	# Install npm modules
	# No one for now <3

config: pcloud
	# Personal configurations here and there
	sudo ln -sf /bin/fdfind /bin/fd
	sudo update-alternatives --config x-terminal-emulator
	sudo flatpak override org.zotero.Zotero --filesystem=$(HOME)
	[[ -d $(DOC)/Password-store ]] && ln -sf $(DOC)/Password-store $(HOME)/.password-store
	[[ -d $(P)/Desktop ]] && rm -r $(HOME)/Scrivania && ln -sf $(P)/Desktop $(HOME)/Scrivania
	[[ -d $(P)/Libreria/Zotero ]] && ln -s $(P)/Libreria/Zotero $(HOME)/

pcloud:
	# Open pcloud download page
	echo "Download pcloud and save it to ~/.pcloud..."
	read _
	x-www-browser https://www.pcloud.com/it/how-to-install-pcloud-drive-linux.html?download=electron-64
	chmod +x $(HOME)/.pcloud
	./$(HOME)/.pcloud &
	echo "Login on pcloud, then press enter"
	read _
