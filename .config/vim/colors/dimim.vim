" Default improved improved
" Fork of https://github.com/jeffkreeftmeijer/vim-dim (awesome)
"
" Color 0 8 Black
" Color 1 9 Red
" Color 2 10 Green
" Color 3 11 Yellow
" Color 4 12 Blue
" Color 5 13 Purple
" Color 6 14 Cyan
" Color 7 15 White

highlight clear

if exists("syntax_on")
  syntax reset
endif
let colors_name = "dimim"

highlight Comment      cterm=italic
highlight Conceal      ctermfg=7           ctermbg=7
highlight Constant     ctermfg=1
highlight CursorColumn ctermbg=7
highlight CursorLine   cterm=bold gui=bold
highlight CursorLineNr ctermfg=10          ctermbg=NONE
highlight DiffAdd      ctermfg=0           ctermbg=2
highlight DiffChange   ctermfg=0           ctermbg=3
highlight DiffDelete   ctermfg=0           ctermbg=1
highlight DiffText     ctermfg=0           ctermbg=11   cterm=bold
highlight Directory    ctermfg=4
highlight Error        ctermfg=15          ctermbg=9
highlight ErrorMsg     ctermfg=15          ctermbg=1
highlight Folded       cterm=bold
highlight Identifier   ctermfg=6           cterm=NONE
highlight Ignore       ctermfg=15
highlight IncSearch    cterm=reverse
highlight MatchParen   ctermbg=14
highlight ModeMsg      cterm=bold
highlight MoreMsg      ctermfg=2
highlight NonText      ctermfg=12
highlight PmenuSbar    ctermbg=8
highlight PmenuThumb   ctermbg=0
highlight PreProc      ctermfg=5
highlight Question     ctermfg=2
highlight Search       ctermfg=0           ctermbg=11
highlight Special      ctermfg=5
highlight SpecialKey   ctermfg=4
highlight SpellBad     ctermbg=NONE        ctermfg=9    cterm=underline
highlight SpellCap     ctermbg=NONE        ctermfg=NONE cterm=italic
highlight SpellLocal   ctermbg=14
highlight SpellRare    ctermfg=5
highlight Statement    ctermfg=3
highlight StatusLine   cterm=bold
highlight StatusLineNC cterm=NONE
highlight TabLineSel   cterm=bold
highlight TermCursor   cterm=reverse
highlight Title        ctermfg=5
highlight Todo         ctermfg=0           ctermbg=11
highlight Type         ctermfg=2
highlight Underlined   cterm=underline     ctermfg=5
highlight VertSplit    cterm=NONE
highlight Visual       ctermfg=NONE        ctermbg=NONE cterm =inverse
highlight WarningMsg   ctermfg=1
highlight WildMenu     ctermbg=13

" Dim line numbers, comments, statusline...
if &bg == "light"
  highlight ColorColumn  ctermfg=8   ctermbg=15
  highlight Comment      ctermfg=7 cterm=NONE
  highlight FoldColumn   ctermfg=7   ctermbg=15
  highlight Folded       ctermfg=8    ctermbg=15
  highlight LineNr       ctermfg=7    ctermbg=15
  highlight Pmenu        ctermfg=0    ctermbg=15
  highlight PmenuSel     ctermfg=7    ctermbg=0
  highlight SignColumn   ctermfg=8    ctermbg=15
  highlight SpellCap     ctermfg=8    ctermbg=7
  highlight StatusLine   ctermfg=8    ctermbg=15
  highlight StatusLineNC ctermfg=8    ctermbg=7
  highlight TabLine      ctermfg=7    ctermbg=15
  highlight TabLineFill ctermfg=15
  highlight VertSplit    ctermfg=8    ctermbg=7
  highlight WildMenu     ctermfg=15
else
  highlight ColorColumn  ctermfg=0    ctermbg=0
  highlight Comment      ctermfg=7
  highlight FoldColumn   ctermfg=8    ctermbg=0
  highlight Folded       ctermfg=7    ctermbg=0
  highlight LineNr       ctermfg=7    ctermbg=0
  highlight Pmenu        ctermfg=15   ctermbg=0
  highlight PmenuSel     ctermfg=8    ctermbg=15
  highlight SignColumn   ctermfg=7    ctermbg=0
  highlight SpellCap     ctermfg=7    ctermbg=8
  highlight StatusLine   ctermfg=15   ctermbg=0
  highlight StatusLineNC ctermfg=7    ctermbg=8
  highlight TabLine      ctermfg=8    ctermbg=0
  highlight TabLineFill ctermfg=0
  highlight VertSplit    ctermfg=7    ctermbg=8
  highlight WildMenu     ctermfg=0
endif

" Personal hi groups
highlight TodoDueToday ctermbg=yellow ctermfg=black cterm=bold
