" Search in Med School notes folder I'm currently studying
command! -nargs=1 Nack vimgrep "<args>" $MED_CURRENT/**/*.md
nnoremap <leader>n :Nack 

" Open notes quickly please, no friction or I'll wont start studying
command! Mednotes call Mednotes()
function Mednotes()
	FZF $UNI/Med-Notes/
	"lcd %:p:h/../
endfunction
