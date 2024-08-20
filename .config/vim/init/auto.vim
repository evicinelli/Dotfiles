" Autogroups

" Personal autocmds
augroup personal
	autocmd!
	autocmd CursorHold * silent! update " Autosave the buffer if on hold > updatetime ms (normal mode only)
	autocmd! BufWritePost *vimrc* source %
augroup end

" Open everything -- even movies -- with vim
augroup nonvim
	" BufReadCmd is used because is triggered _before_ the file is red into
	" the buffer, so if the file size is very large it won't freeze vim until
	" the file is loaded -- which we'll not use anyway
	" Gvim doesn't play nice with this sadly AND FOR THE LIFE OF ME I CAN'T FIGURE OUT FUCKING WHY
	autocmd BufReadCmd *.{png,jpg,pdf,gif,scpt,doc,docx,odt,ppt,pptx,odp,xlsx,xls,ods,mp3,mp4,mov,mkv,avi} sil! exe "!xdg-open '%:p' \&" | bd
augroup end

" Goyo hooks
augroup Goyo
	autocmd! User GoyoEnter nested call Goyo_enter()
	autocmd! User GoyoLeave nested call Goyo_leave()
augroup end

" Every txt file is a quarto markdown file
autocmd BufNewFile,BufRead,BufWrite *.{txt,md} set ft=pandoc | set keywordprg=define

" Please, no spell in my todo list
augroup todotxt
	autocmd bufNewfile,bufRead,bufWrite *todo.txt setl ft=todo | set nospell | set nowrap
	autocmd bufNewfile,bufRead,bufWrite *done.txt setl ft=todo | set nospell | set nowrap
augroup end

" Man page in vim
autocmd FileType man setlocal laststatus=0 norelativenumber ft=man nospell

" View markdown file in external renderer
command Marked :silent !flatpak run org.gnome.gitlab.somas.Apostrophe "%"
"command Marked :silent !open -a Marked\ 2.app '%:p'

" Copy in clipboard qutebrowser buffers, `edit-text` not always works
autocmd ExitPre /tmp/qutebrowser-editor* !cat "%" | wl-copy

augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO:\|FIXME:\|REVIEW:\|NOTE:\|IDEA:\|WARNING:', -1)
augroup END
