﻿" Vim-plug {{{
call plug#begin()
Plug 'tpope/vim-sensible'                                            " Sensible default
Plug 'junegunn/fzf',	{ 'dir': '~/.fzf', 'do': './install --all' } " Fzf <3
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree',	{'on': 'NERDTreeToggle'}                 " Nerdtree
Plug 'junegunn/goyo.vim', 	{'on': 'Goyo'}                           " Goyo - distraction free writing
Plug 'airblade/vim-gitgutter'                                        " Git diff aside line numbers
Plug 'mhinz/vim-startify'                                            " Vim-startify
Plug 'tpope/vim-surround'                                            " Surrounding motions on steroid
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'                                          " A collection of language pack
Plug 'fretep/todo.txt-vim'                                           " Todo.txt support
Plug 'mileszs/ack.vim'                                               " Ack in vim
Plug 'godlygeek/tabular'                                             " Tabularize
Plug 'junegunn/limelight.vim'                                        " Focus only current paragraph
Plug 'vim-pandoc/vim-pandoc'                                         " Pandoc integration
Plug 'vim-pandoc/vim-pandoc-syntax'                                  " Pandoc integration
"Plug 'w0rp/ale', {'on':'ALEEnable'}                                  " Linting engine
Plug 'vim-airline/vim-airline'                                       " Statusline
Plug 'dylanaraps/wal.vim'                                            " Colorscheme
Plug 'lilydjwg/colorizer'                                            " Hilight color definition
call plug#end()
"}}}

" General Settings {{{
syntax enable             " Enable syntax Highlighting
filetype plugin on        " Filetype plugin
filetype plugin indent on " Specific indentation rules depending on file type
set number relativenumber " Line numbers are relative to current line
set path^=**              " Recursive file search starting from current dir
set directory="$HOME/.swp//" " Where to put swap files
set wildmenu              " Tab autocompletion in menu
set wildignorecase        " Ignore case when autocomplete
set ignorecase            " Mah
set autoread              " Autoreload file if modified from external command
set hlsearch              " Highlight all search results
set smartcase             " Smart-case search
set incsearch             " Incremental search
set autoindent            " Auto-indent
set smartindent           " Smart indent
set tabstop=4             " show existing tab with 4 spaces width
set shiftwidth=4          " when indenting with '>', use 4 spaces width
set expandtab             " On pressing tab, insert 4 spaces
set foldmethod=syntax     " Fold according to syntax
set linebreak             " Break long lines at spaces, not in the middle of a word
set hidden                " Allow to switch buffer without saving it
set colorcolumn=+1        " Highlight column where the 81/th char lives
"set shell=/bin/bash\ -i   " Which shell to use
set spelllang=it,en       " Spell dictionaries
set splitright            " vsplit on the right
set splitbelow            " split below
set mouse=a               " Enable mouse in terminal vim
set modeline              " Vim executes vimL commands if they are found in the current file
set updatetime=4000       " Consider vim inactive after 1 sec of no activity
let mapleader = " "
let maplocalleader = " "
"}}}

" Appearance and gui settings {{{
" set cursorline                                                " Highlight current line
set linespace=6                                               " Line spacing
set fillchars+=vert:∙                                         " Vertical separator char
set shortmess+=I                                              " No greetings
set list listchars=tab:·\ ,trail:·,eol:¬,extends:→,precedes:← " Non printable chars
set guifont=IBM\ Plex\ Mono\ 10
set bg=light
let &t_SI = "\<Esc>[6 q"                                      " Cursor shape (insert, normal, replace)
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" }}}

" Gvim vs terminal vim settings {{{
colorscheme wal
if has('gui_running')
    let g:fzf_launcher = 'urxvt -geometry 120x30 -e bash -c %s' " Launcher for fzf
    set guioptions-=m                                         " remove menu bar
    set guioptions-=T                                         " remove toolbar
    set guioptions-=r                                         " remove right-hand scroll bar
    set guioptions-=L                                         " remove left-hand scroll bar
    set guioptions-=b
    set guioptions-=e
    set bg=light
else
    let base16colorspace=256
 ""   set t_Co=256                                              " 256 color vim
endif
" }}}

