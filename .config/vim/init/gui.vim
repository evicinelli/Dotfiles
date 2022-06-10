if exists('g:GtkGuiLoaded')
	set termguicolors
	se bg=light
	colorscheme solarized8
endif

if has("gui_vimr")
	colorscheme solarized8_flat
	set notermguicolors
	se bg=light
	lua require('dark_notify').run()
endif


if has("gui_macvim")
	colorscheme solarized8
	set guifont=SF\ Mono:h13
endif
