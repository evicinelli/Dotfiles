" Default improved improved
" Fork of https://github.com/jeffkreeftmeijer/vim-dim (awesome)
"
" Purpose of this colorscheme is to use only cterm color, allowing you to have
" the same colorscheme across all terminal applications. To achieve this, 
" the color must be set in your terminal emulator settings
"
" Cterm color   Name
" ------------- -------
"      0 8      Black
"      1 9      Red
"      2 10     Green
"      3 11     Yellow
"      4 12     Blue
"      5 13     Purple
"      6 14     Cyan
"      7 15     White

highlight clear

if exists("syntax_on")
  syntax reset
endif
let colors_name = "dimim"

highlight Comment       ctermfg=7                           cterm=none
highlight Conceal       ctermfg=7           ctermbg=7
highlight Constant      ctermfg=1
highlight CursorLine                                        cterm=bold
highlight CursorLineNr  ctermfg=11          ctermbg=none
highlight DiffAdd       ctermfg=0           ctermbg=2
highlight DiffChange    ctermfg=0           ctermbg=3
highlight DiffDelete    ctermfg=0           ctermbg=1
highlight DiffText      ctermfg=0           ctermbg=11      cterm=bold
highlight Directory     ctermfg=4
highlight Error         ctermfg=15          ctermbg=9
highlight ErrorMsg      ctermfg=15          ctermbg=1
highlight Folded                                            cterm=bold
highlight Identifier    ctermfg=6                           cterm=none
highlight Ignore        ctermfg=15
highlight IncSearch                                         cterm=reverse
highlight MatchParen                        ctermbg=14
highlight ModeMsg                                           cterm=bold
highlight MoreMsg       ctermfg=2
highlight NonText       ctermfg=12
highlight PmenuSbar                         ctermbg=8
highlight PmenuThumb                        ctermbg=0
highlight PmenuSel                          ctermbg=6
highlight PreProc       ctermfg=5
highlight Question      ctermfg=2
highlight Search        ctermfg=0           ctermbg=11
highlight Special       ctermfg=5
highlight SpecialKey    ctermfg=4
highlight SpellBad      ctermfg=9           ctermbg=none    cterm=none
highlight SpellCap      ctermfg=none        ctermbg=none    cterm=italic
highlight SpellLocal                        ctermbg=14
highlight SpellRare     ctermfg=5
highlight Statement     ctermfg=3
highlight StatusLine                                        cterm=bold
highlight StatusLineNC                                      cterm=none
highlight TabLine                                           cterm=none
highlight TabLineSel    ctermfg=4                           cterm=bold
highlight TermCursor                                        cterm=reverse
highlight Title         ctermfg=5
highlight Todo          ctermfg=0           ctermbg=11
highlight Type          ctermfg=2
highlight Underlined    ctermfg=5                           cterm=underline
highlight VertSplit                                         cterm=none
highlight Visual        ctermfg=none        ctermbg=none    cterm =inverse
highlight WarningMsg    ctermfg=1
highlight WildMenu                          ctermbg=13

" Personal hi group
highlight TodoDueToday                      ctermbg=11     cterm=bold
highlight TodoPriorityA  ctermfg=9

" Highlight groups that depends on background
if &bg == "light"
  highlight ColorColumn  ctermfg=none ctermbg=15
  highlight CursorColumn              ctermbg=15   cterm=none
  " highlight CursorLine                ctermbg=15   cterm=none
  highlight FoldColumn   ctermfg=7    ctermbg=15
  highlight Folded       ctermfg=8    ctermbg=15
  highlight LineNr       ctermfg=7    ctermbg=15
  highlight Pmenu        ctermfg=0    ctermbg=15
  highlight PmenuSel     ctermfg=115
  highlight SignColumn   ctermfg=8    ctermbg=15
  highlight SpellCap     ctermfg=8    ctermbg=7
  highlight StatusLine   ctermfg=8    ctermbg=15
  highlight StatusLineNC ctermfg=7    ctermbg=15
  highlight TabLine      ctermfg=7    ctermbg=15
  highlight TabLineFill  ctermfg=15
  highlight VertSplit    ctermfg=8    ctermbg=NONE
  highlight WildMenu     ctermfg=15
  highlight TodoDueToday ctermfg=15
else
  highlight ColorColumn  ctermfg=none ctermbg=0
  highlight CursorColumn              ctermbg=0    cterm=none
  " highlight CursorLine                ctermbg=0    cterm=none
  highlight FoldColumn   ctermfg=8    ctermbg=0
  highlight Folded       ctermfg=8    ctermbg=0
  highlight LineNr       ctermfg=8    ctermbg=0
  highlight Pmenu        ctermfg=15   ctermbg=0
  highlight PmenuSel     ctermfg=0
  highlight SignColumn   ctermfg=8    ctermbg=0
  highlight SpellCap     ctermfg=7    ctermbg=8
  highlight StatusLine   ctermfg=7    ctermbg=0
  highlight StatusLineNC ctermfg=8    ctermbg=0
  highlight TabLine      ctermfg=8    ctermbg=0
  highlight TabLineFill  ctermfg=0
  highlight VertSplit    ctermfg=7    ctermbg=0
  highlight WildMenu     ctermfg=0
  highlight TodoDueToday ctermfg=0
endif

