" Search in Med School notes folder I'm currently studying
command! -nargs=1 Nack vimgrep "<args>" $MED_CURRENT/**/*.md
nnoremap <leader>n :Nack 

" Open notes quickly please, no friction or I'll wont start studying
command! Mednotes call Mednotes()
function Mednotes()
	FZF $UNI/Med-Notes/
	cd %:p:h
endfunction

" Control mpv with --ipc-socket, vital while transcribing lectures
nnoremap <leader>mm :!echo seek -1 \| socat - /tmp/mpvsocket && echo cycle pause \| socat - /tmp/mpvsocket<CR><CR>
nnoremap <leader>,, :!echo seek -1 \| socat - /tmp/mpvsocket && echo cycle pause \| socat - /tmp/mpvsocket<CR><CR>

nnoremap <leader>n5 :!echo seek +5 \| socat - /tmp/mpvsocket<CR><CR>
nnoremap <leader>nn :!echo seek +10 \| socat - /tmp/mpvsocket<CR><CR>

nnoremap <leader>p5 :!echo seek -5 \| socat - /tmp/mpvsocket<CR><CR>
nnoremap <leader>pp :!echo seek -10 \| socat - /tmp/mpvsocket<CR><CR>
