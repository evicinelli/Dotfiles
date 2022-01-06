if exists('g:GtkGuiLoaded')
	set termguicolors
	se bg=light
	colorscheme solarized8
endif

if has("gui_vimr")
	set termguicolors
	se bg=light
	colorscheme solarized8
	lua require('dark_notify').run()
	let g:mkdp_browser = '/Applications/Firefox.app/'
endif