" Plugin settings {{{
let NERDTreeChDirMode = 0
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_custom_header = [""]
let g:pandoc#filetypes#handled = ["pandoc", "markdown", "textile"]
let g:pandoc#biblio#use_bibtool = 1
let g:pandoc#syntax#conceal#use = 0
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-h': 'split',
    \ 'ctrl-v': 'vsplit' }
set completefunc=emoji#complete
" }}}

" Statusline {{{
""set statusline=%=\ %F\ %m%r%h%w\ \|\ %Y\ \|\ %l/%L:%v\ (%p%%)\ \|\ %{strftime('%a\ %e\ %b\ %H:%M')}\ 
let g:airline_symbols_ascii = 1
let g:airline_section_z=' %l/%L:%v (%p%%)'
set noshowmode
" }}}

" Custom mappings and abbreviations {{{
inoremap " ""<Left>
inoremap ( ()<Left>
inoremap <C-Backspace> <C-w>
inoremap <F1> <Esc>
inoremap [ []<Left>
inoremap ` ``<Left>
inoremap { {}<Left>
inoremap <C-p> <Esc>:FZF<CR>
noremap <C-B> :Buffers<CR>
noremap :Q :q
noremap :W :w
noremap <C-p> :FZF<CR>
noremap Y y$
noremap Z zMzv
noremap vaz [zV]z
noremap viz [zjV]zk
noremap <C-g> :Goyo<CR>
noremap <C-h> h
noremap <C-j> j
noremap <C-k> k
noremap <C-l> l
noremap <C-n> :NERDTreeToggle<CR>
noremap <F1> :tabnew <CR>
noremap <leader>p :tabprevious <CR>
noremap <leader>n :tabNext <CR>
noremap <F8> :se spell!<CR>
noremap <F9> :se nowrap!<CR>
noremap <leader>a :Ack 
noremap <leader>t :Tags<CR>
noremap <leader>so :!xdg-open "%" <CR>
noremap <leader><leader> zA <CR>
cabbrev f find
" }}}

" Extended text Objects and matchpairs (thanks to Conner McDaniel) {{{
" They slow down quite a bit commands like cc, dd, yy..
" let s:items = [ "." , "-" , "_" , "*" , ":" , "/" , "<bar>"] 
" 
" for item in s:items
"     exe "noremap yi".item." T".item."dt".item
"     exe "noremap ya".item." T".item."dt".item
"     exe "noremap ci".item." T".item."dt".item
"     exe "noremap ca".item." T".item."dt".item
"     exe "noremap di".item." T".item."dt".item
"     exe "noremap da".item." T".item."dt".item
"     exe "vnoremap vi".item." T".item."dt"item
"     exe "vnoremap va".item." T".item."dt"item
" endfor
set matchpairs+=<:>
" }}}

" Autogroups and Autocmds {{{
augroup text
     au BufNewFile,BufRead,BufWrite *.txt,*.md,*.mkd,*.markdown,*.mdwn setl ft=pandoc
     au bufnewfile,bufread,bufwrite todo.txt setl ft=todo | set nospell
     au bufnewfile,bufread,bufwrite done.txt setl ft=todo | set nospell
augroup end
augroup nonvim
    au!
    au BufRead *.png,*.jpg,*.pdf,*.gif,*.scpt,*.doc,*.odt,*.ppt,*.odp,*.xls,*.ods,*.{mp3,mp4,mov,mkv} sil exe "!xdg-open " . shellescape(expand("%:p")) . " &" | bd | let &ft=&ft | redraw!
    au BufReadPost *.{docx,xlsx,pptx} sil exe "!libreoffice " . shellescape(expand("%:p")) . " &" | bd | let &ft=&ft | redraw!
augroup end
augroup pyFiles
    au BufNewFile,BufRead,BufWrite *.py noremap <leader>p :!python "%" &<CR>
augroup end
augroup todotxt
    au BufNewFile,BufRead,BufWrite *.todo.txt setl ft=todo | set nospell
    au BufNewFile,BufRead,BufWrite *.done.txt setl ft=todo | set nospell
augroup end
autocmd CursorHold * silent! update " Autosave the buffer if on hold > updatetime ms (normal mode only)
" }}}

" Functions {{{
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction
" vim: fdm=marker

