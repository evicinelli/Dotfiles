set autoindent                             " Auto-indent
set autoread                               " Auto reload file if modified from external command
set backupdir=~/.local/share/nvim/backup// " Backup file in /tmp//
set breakindent                            " Indent word wrapped line as much as parent line
set colorcolumn=+1                         " Highlight 81/th column
set cursorline                             " Highlight the line in which the cursor is
set directory^=~/.local/share/nvim/swap//  " Where to save swp file
set foldmethod=syntax                      " Fold according to syntax
set hidden                                 " Allow to switch buffer without saving it
set hlsearch                               " Highlight all search results
set writebackup                            " Write backup file before saving buffer to disk, delete after success
set incsearch                              " Incremental search
set ignorecase                             " Ignore case when search
set noexpandtab                            " Tab setting: on pressing Tab, insert \t
set laststatus=2                           " 1 ⇒ statusbar only if > 2 windows; 2 ⇒ always
set lazyredraw                             " Redraw screen only when really necessary
set linebreak                              " Break long lines at spaces, not in the middle of a word
set modeline                               " Vim executes vimL commands if they are found in the current file
set mouse=a                                " Enable mouse in all (=a) modes
set noautochdir                            " Do not change folder
set noshowmode                             " Not show when in insert mode
set number relativenumber                  " Line numbers are relative to current line
set omnifunc=syntaxcomplete#Complete       " Omni-completion
set path^=**                               " Recursive file search starting from current dir
set secure                                 " No shell command on autocmd
set shiftwidth=0                           " Tab setting: Indent following tabstop
set scrolloff=8                            " Lines to keep above and below while scrolling
set showcmd                                " Show partially typed commands
set smartcase                              " Smart-case search
set smartindent                            " Smart indent
set spell                                  " Spelling on
set spelllang=it,en                        " Spell dictionaries
set splitbelow                             " HSplit below
set splitright                             " Vsplit to the right
set swapfile                               " Always create swp file
set tabstop=4                              " How many space \t get
set undodir=~/.local/share/nvim/undo//     " Where to save persistent undo history
set undofile                               " Persistent history
set undolevels=5000                        " How many edit are saved in undofile
set updatetime=2000                        " Consider vim inactive after x sec of no activity in normal mode
set wildignorecase                         " Ignore case when autocomplete
set wildmenu                               " Tab autocompletion in menu
let mapleader = " "
let maplocalleader = " "

" Extended text Objects and matchpairs
" Thanks to Conner McDaniel: https://youtu.be/0F4FgiVWvB8
set matchpairs+=<:>
let s:items = [ ",", "." , "-" , "_" , "*" , ":" , "/" , "<bar>", "+", "\\", "^", "~"]
for item in s:items
	" exe "noremap yi".item." T".item."yt".item
	" exe "noremap ya".item." F".item."yf".item
	" exe "noremap ci".item." T".item."ct".item
	" exe "noremap ca".item." F".item."cf".item
	" exe "noremap di".item." T".item."dt".item
	" exe "noremap da".item." F".item."df".item
	" exe "vnoremap vi".item." T".item."vt".item
	" exe "vnoremap va".item." F".item."vf".item
	" Same thing
	exe "omap i".item ":<C-U>normal!vT".item."ot".item."<CR>"
	exe "omap a".item ":<C-U>normal!vF".item."of".item."<CR>"
endfor

