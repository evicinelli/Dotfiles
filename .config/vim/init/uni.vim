" Search in Med School notes folder I'm currently studying
command! -nargs=1 Nack vimgrep "<args>" $MED_CURRENT/**/*.md
nnoremap <leader>n :Nack 
