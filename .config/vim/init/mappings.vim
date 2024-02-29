" Mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

inoremap  =system("date")<CR><Esc>kJ
inoremap  =system("date -I")<CR><Esc>kJ$
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
noremap <F10> :execute 'set laststatus='.(&laststatus + 1)%3<CR>
noremap <leader>dw :!define <cword><CR>
noremap <leader>so :!mimeopen "%" <CR>
noremap <leader>m :MarkdownPreviewToggle<CR>
noremap Y y$
noremap Z zMzv
noremap z _\|\|

vnoremap K gk
vnoremap az [zo]z
vnoremap iz [zjo]zk

" Extended text Objects and matchpairs
" Thanks to Conner McDaniel: https://youtu.be/0F4FgiVWvB8
set matchpairs+=<:>
let s:items = [ ",", "." , "-" , "_" , "*" , ":" , "/" , "<bar>", "+", "\\", "^", "~", "`", "$", "%"]
for item in s:items
	" Operator-pending mode
	exe "omap i".item ":<C-U>normal!vT".item."ot".item."<CR>"
	exe "omap a".item ":<C-U>normal!vF".item."of".item."<CR>"
	" Visual mode only
	exe "xmap i".item ":<C-U>normal!vT".item."ot".item."<CR>"
	exe "xmap a".item ":<C-U>normal!vF".item."of".item."<CR>"
endfor
