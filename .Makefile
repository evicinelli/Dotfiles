# vim: fdm=indent foldignore= nowrap

SHELL=/bin/bash
PKGMGR=apt
INSTALL=$(PKGMGR) install -y

system       : update essentials nvim app flatpak
modules      : npm python

update:
	# Warning echo "WARNING! Launch make with sudo -E to preserve your home! Enter to continue"
	read _
	# Update the system
	$(PKGMGR) update
	$(PKGMGR) upgrade

essentials:
	# Install essential cmd utilities
	$(INSTALL) git gh tmux make at pass coreutils moreutils wget curl apt-transport-https fd-find pwgen sox socat libfuse2 wl-clipboard

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

repos:
	# External repos
	# curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	# echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
	wget -qO - https://typora.io/linux/public-key.asc | apt-key add -
	add-apt-repository 'deb https://typora.io/linux ./'
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
	apt update

app: repos
	$(INSTALL) mpv mpv-mpris imagemagick-6.q16hdri potrace ffmpeg ruby-notify playerctl translate-shell lm-sensors yt-dlp vim-gtk3 qutebrowser meld gnome-sushi okular-extra-backends glow typora chromium-browser

flatpak:
	# Install flatpak applications
	$(INSTALL) flatpak gnome-software-plugin-flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y com.bitwarden.desktop org.telegram.desktop org.localsend.localsend_app com.spotify.Client md.obsidian.Obsidian app.zen_browser.zen org.jitsi.jitsi-meet us.zoom.Zoom com.skype.Client org.jabref.jabref com.stremio.Stremio
	flatpak override --filesystem xdg-config/fontconfig:ro --system

python:
	$(INSTALL) python3 python3-pip python-is-python3 pipx
	pip3 install pandocfilters subliminal ComplexHTTPServer doi2bib pandoc-mermaid-filter

npm:
	$(INSTALL) npm
	apt install chromium-browser # marp-cli needs chromium to convert slide
	npm install -g @marp-team/marp-cli
	npm install -g @mermaid-js/mermaid-cli
	# mkdir -p ~/.local/bin/_ && cd ~/.local/bin/_/ && npm install @mermaid-js/mermaid-cli && ln -sf ~/.local/bin/_/node_modules/.bin/mmdc ~/.local/bin/mermaid

config:
	# Personal configurations here and there
	# cp $P/Res/Font/* /usr/share/fonts/ && fc-cache -v
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
	pkexec $(INSTALL) gnome-tweaks gnome-shell-extension-manager gnome-sushi

	# GNOME settings

	gsettings set org.freedesktop.Tracker.Miner.Files ignored-directories "['po', 'CVS', 'core-dumps', 'lost+found', '.git']"
	gsettings set org.freedesktop.Tracker.Miner.Files ignored-directories-with-content "['.trackerignore', '.hg', '.nomedia']"
	gsettings set org.freedesktop.Tracker.Miner.Files index-recursive-directories "['${HOME}/pCloudDrive/', '&DOWNLOAD']"
	gsettings set org.freedesktop.Tracker.Miner.Files index-single-directories "['${HOME}']"
	gsettings set org.freedesktop.Tracker.Miner.Files initial-sleep 300
	gsettings set org.gnome.desktop.background color-shading-type 'solid'
	gsettings set org.gnome.desktop.background primary-color '#d64761'
	gsettings set org.gnome.desktop.interface clock-format '24h'
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.interface clock-show-weekday true
	gsettings set org.gnome.desktop.interface document-font-name 'Serif 12'
	gsettings set org.gnome.desktop.interface enable-animations true
	gsettings set org.gnome.desktop.interface enable-hot-corners true
	gsettings set org.gnome.desktop.interface font-name 'Sans 11'
	gsettings set org.gnome.desktop.interface locate-pointer true
	gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 15'
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	gsettings set org.gnome.desktop.interface text-scaling-factor 1
	gsettings set org.gnome.desktop.media-handling automount true
	gsettings set org.gnome.desktop.media-handling automount-open true
	gsettings set org.gnome.desktop.notifications show-banners true
	gsettings set org.gnome.desktop.notifications show-in-lock-screen true
	gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
	gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
	gsettings set org.gnome.desktop.screensaver picture-uri 'file:///${HOME}/.img.jpeg'
	gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
	gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "['<Super><Alt>space']"
	gsettings set org.gnome.desktop.wm.keybindings close "['<Super>Q', '<Alt>q']"
	gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Alt>Escape']"
	gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "['<Super>Escape']"
	gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab', '<Super>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward  "['<Alt><Shift>Tab', '<Super><Shift>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Super>Above_Tab', '<Alt>Above_Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "['<Shift><Super>Above_Tab', '<Shift><Alt>Above_Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left ['<Super>Page_Up', '<Super><Alt>Left', '<Control><Alt>Left', '<Control><Super>Left']
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right ['<Super>Page_Down', '<Super><Alt>Right', '<Control><Alt>Right', '<Control><Super>Right']
	gsettings set org.gnome.desktop.wm.keybindings switch-windows "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "[]"
	gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f', '<Alt>f']"
	gsettings set org.gnome.desktop.wm.preferences button-layout 'close:'
	gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
	gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Sans Bold 11'
	gsettings set org.gnome.desktop.wm.preferences titlebar-uses-system-font true
	gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts "[]"
	gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'detailed_type', 'date_modified', 'permissions']"
	gsettings set org.gnome.nautilus.list-view default-zoom-level 'small'
	gsettings set org.gnome.nautilus.list-view use-tree-view true
	gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
	gsettings set org.gnome.nautilus.preferences show-create-link true
	gsettings set org.gnome.nautilus.preferences show-delete-permanently true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2500
	gsettings set org.gnome.settings-daemon.plugins.media-keys battery-status "['<Super><Shift>b']"
	gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 0
	gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super><Shift>l']"
	gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'suspend'
	gsettings set org.gnome.settings-daemon.plugins.power percentage-low 20
	gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1200
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'hibernate'
	gsettings set org.gnome.settings-daemon.plugins.power time-low 1800
	gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>5','<Shift><Super>s']"
	gsettings set org.gnome.shell.keybindings show-screen-recording-ui "['<Shift><Super>r','<Ctrl><Shift><Alt>R']"

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

pandoc: python npm
	# Install pandoc and latex + latex italian language settings
	$(INSTALL) pandoc wkhtmltopdf texlive-lang-italian poppler-utils pdfgrep texlive-latex-recommended texlive-xetex texlive-latex-extra librsvg2-bin texlive-fonts-extra dot2tex ttf-mscorefonts-installer #pandoc-citeproc
	mkdir -p .local/share/filters/
	curl https://raw.githubusercontent.com/kuba-orlik/pandoc-dot2tex-filter/master/dot2tex-filter.py >> .local/share/filters/dot2tex
	chmod +x .local/share/filters/dot2tex

asciidoctor:
	$(INSTALL) -y asciidoctor
	gem install asciidoctor-{mathematical,diagram,revealjs,epub3,pdf}

laptop:
	$(INSTALL) -y tlp powertop
	systemctl enable tlp.service
	powertop --auto-tune

quarto:
	wget "$(shell wget https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest -qO- | grep amd64.deb | grep browser_download_url | uniq | cut -d\" -f4)" -o quarto-latest.deb
	pkexec dpkg -i quarto-latest.deb --post-invoke="rm quarto-latest.deb"
