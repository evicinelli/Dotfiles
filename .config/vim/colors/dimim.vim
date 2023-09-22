" Default improved improved
" Fork of the AWESOME https://github.com/jeffkreeftmeijer/vim-dim
" see: https://jeffkreeftmeijer.com/vim-16-color/
"
" This colorscheme, as vim-dim does, uses only 16 ANSI color: vim follows the
" colors defined by your terminal emulator, making it consistent with all the
" other terminal applications
"
" Cterm color   Name
" ------------- -------
"      0 8      Dark/bright Background
"      1 9      Red
"      2 10     Green
"      3 11     Yellow
"      4 12     Blue
"      5 13     Purple
"      6 14     Cyan
"      7 15     Dark/bright foreground
"
" Make sure to configure your terminal emulator properly, setting the
" appropriate color 0, 8, 7, 15 values to make light and dark colorscheme
" interchangeable (i.e: for light colorscheme, make sure color 0 and 8 are
" light and color 7 and 15 are dark; the opposite is true if you use a dark
" colorscheme). If you don't do that, dark colorscheme will work as intended,
" while with light colorscheme TUI elements will have dark background

highlight clear

if exists("syntax_on")
	syntax reset
endif
let colors_name = "dimim"

highlight Comment       ctermfg=14                          cterm=italic
highlight Conceal       ctermfg=7         ctermbg=7
highlight Constant      ctermfg=1
highlight CursorLine                                        cterm=bold
highlight CursorLineNr  ctermfg=11        ctermbg=none
highlight DiffAdd       ctermfg=0         ctermbg=2
highlight DiffChange    ctermfg=0         ctermbg=3
highlight DiffDelete    ctermfg=0         ctermbg=1
highlight DiffText      ctermfg=0         ctermbg=11        cterm=bold
highlight Directory     ctermfg=4
highlight Error         ctermfg=0         ctermbg=9
highlight ErrorMsg      ctermfg=0         ctermbg=1
highlight Folded                                            cterm=bold
highlight Identifier    ctermfg=6                           cterm=none
highlight Ignore        ctermfg=0
highlight IncSearch                                         cterm=reverse
highlight MatchParen                      ctermbg=14
highlight ModeMsg                                           cterm=bold
highlight MoreMsg       ctermfg=2
highlight NonText       ctermfg=12
highlight PmenuSbar                       ctermbg=8
highlight PmenuSel                        ctermbg=6
highlight PmenuThumb                      ctermbg=0
highlight PreProc       ctermfg=5
highlight Question      ctermfg=2
highlight Search        ctermfg=0         ctermbg=11
highlight Special       ctermfg=5
highlight SpecialKey    ctermfg=4
highlight SpellBad      ctermfg=9         ctermbg=none      cterm=none
highlight SpellCap                        ctermbg=0
highlight SpellLocal                      ctermbg=14
highlight SpellRare     ctermfg=5
highlight Statement     ctermfg=3
highlight StatusLine                                        cterm=bold
highlight StatusLineNC                                      cterm=none
highlight TabLine                                           cterm=none
highlight TabLineSel    ctermfg=4                           cterm=bold
highlight TermCursor                                        cterm=reverse
highlight Title         ctermfg=5
highlight Todo          ctermfg=0         ctermbg=11
highlight Type          ctermfg=2
highlight Underlined    ctermfg=5                           cterm=underline
highlight VertSplit                                         cterm=none
highlight Visual        ctermfg=none      ctermbg=none      cterm=reverse
highlight WarningMsg    ctermfg=1
highlight WildMenu                        ctermbg=13

" Personal hi group
highlight TodoOverDueDate ctermfg=0       ctermbg=9         cterm=bold
highlight TodoDueToday                    ctermbg=11        cterm=bold
highlight TodoPriorityA   ctermfg=9
highlight TodoDueToday    ctermfg=0

" TUI elements
highlight ColorColumn  ctermfg=none       ctermbg=0
highlight CursorColumn                    ctermbg=0         cterm=none
highlight FoldColumn   ctermfg=8          ctermbg=0
highlight Folded       ctermfg=8          ctermbg=0
highlight LineNr       ctermfg=7          ctermbg=0
highlight Pmenu        ctermfg=7          ctermbg=0
highlight PmenuSel     ctermfg=0
highlight SignColumn   ctermfg=8          ctermbg=0
highlight SpellCap     ctermfg=7          ctermbg=8
highlight StatusLine   ctermfg=7          ctermbg=0
highlight StatusLineNC ctermfg=8          ctermbg=0
highlight TabLine      ctermfg=8          ctermbg=0
highlight TabLineFill  ctermfg=0
highlight VertSplit    ctermfg=7          ctermbg=0
highlight WildMenu     ctermfg=8          ctermbg=0
