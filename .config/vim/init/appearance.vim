" Appearance
set list listchars=tab:·\ ,trail:·,eol:¬,precedes:← ",extends:→
set fillchars=vert:\ ,fold:\ 
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50    " Different cursor shape in different mode

" Colorscheme
colorscheme dimim

" Statusline
set stl=
set stl+=%2*\ %{CurrentMode()}\ %0* " Custom mode indicator
set stl+=%m%r%h%w                   " Flags (modifiable, read only, help file, not saved)
set stl+=\ \ %t%<\                  " File name
set stl+=%=                         " Statusline separator
set stl+=\|\ %Y\ \|\                    " File type
set stl+=Ln\ %l/%L,\ Col\ %v        " Cursor line/Total lines, Cursor column
set stl+=\ (%p%%)\ \|\              " Percentage through file
set stl+=%{strftime('%H:%M')}\      " Current time
"set stl+=%3*%{TaskIndicator()}      " Todo indicator

function! CurrentMode()
	" Current mode
	let currentMode = mode()

	" Custom names
	let modes = {
		\ 'c'  : 'C',
		\ 'i'  : 'I',
		\ 'n'  : 'N',
		\ 'R'  : 'R',
		\ 't'  : 'T',
		\ 'v'  : 'V',
		\ 'V'  : 'VL',
		\ '' : 'VB',
		\ }

	" Mode color
	let imAGui = &termguicolors
	if (! imAGui)
		if (currentMode =~# 'n' )
			let color = "10"
			let guicolor = "LightGreen"
		elseif (currentMode =~# 'i')
			let color = "9"
			let guicolor = "LightRed"
		elseif (currentMode =~# 'v\|V\|\')
			let color = "12"
			let guicolor = "LightBlue"
		elseif (currentMode =~# 't')
			let color = "11"
			let guicolor = "LightYellow"
		elseif (currentMode =~# 's\|R')
			let color = "14"
			let guicolor = "LightCyan"
		elseif (currentMode =~# 'c')
			let color = "13"
			let guicolor = "LightMagenta"
		else
			let color="7"
			let guicolor = "White"
		endif

		exe "hi! User2 ctermfg=0 ctermbg=".color." cterm=bold guifg=black guibg=".guicolor
		redrawstatus
	endif
	return modes[currentMode]
endfunction

" Draw a small rectangle indicating if there are pending task in my
" todo manager
function! TaskIndicator()
	if ($TMUX == "")
		let color = 2     " Green if everything is done
		let urgentTask = system("todo urgent | wc -l")
		let todayTask = system("todo ls | wc -l")
		if (urgentTask > 0)
			let color = 1 " Red if urgent task is pending
		elseif (todayTask > 0)
			let color = 3 " Yellow if normal task is pending
		endif
		exe "hi! User3 ctermfg=0 ctermbg=".color
		redrawstatus!
		return "  "
	else
		redrawstatus!
		return ""
	endif
endfunction
