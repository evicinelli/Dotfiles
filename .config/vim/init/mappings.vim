" Mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap Q q
cnoremap W w
cnoremap X x

inoremap  =system("date")<CR><Esc>kJ$x
inoremap  =system("date -I")<CR><Esc>kJ$x
inoremap <C-z> <C-o><C-z>
inoremap <F1> <Esc>

noremap '' :b#<CR>
noremap '. :FZF<CR>
noremap 'b :Buffers<CR>
noremap 'f :FZF --no-exact 
noremap 'h :FZF %:h <CR>
noremap 't :FZF<CR>
noremap 'u :FZF $UNI<CR>
noremap <BS> -
noremap <C-l> :noh<CR>
noremap <C-n> :cn<CR>
noremap <C-p> :cp<CR>
noremap <F1> <Esc>
noremap <F8> :se spell!<CR>
noremap <F9> :se nowrap!<CR>
noremap <leader>so :!mimeopen "%" <CR>
noremap <leader>m :MarkdownPreviewToggle<CR>
noremap Y y$
noremap Z zMzv
" noremap j gj
" noremap k gk

vnoremap J gj
vnoremap K gk
vnoremap az [zo]z
vnoremap iz [zjo]zk
