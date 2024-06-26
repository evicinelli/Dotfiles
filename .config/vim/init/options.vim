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
set ignorecase                             " Ignore case when search
set incsearch                              " Incremental search
set isfname-=\=                            " How to recognize filenames after an = sign
set laststatus=2                           " 1 ⇒ statusbar only if > 2 windows; 2 ⇒ always; 0 ⇒ never
set lazyredraw                             " Redraw screen only when really necessary
set linebreak                              " Break long lines at spaces, not in the middle of a word
set modeline                               " Vim executes vimL commands if they are found in the current file
set mouse=a                                " Enable mouse in all (=a) modes
set noautochdir                            " Do not change folder
set noexpandtab                            " Tab settings: on pressing Tab, insert a literal \t
set noshowmode                             " Not show when in insert mode
set number relativenumber                  " Line numbers are relative to current line
set omnifunc=syntaxcomplete#Complete       " Omni-completion
set path^=**                               " Recursive file search starting from current dir
set scrolloff=8                            " Lines to keep above and below while scrolling
set secure                                 " No shell command on autocmd
set shiftwidth=0                           " Tab settings: Indent following tabstop
set shortmess=filnxtToOF
set showcmd                                " Show partially typed commands
set smartcase                              " Smart-case search
set smartindent                            " Smart indent
set spell                                  " Spelling on
set spelllang=it,en                        " Spell dictionaries
set splitbelow                             " HSplit below
set splitright                             " Vsplit to the right
set swapfile                               " _Always_ create swp file. Never too sure
set tabstop=4                              " Tab settings: How many space \t is represented as
set title                                  " Set the title of the window NVIM is run into to "filename (path) - NVIM"
set undodir=~/.local/share/nvim/undo//     " Where to save persistent undo history (undofiles)
set undofile                               " Persistent history
set undolevels=5000                        " How many edits are saved in undofile
set updatetime=2000                        " After how long to fire CursorHold hooks & how often write to disk swp file
set wildignorecase                         " Ignore case when autocomplete
set wildmenu                               " Tab autocompletion in menu
set writebackup                            " Write backup file before saving buffer to disk, delete after success
let mapleader = " "
let maplocalleader = " "
