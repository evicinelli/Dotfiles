" Gvim
if has('gui_running')
	se guioptions-=T " Remove Toolbar, Menubar, Scrollbars
	se guioptions-=m " Remove menubar
	se guioptions-=r " Remove scrollbar
	se guioptions-=L " Remove scrollbar
	se guifont=Monospace\ Regular\ 13
endif

if has("gui_vimr")
	colorscheme PaperColor
	se bg=light
	lua require('dark_notify').run()
endif


if has("gui_macvim")
	colorscheme solarized8_flat
	set guifont=Inconsolata:h16
endif


if exists('g:GuiLoaded')
	set termguicolors
	se bg=light
	color PaperColor
	Guifont! Monospace:h12.5
endif
