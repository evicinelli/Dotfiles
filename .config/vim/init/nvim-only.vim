" Nvim-only settings

set inccommand=nosplit

tnoremap <C-\> <C-\><C-n>

autocmd! FileType fzf
autocmd  FileType fzf setlocal laststatus=0 noruler norelativenumber
	\| autocmd BufLeave <buffer> set laststatus=2 ruler relativenumber

