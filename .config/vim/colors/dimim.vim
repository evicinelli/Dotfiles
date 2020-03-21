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

highlight Conceal      ctermfg=7       ctermbg=7
highlight Constant     ctermfg=1
highlight CursorColumn ctermbg=7
highlight DiffAdd      ctermfg=0       ctermbg=2
highlight DiffChange   ctermfg=0       ctermbg=3
highlight DiffDelete   ctermfg=0       ctermbg=1
highlight DiffText     ctermfg=0       ctermbg=11   cterm=bold
highlight Directory    ctermfg=4
highlight Error        ctermfg=15      ctermbg=9
highlight ErrorMsg     ctermfg=15      ctermbg=1
highlight Identifier   ctermfg=6       cterm=NONE
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
highlight Search       ctermfg=0       ctermbg=11
highlight Special      ctermfg=5
highlight SpecialKey   ctermfg=4
highlight SpellBad     ctermbg=NONE    ctermfg=9    cterm=underline
highlight SpellLocal   ctermbg=14
highlight SpellRare    ctermfg=5
highlight SpellCap     ctermfg=0       ctermbg=14
highlight Statement    ctermfg=3
highlight TabLine      cterm=underline ctermfg=0    ctermbg=7
highlight TabLineFill  cterm=reverse
highlight TabLineSel   cterm=bold
highlight TermCursor   cterm=reverse
highlight Title        ctermfg=5
highlight Todo         ctermfg=0       ctermbg=11
highlight Type         ctermfg=2
highlight Underlined   cterm=underline ctermfg=5
highlight Visual       ctermfg=NONE    ctermbg=NONE cterm =inverse
highlight WarningMsg   ctermfg=1
highlight WildMenu     ctermfg=0       ctermbg=13

" Dim line numbers, comments, color columns, the status line, splits and sign
" columns.
if &bg == "light"
  highlight ColorColumn  ctermfg=15   ctermbg=8
  highlight Comment      ctermfg=7
  highlight CursorLineNr ctermfg=9    ctermbg=NONE
  highlight FoldColumn   ctermfg=8    ctermbg=7
  highlight Folded       ctermfg=8    ctermbg=7
  highlight LineNr       ctermfg=7
  highlight Pmenu        ctermfg=0    ctermbg=7
  highlight PmenuSel     ctermfg=7    ctermbg=0
  highlight SignColumn                ctermbg=7
  highlight SpellCap     ctermfg=8    ctermbg=7
  highlight StatusLine   ctermfg=0    ctermbg=7    cterm=bold
  highlight StatusLineNC ctermfg=8    ctermbg=7    cterm=NONE
  highlight VertSplit    ctermfg=8    ctermbg=7    cterm=NONE
else
  highlight ColorColumn  ctermfg=0    ctermbg=8
  highlight CursorLineNr ctermbg=NONE ctermfg=7
  highlight Comment      ctermfg=8
  highlight FoldColumn   ctermfg=0    ctermbg=7
  highlight Folded       ctermbg=0    ctermfg=NONE cterm=bold
  highlight LineNr       ctermfg=8    ctermbg=NONE
  highlight Pmenu        ctermfg=15   ctermbg=0
  highlight PmenuSel     ctermfg=8    ctermbg=15
  highlight SignColumn   ctermfg=7    ctermbg=0
  highlight SpellCap     ctermfg=7    ctermbg=8
  highlight StatusLine   ctermfg=15   ctermbg=8    cterm=bold
  highlight StatusLineNC ctermfg=7    ctermbg=8    cterm=NONE
  highlight VertSplit    ctermfg=7    ctermbg=8    cterm=NONE
endif

"    if ( &bg == "light" )
"        highlight ColorColumn ctermbg=15 ctermfg=8
"        highlight CursorLineNr ctermbg=15
"        highlight FoldColumn ctermbg=15 ctermfg=8
"        highlight Folded ctermbg=15 cterm=bold
"        highlight LineNr ctermbg=15 ctermfg=8
"        highlight SignColumn ctermbg=15 ctermfg=8
"        highlight Statusline ctermbg=15 ctermfg=8
"        highlight StatuslineNC ctermbg=15 ctermfg=8
"    endif

highlight TodoDueToday ctermbg=yellow ctermfg=black cterm=bold
highlight CursorLine cterm=bold gui=bold
highlight Comment ctermfg=7 cterm=italic cterm=italic
