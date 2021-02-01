" Nvim-only settings

set inccommand=nosplit

tnoremap <C-\> <C-\><C-n>

augroup fzf
	autocmd! FileType fzf
	autocmd  FileType fzf setlocal laststatus=0 noruler norelativenumber
		\| autocmd BufLeave <buffer> set laststatus=2 ruler relativenumber
augroup end
