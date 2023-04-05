# vim: fdm=indent foldignore= nowrap

SHELL=/bin/bash
PKGMGR=apt
INSTALL=$(PKGMGR) install -y

all          : update apps config
apps         : base applications
base         : essentials dotfiles nvim
applications : utils pandoc gui-app flatpak
modules      : npm python

update:
	# Warning
	echo "WARNING! Launch make with sudo -E to preserve your home! Enter to continue"
	read _

	# Update the system
	$(PKGMGR) update
	$(PKGMGR) upgrade

essentials:
	# Install essential cmd utilities
	$(INSTALL) git tmux make at pass coreutils moreutils curl apt-transport-https fd-find pwgen sox socat libfuse2 wl-clipboard tracker powertop

dotfiles:
	cd
	git init
	git remote add origin https://github.com/evicinelli/Dotfiles
	git fetch
	git reset --hard origin/master

nvim:
	# Install nvim
	$(INSTALL) neovim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +PlugUpdate +qa!
	xdg-mime default nvim.desktop text/*
	mkdir -p ~/.local/share/nvim/backup
	mkdir -p ~/.local/share/nvim/swap
	mkdir -p ~/.local/share/nvim/undo

utils:
	# Install various utilities
	$(INSTALL) kitty mpv imagemagick-6.q16hdri potrace ffmpeg ruby-notify playerctl translate-shell lm-sensors

pandoc: python npm
	# Install pandoc and latex + latex italian language settings
	$(INSTALL) pandoc pandoc-citeproc wkhtmltopdf texlive-lang-italian poppler-utils pdfgrep texlive-latex-recommended texlive-xetex texlive-latex-extra librsvg2-bin texlive-fonts-extra dot2tex ttf-mscorefonts-installer
	mkdir -p .local/share/filters/
	curl https://raw.githubusercontent.com/kuba-orlik/pandoc-dot2tex-filter/master/dot2tex-filter.py >> .local/share/filters/dot2tex
	chmod +x .local/share/filters/dot2tex

gui-app:
	# Install gui apps
	$(INSTALL) dmenu youtube-dl qutebrowser meld gnome-sushi drawing gnome-shell-pomodoro

repos:
	# External repos
	# curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	# echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
	# # wget -qO - https://typora.io/linux/public-key.asc | apt-key add -
	# # add-apt-repository 'deb https://typora.io/linux ./'
	# apt update

flatpak:
	# Install flatpak applications
	$(INSTALL) flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y org.telegram.desktop com.spotify.Client com.microsoft.Teams net.ankiweb.anki us.zoom.Zoom com.skype.Client org.zotero.Zotero com.github.johnfactotum.Foliate com.stremio.Stremio com.github.fabiocolacio.marker
	flatpak override --filesystem xdg-config/fontconfig:ro --system
	flatpak override org.zotero.Zotero --filesystem=$(HOME)

python:
	$(INSTALL) python3 python3-pip python-is-python3
	pip3 install pandocfilters subliminal ComplexHTTPServer doi2bib pandoc-mermaid-filter

npm:
	$(INSTALL) npm
	apt install chromium-browser # marp-cli needs chromium to convert slide
	npm install -g @marp-team/marp-cli
	npm install -g @mermaid-js/mermaid-cli
	# mkdir -p ~/.local/bin/_ && cd ~/.local/bin/_/ && npm install @mermaid-js/mermaid-cli && ln -sf ~/.local/bin/_/node_modules/.bin/mmdc ~/.local/bin/mermaid

config:
	# Personal configurations here and there
	ln -sf /bin/fdfind /bin/fd
	update-alternatives --config x-terminal-emulator
	update-alternatives --config x-www-browser
	update-alternatives --config vi
	update-alternatives --config vim
	update-alternatives --config view
	update-alternatives --config vimdiff
	xdg-mime default nvim.desktop text/*
	xdg-mime default mpv.desktop video/*

gnome:
	# GNOME settings
	# gsettings set org.gnome.desktop.background picture-uri 'file:///${HOME}/.img.jpeg'
	# #469785' '#1BBE6F' '#b2052e' '#d64761' '#0d5676' '#82D0F4' '#502379' '#FDC220'
	gsettings set org.freedesktop.Tracker.Miner.Files index-recursive-directories "['${HOME}/pCloudDrive/']"
	gsettings set org.freedesktop.Tracker.Miner.Files index-single-directories "['${HOME}', '&DOWNLOAD']"
	gsettings set org.freedesktop.Tracker.Miner.Files initial-sleep 30
	gsettings set org.gnome.desktop.background color-shading-type 'solid'
	gsettings set org.gnome.desktop.background primary-color '#d64761'
	gsettings set org.gnome.desktop.interface clock-format '24h'
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.interface clock-show-weekday true
	gsettings set org.gnome.desktop.interface document-font-name 'Serif 12'
	gsettings set org.gnome.desktop.interface enable-animations false
	gsettings set org.gnome.desktop.interface enable-hot-corners true
	gsettings set org.gnome.desktop.interface font-name 'Sans 11'
	gsettings set org.gnome.desktop.interface locate-pointer true
	gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 13'
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	gsettings set org.gnome.desktop.interface text-scaling-factor 0.9
	gsettings set org.gnome.desktop.media-handling automount true
	gsettings set org.gnome.desktop.media-handling automount-open true
	gsettings set org.gnome.desktop.notifications show-banners true
	gsettings set org.gnome.desktop.notifications show-in-lock-screen true
	gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
	gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
	gsettings set org.gnome.desktop.screensaver picture-uri 'file:///${HOME}/.img.jpeg'
	gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
	gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "['<Primary><Alt>space']"
	gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
	gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Super>Escape','<Alt>Escape']"
	gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "['<Shift><Super>Escape','<Shift><Alt>Escape']"
	gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab', '<Super>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward  "['<Alt><Shift>Tab', '<Super><Shift>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Super>Above_Tab', '<Alt>Above_Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "['<Shift><Super>Above_Tab', '<Shift><Alt>Above_Tab']"
	gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"
	gsettings set org.gnome.desktop.wm.preferences button-layout ':close'
	gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
	gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Sans Bold 11'
	gsettings set org.gnome.desktop.wm.preferences titlebar-uses-system-font true
	gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'detailed_type', 'date_modified', 'permissions']"
	gsettings set org.gnome.nautilus.list-view default-zoom-level 'small'
	gsettings set org.gnome.nautilus.list-view use-tree-view true
	gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
	gsettings set org.gnome.nautilus.preferences show-create-link true
	gsettings set org.gnome.nautilus.preferences show-delete-permanently true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2000
	gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 0
	gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super><Shift>l']"
	gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'suspend'
	gsettings set org.gnome.settings-daemon.plugins.power percentage-low 20
	gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'hibernate'
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1200
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'hibernate'
	gsettings set org.gnome.settings-daemon.plugins.power time-low 1800

pcloud:
	# Download pcloud client
	echo "Download pcloud and save it to ~/.pcloud..."
	read _
	x-www-browser https://www.pcloud.com/it/how-to-install-pcloud-drive-linux.html?download=electron-64
	chmod +x $(HOME)/.pcloud
	./$(HOME)/.pcloud &
	echo "Login on pcloud, then press enter"
	read _

macos:
	# Homebrew and MacOs specific settings
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
	brew bundle --file="./.Brewfile"
	defaults write com.apple.finder QLEnableTextSelection -bool TRUE; killall Finder
