" Autogroups

augroup personal
	autocmd!
	autocmd CursorHold * silent! update " Autosave the buffer if on hold > updatetime ms (normal mode only)
	autocmd! BufWritePost *vimrc* source %
augroup end

augroup nonvim
	" BufReadCmd is used because is triggered _before_ the file is red into
	" the buffer, so if the file size is very large it won't freeze vim until
	" the file is loaded into the buffer -- which we'll not use anyway
	autocmd BufReadCmd *.{png,jpg,pdf,gif,scpt,doc,docx,odt,ppt,pptx,odp,xlsx,xls,ods,mp3,mp4,mov,mkv,avi} sil! exe "!xdg-open " . shellescape(expand("%:p")) . " &" | bd | let &ft=&ft | redraw!
augroup end

augroup Goyo
	autocmd! User GoyoEnter nested call Goyo_enter()
	autocmd! User GoyoLeave nested call Goyo_leave()
augroup end

augroup pandoc
	autocmd BufNewFile,BufRead,BufWrite *.txt,*.md set ft=pandoc
augroup end

augroup todotxt
	autocmd bufNewfile,bufRead,bufWrite *todo.txt setl ft=todo | set nospell | se nowrap
	autocmd bufNewfile,bufRead,bufWrite *done.txt setl ft=todo | set nospell | se nowrap
augroup end

autocmd FileType man setlocal laststatus=0 norelativenumber ft=man nospell
