# vim: fdm=indent foldignore=

SHELL=/bin/bash
INSTALL = "sudo apt install -y"

all: apps config
apps: update base applications

base: essentials nvim
applications: utils pandoc gui-app flatpak modules
modules: npm python

update:
	# Update the system
	pkexec apt update
	pkexec apt upgrade

essentials:
	# Install essential cmd utilities
	pkexec $(INSTALL) git tmux make at pass coreutils moreutils curl apt-transport-https fd-find

nvim:
	# Install nvim
	pkexec $(INSTALL) neovim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +PlugUpdate +qa!
	xdg-mime default nvim.desktop text/*
	mkdir ~/.local/share/nvim/backup
	mkdir ~/.local/share/nvim/swap
	mkdir ~/.local/share/nvim/undo

utils:
	# Install various utilities
	pkexec $(INSTALL) kitty mpv imagemagick-6.q16hdri potrace ffmpeg ruby-notify playerctl translate-shell

pandoc: python
	# Install pandoc and latex + latex italian language settings
	pkexec $(INSTALL) pandoc texlive-lang-italian pandoc-citeproc poppler-utils pdfgrep texlive-latex-recommended texlive-xetex texlive-luatex texlive-latex-extra librsvg2-bin texlive-fonts-extra dot2tex graphviz
	mkdir -p .local/share/filters/
	curl https://raw.githubusercontent.com/kuba-orlik/pandoc-dot2tex-filter/master/dot2tex-filter.py >> .local/share/filters/dot2tex
	chmod +x .local/share/filters/dot2tex

gui-app: repos
	# Install gui apps i use
	pkexec $(INSTALL) youtube-dl qutebrowser qbittorrent brave-browser obs-studio meld gnome-sushi flameshot drawing gnome-shell-pomodoro

repos:
	# Add external repos
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | pkexec apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | pkexec tee /etc/apt/sources.list.d/brave-browser-release.list
	# wget -qO - https://typora.io/linux/public-key.asc | apt-key add -
	# add-apt-repository 'deb https://typora.io/linux ./'
	pkexec apt update

flatpak:
	# Install flatpak applications
	pkexec $(INSTALL) flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install telegram spotify com.microsoft.Teams parlatype anki us.zoom.Zoom com.anydesk.Anydesk com.skype.Client com.rafaelmardojai.Blanket org.zotero.Zotero

python:
	pkexec $(INSTALL) python3 python3-pip python-is-python3
	pip3 install pandocfilters subliminal ComplexHTTPServer

npm:
	pkexec npm install -g @marp-team/marp-cli
	mkdir -p ~/.local/bin/_ && cd ~/.local/bin/_/ && npm install @mermaid-js/mermaid-cli && ln -s ~/.local/bin/_/node_modules/.bin/mmdc ~/.local/bin/mermaid

config: pcloud
	# Personal configurations here and there
	pkexec ln -sf /bin/fdfind /bin/fd
	pkexec update-alternatives --config x-terminal-emulator
	pkexec flatpak override org.zotero.Zotero --filesystem=$(HOME)
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
