function! GetSysMode()
	return trim(system('dconf read /org/gnome/desktop/interface/color-scheme'))
endfunction

" Gvim
if has('gui_running')
	se guioptions-=L " Remove scrollbar
	se guioptions-=T " Remove Toolbar, Menubar, Scrollbars
	se guioptions-=e " Remove gtk tabs
	se guioptions-=m " Remove menubar
	se guioptions-=r " Remove scrollbar
	se guioptions+=k " Properly resize gui window
	se guifont=Monospace\ 14
	se belloff=esc
	se laststatus=0
	colorscheme cosmic_latte
	let g:sysTheme = GetSysMode()
	if g:sysTheme ==? "'prefer-dark'"
		set bg=dark
	else
		set bg=light
	endif
endif

" Vimr
if has("gui_vimr")
	colorscheme PaperColor
	se bg=light
	lua require('dark_notify').run()
endif


" Macvim
if has("gui_macvim")
	colorscheme solarized8_flat
	set guifont=Inconsolata:h16
endif

" Change Font Size
" https://vi.stackexchange.com/questions/5804/how-to-zoom-to-text-in-vim-via-shortcut
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 30
function! AdjustFontSize(amount)
	let fontname = substitute(&guifont, s:pattern, '\1', '')
	let cursize = substitute(&guifont, s:pattern, '\2', '')
	let newsize = cursize + a:amount
	if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
		let newfont = fontname . newsize
		let &guifont = newfont
	endif
	redraw
endfunction

function! LargerFont()
	call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
	call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

nnoremap <C-+> :LargerFont<CR>
nnoremap  :SmallerFont<CR>
nnoremap <C-0> :se guifont=Monospace\ Regular\ 13<CR>
