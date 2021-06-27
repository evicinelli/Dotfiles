# vim: fdm=indent foldignore=

SHELL=/bin/bash
INSTALL=apt install -y

all: apps pcloud config
apps: base applications

base: essentials nvim
applications: utils pandoc gui-app flatpak modules
modules: npm python

update:
	# Update the system
	pkexec apt update
	pkexec apt upgrade

essentials:
	# Install essential cmd utilities
	pkexec $(INSTALL) git tmux make at pass coreutils moreutils curl apt-transport-https fd-find pwgen

nvim:
	# Install nvim
	pkexec $(INSTALL) neovim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +PlugUpdate +qa!
	xdg-mime default nvim.desktop text/*
	mkdir -p ~/.local/share/nvim/backup
	mkdir -p ~/.local/share/nvim/swap
	mkdir -p ~/.local/share/nvim/undo

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
	pkexec $(INSTALL) youtube-dl qutebrowser qbittorrent brave-browser obs-studio meld gnome-sushi flameshot drawing gnome-shell-pomodoro pavucontrol gnome-tweak-tool

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
	pip3 install pandocfilters subliminal ComplexHTTPServer doi2bib pandoc-mermaid-filter

npm:
	pkexec apt install npm
	pkexec npm install -g @marp-team/marp-cli
	mkdir -p ~/.local/bin/_ && cd ~/.local/bin/_/ && npm install @mermaid-js/mermaid-cli && ln -s ~/.local/bin/_/node_modules/.bin/mmdc ~/.local/bin/mermaid

config:
	# Personal configurations here and there
	pkexec ln -sf /bin/fdfind /bin/fd
	pkexec flatpak override org.zotero.Zotero --filesystem=$(HOME)
	[[ -d $(DOC)/Password-store ]] && ln -sf $(DOC)/Password-store $(HOME)/.password-store
	[[ -d $(P)/Desktop ]] && rm -r $(HOME)/Scrivania && ln -sf $(P)/Desktop $(HOME)/Scrivania
	[[ -d $(P)/Libreria/Zotero ]] && ln -sf $(P)/Libreria/Zotero $(HOME)/
	pkexec update-alternatives --config x-terminal-emulator
	pkexec update-alternatives --config x-www-browser
	pkexec update-alternatives --config vi
	pkexec update-alternatives --config vim
	pkexec update-alternatives --config view
	pkexec update-alternatives --config vimdiff
	xdg-mime default nvim.desktop text/plain
	xdg-mime default nvim.desktop text/markdown

gnome:
	[[ $(XDG_CURRENT_DESKTOP) =~ .*GNOME.* || $(XDG_CURRENT_DESKTOP) =~ .*gnome.* ]] && (\
	gsettings set org.gnome.desktop.interface clock-show-date true;\
	gsettings set org.gnome.desktop.interface clock-show-weekday true;\
	gsettings set org.gnome.desktop.interface document-font-name 'Sans 11';\
	gsettings set org.gnome.desktop.interface font-name 'Sans 11';\
	gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 13';\
	gsettings set org.gnome.desktop.interface show-battery-percentage true;\
	gsettings set org.gnome.desktop.interface text-scaling-factor 0.89999999999999991)
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true;\
	gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true;\
	gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true;\
	gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']";\
	gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab', '<Super>Tab']";\
	gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward  "['<Alt><Shift>Tab', '<Super><Shift>Tab']";\
	gsettings set org.gnome.desktop.wm.keybindings switch-windows "[]";\
	gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "[]";\
	gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']";\
	gsettings set org.gnome.desktop.wm.preferences button-layout ':close';\
	gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 0;\

pcloud:
	# Download pcloud client
	echo "Download pcloud and save it to ~/.pcloud..."
	read _
	x-www-browser https://www.pcloud.com/it/how-to-install-pcloud-drive-linux.html?download=electron-64
	chmod +x $(HOME)/.pcloud
	./$(HOME)/.pcloud &
	echo "Login on pcloud, then press enter"
	read _
