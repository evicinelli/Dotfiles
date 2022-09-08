" Appearance
set list listchars=tab:·\ ,trail:·,eol:¬,precedes:← ",extends:→
set fillchars=vert:\ ,fold:\ 
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50    " Different cursor shape in different mode

" Colorscheme
colorscheme dimim

" Statusline
set stl=
" set stl=%2*
set stl+=%0*						" Default background
set stl+=%m%r%h%w					" Flags (modifiable, read only, help file, not saved)
set stl+=\ \ %t%<\ 					" File name
set stl+=%=							" Statusline separator
set stl+=\|\ %Y\ \|\ 				" File type
set stl+=Ln\ %l/%L,\ Col\ %v		" Cursor line/Total lines, Cursor column
set stl+=\ (%p%%)\ \|\ 				" Percentage through file
set stl+=%{strftime('%H:%M')}\ 		" Current time
set stl+=\|\ %{CurrentMode()}\ 		" Custom mode indicator
"set stl+=%3*%{TaskIndicator()}	 " Todo indicator

function! CurrentMode()
	let modes = {
		\ '!'    : ' #️⃣ ',
		\ ''   : ' 🧱',
		\ ''   : 'V-BLK',
		\ 's'  : ' 🐳',
		\ 'R'    : ' ⚡️',
		\ 'Rc'   : ' ⚡️',
		\ 'Rv'   : ' ⚡️',
		\ 'Rvc'  : ' ⚡️',
		\ 'Rvx'  : ' ⚡️',
		\ 'Rx'   : ' ⚡️',
		\ 'S'    : ' 🐠',
		\ 'V'    : 'VLN',
		\ 'Vs'   : ' 🐡',
		\ 'c'    : 'CMD',
		\ 'cv'   : ' ↩️' ,
		\ 'i'    : 'INS',
		\ 'ic'   : ' 🔥',
		\ 'ix'   : ' 🔥',
		\ 'n'    : 'NRM',
		\ 'niI'  : ' 🧡',
		\ 'niR'  : ' 💚',
		\ 'niV'  : ' 💙',
		\ 'no'   : ' 💜',
		\ 'no' : ' 🖤',
		\ 'noV'  : ' 🤍',
		\ 'nov'  : ' 🤎',
		\ 'nt'   : ' 💛',
		\ 'r'    : 'REP',
		\ 'r?'   : ' 👉',
		\ 'rm'   : ' 👉',
		\ 's'    : 'SUB',
		\ 't'    : 'TRM',
		\ 'v'    : 'VIS',
		\ 'vs'   : ' 🦐',
		\}

	" let colors = {
	" 	\ 'c'  : 'magenta',
	" 	\ 'i'  : 'red',
	" 	\ 'n'  : 'green',
	" 	\ 'R'  : 'darkcyan',
	" 	\ 't'  : 'yellow',
	" 	\ 'v'  : 'lightgray',
	" 	\ 'V'  : 'blue',
	" 	\ '' : 'darkblue',
	" 	\ }

	" exe "hi! User2 ctermfg=".colors[mode()]." cterm=bold guifg=".colors[mode()]
	" redrawstatus!
	return modes[mode()]
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
