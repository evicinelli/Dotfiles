" Autogroups
autocmd CursorHold * silent! update " Autosave the buffer if on hold > updatetime ms (normal mode only)

autocmd! BufWritePost *vimrc* source %

if has('nvim') && !exists('g:fzf_layout')
	autocmd! FileType fzf
	autocmd  FileType fzf setlocal laststatus=0 noruler norelativenumber
		\| autocmd BufLeave <buffer> set laststatus=2 ruler relativenumber
endif

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

augroup pandoc
	autocmd BufNewFile,BufRead,BufWrite *.txt,*.md set ft=pandoc
augroup end

augroup todotxt
	autocmd bufNewfile,bufRead,bufWrite *todo.txt setl ft=todo | set nospell | se nowrap
	autocmd bufNewfile,bufRead,bufWrite *done.txt setl ft=todo | set nospell | se nowrap
augroup end

augroup nonvim
	" BufReadCmd is used because is triggered _before_ the file is red into
	" the buffer, so if the file size is very large it won't freeze vim until
	" the file is loaded into the buffer -- which we'll not use anyway
	autocmd BufReadCmd *.{png,jpg,pdf,gif,scpt,doc,docx,odt,ppt,pptx,odp,xlsx,xls,ods,mp3,mp4,mov,mkv} sil! exe "!xdg-open " . shellescape(expand("%:p")) . " &" | bd | let &ft=&ft | redraw!
augroup end


augroup man
	autocmd BufNewFile,BufRead,BufReadCmd man://* set laststatus=0
augroup end
