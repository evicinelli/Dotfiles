" vim: fdm=marker

" Vim-plug
call plug#begin('~/.config/vim/plugged/')

	if !has("nvim")
		Plug 'tpope/vim-sensible'                                        " Sensible default if not nvim
	endif

	" Not used anymore {{{
	" Plug 'christoomey/vim-tmux-navigator'                              " Vim <3 tmux
	" Plug 'editorconfig/editorconfig-vim'                               " Support .editorconfig standard
	" Plug 'paroxayte/autocd.vim'                                        " Autocd in folder rule-based
	" }}}

	" General use {{{
	Plug 'junegunn/fzf',	{ 'dir': '~/.fzf', 'do': './install --all' } " Fzf <3
	Plug 'junegunn/goyo.vim'                                             " Distraction free writing
	Plug 'mbbill/undotree'                                               " Visualize undo tree
	Plug 'rickhowe/diffchar.vim'                                         " Better highlighting in diff mode
	Plug 'sakshamgupta05/vim-todo-highlight'                             " Highlight TODO
	Plug 'tpope/vim-commentary'                                          " Commenting done right
	Plug 'tpope/vim-surround'                                            " Surrounding motions on steroid
	Plug 'chrisbra/Colorizer',            {'on':'ColorToggle'}           " Highlight #COLORS
	Plug 'godlygeek/tabular'                                             " Tabularize
	" }}}

	" Filetype {{{
	Plug 'sheerun/vim-polyglot'                                          " A collection of language pack
	Plug 'chrisbra/csv.vim',              {'for':'csv'}                  " Csv file support
	Plug 'fretep/todo.txt-vim',           {'for':'todo'}                 " Todo.txt support
	Plug 'vim-pandoc/vim-pandoc-syntax',
	Plug 'habamax/vim-asciidoctor'
	" }}}

	" Pandoc and quarto integration {{{
	Plug 'vim-pandoc/vim-pandoc',
	Plug 'quarto-dev/quarto-vim'
	" }}}

	" Colors {{{
	Plug 'nightsense/cosmic_latte'
	Plug 'lunacookies/vim-colors-xcode'
	Plug 'rafi/awesome-vim-colorschemes'
	" }}}
	"
call plug#end()

" Asciidoctor
let g:asciidoctor_folding = 1
let g:asciidoctor_fold_options = 1

" Netrw options
let g:netrw_altv = 1            " split to the right
let g:netrw_banner = 1          " banner (with help)
let g:netrw_browse_split = 0    " open buffer in current window
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_liststyle = 0       " buffer view

" Pandoc options
let g:pandoc#biblio#bibs = ["$MED/bib.bib, $P/Libreria/zotero.bib"]
let g:pandoc#biblio#use_bibtool = 1
let g:pandoc#folding#mode = 'syntax'
let g:pandoc#folding#fastfolds = 1
let g:pandoc#folding#fdc = 0
let g:pandoc#folding#level = 1
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
let g:pandoc#toc#close_after_navigating = 1
let g:pandoc#toc#position = "left"
let g:pandoc#toc#shift = 1

" Fzf options
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-h': 'split',
	\ 'ctrl-v': 'vsplit' }

" Csv options
let g:csv_highlight_column = 'y'

" Markdown-preview options
" let g:mkdp_command_for_global = 1
" let g:mkdp_browser = 'x-www-browser'
" let g:mkdp_browser = '/Applications/Firefox.app/'
