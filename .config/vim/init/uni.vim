" Search in Med School notes folder I'm currently studying
command! -nargs=1 Nack vimgrep "<args>" $MED_CURRENT/**/*.md

" Open notes quickly please, no friction or I'll wont start studying
command! Mednotes call Mednotes()
function Mednotes()
	FZF $UNI/Med-Notes/
	cd %:p:h
endfunction

" Like Rstudio
function! ExecuteInR(string)
    let escaped_string = shellescape(a:string, 1)
    let r_command = 'Rscript -e "' . escaped_string . '"'
    :echo system(r_command)
endfunction

" vnoremap <Leader>R :<C-U>call ExecuteInR(@")<CR>

nnoremap <Leader>R :call ExecuteInR(getline('.'))<CR>
nnoremap <leader>N :Nack 
nnoremap <leader>n :Mednotes<CR>

" Control mpv with --ipc-socket, vital while transcribing lectures
nnoremap <leader>,, :!echo seek -1 \| socat - /tmp/mpvsocket && echo cycle pause \| socat - /tmp/mpvsocket<CR><CR>
nnoremap <leader>mm :!echo seek -1 \| socat - /tmp/mpvsocket && echo cycle pause \| socat - /tmp/mpvsocket<CR><CR>

nnoremap <leader>n5 :!echo seek +5 \| socat - /tmp/mpvsocket<CR><CR>
nnoremap <leader>nn :!echo seek +10 \| socat - /tmp/mpvsocket<CR><CR>

nnoremap <leader>p5 :!echo seek -5 \| socat - /tmp/mpvsocket<CR><CR>
nnoremap <leader>pp :!echo seek -10 \| socat - /tmp/mpvsocket<CR><CR>
