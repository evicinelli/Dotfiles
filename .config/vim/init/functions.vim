" vim: fdm=indent
" Goyo enter and leave
function! Goyo_enter()
	" vertical resize
	silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
	set scrolloff=999
endfunction

function! Goyo_leave()
	" silent! source ~/.config/nvim/init.vim
	set scrolloff=0
	set noshowmode
endfunction

" Diff from current buffer against saved file
function! s:DiffWithSaved()
	let filetype=&ft
	diffthis
	vnew | r # | normal! 1Gdd
	diffthis
	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()


" Now :ls <3 fzf
function! s:buflist()
	redir => ls
	silent ls
	redir END
	return split(ls, '\n')
endfunction

function! s:bufopen(e)
	execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

" Coconut oil
command! -nargs=? Files FZF --query=<args>\ 
command! -nargs=* Buffers call fzf#run(fzf#wrap({
	\   'source':  reverse(<sid>buflist()),
	\   'sink':    function('<sid>bufopen'),
	\   'options': '--no-exact +m --query="<f-args>"',
	\   'down':    len(<sid>buflist()) + 4
	\ }))


" fzf search :oldfiles
command! -bang MRU call fzf#run(fzf#wrap({
	\   "source": v:oldfiles,
	\}, <bang>0))
