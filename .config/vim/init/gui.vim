if exists('g:GtkGuiLoaded')
	set termguicolors
	se bg=light
	colorscheme solarized8
endif

if has("gui_vimr")
	colorscheme solarized8_flat
	se bg=light
	lua require('dark_notify').run()
endif


if has("gui_macvim")
	colorscheme solarized8_flat
	set guifont=Inconsolata:h16
endif
