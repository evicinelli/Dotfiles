"Vim-plug
call plug#begin('~/.config/vim/plugged/')

if !has("nvim")
	Plug 'tpope/vim-sensible'                                        " Sensible default if not nvim
endif

if has('gui_vimr') || has ('gui_macvim')
	Plug 'lifepillar/vim-solarized8'
	Plug 'dracula/vim'
	Plug 'cormacrelf/dark-notify'
	Plug 'NLKNguyen/papercolor-theme'
endif

" Plug 'christoomey/vim-tmux-navigator'                                                                    " Vim <3 tmux
" Plug 'vim-pandoc/vim-rmarkdown'                                                                          " Pandoc + rmarkdown
Plug 'chrisbra/Colorizer',            {'on':'ColorToggle'}                                                " Highlight #COLORS
Plug 'chrisbra/csv.vim',              {'for':'csv'}                                                       " Csv file support
Plug 'editorconfig/editorconfig-vim'                                                                      " Support .editorconfig standard
Plug 'fretep/todo.txt-vim',           {'for':'todo'}                                                      " Todo.txt support
Plug 'godlygeek/tabular'                                                                                  " Tabularize
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['pandoc', 'vim-plug',]}
Plug 'junegunn/fzf',	{ 'dir': '~/.fzf', 'do': './install --all' }                                      " Fzf <3
Plug 'junegunn/goyo.vim'                                                                                  " Distraction free writing
Plug 'mbbill/undotree'                                                                                    " Visualize undo tree
Plug 'paroxayte/autocd.vim'                                                                               " Autocd in folder rule-based
Plug 'rickhowe/diffchar.vim'                                                                              " Better highlighting in diff mode
Plug 'sakshamgupta05/vim-todo-highlight'
Plug 'sheerun/vim-polyglot'                                                                               " A collection of language pack
Plug 'tpope/vim-commentary'                                                                               " Comment done right
Plug 'tpope/vim-surround'                                                                                 " Surrounding motions on steroid
Plug 'vim-pandoc/vim-pandoc', {'for':'pandoc'}                                                            " Pandoc integration
Plug 'vim-pandoc/vim-pandoc-syntax',                                                                      " Pandoc syntax
call plug#end()


" Netrw options
let g:netrw_altv = 1            " split to the right
let g:netrw_banner = 1          " banner (with help)
let g:netrw_browse_split = 0    " open buffer in current window
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_liststyle = 0       " buffer view

" Pandoc options
" let g:pandoc#biblio#bibs = ["/home/vic/pCloud\ Drive/Uni/Med-Notes/bib.bib", "/home/vic/pCloud\ Drive/Libreria/zotero.bib"]
let g:pandoc#biblio#bibs = ["/Users/vic/pCloud Drive/Libreria/zotero.bib"]
let g:pandoc#biblio#use_bibtool = 1
let g:pandoc#folding#fastfolds = 1
let g:pandoc#folding#fdc = 0
let g:pandoc#folding#level = 0
let g:pandoc#modules#disabled = [""]
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#conceal#blacklist = [
	\ "atx",
	\ "codeblock_delim",
	\ "codeblock_start",
	\ "comments",
	\ "html_c_s",
	\ "html_c_e",
	\ "dashes",
	\ "definition",
	\ "ellipses",
	\ "emdashes",
	\ "endashes",
	\ "footnote",
	\ "image",
	\ "inlinecode",
	\ "list",
	\ "quotes",
	\ "subscript",
	\ "superscript",
	\ "titleblock"]
let g:pandoc#toc#close_after_navigating = 0
let g:pandoc#toc#position = "left"
let g:pandoc#toc#shift = 4

" Fzf options
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-h': 'split',
	\ 'ctrl-v': 'vsplit' }

" Autocd options
let g:autocd#autocmd_enable = 1
let g:autocd#markers = { '**/Medicina/**/*.txt': ['Makefile'] }

" Csv options
let g:csv_highlight_column = 'y'

" Markdown-preview options
let g:mkdp_command_for_global = 1
" let g:mkdp_browser = 'x-www-browser'
let g:mkdp_browser = '/Applications/Firefox.app/'
