" color
color zellsen

" leader must be typed before executing personal commands.
let mapleader = " "

" nmap
nmap 0 ^
nmap <leader>g <c-w><c-w>
nmap <leader>vr :sp $MYVIMRC
nmap <leader>vi :vnew $MYVIMRC
nmap <leader>so :source $MYVIMRC
nmap <leader>n :set number!
nmap k gk
nmap j gj
" copy up to and including next period. Use this instead of ). ) includes a
" whitespace after the next period.
nmap ys yf.
" hotkey toggle tab expansion for files that require spaces and files that require tabs.
nmap <leader>t :set expandtab!

" imap
imap fj <esc>
" quick paste
imap <expr> ;p getreg('')

" vmap
vmap fj <esc>
vmap <leader> $
" Jump to end of sentence.
vmap s /\./e<CR>

" vim markdown mappings.

" normal mode
nmap * i*<esc>ea*<esc>
nmap _ i_<esc>ea_<esc>
nmap ` i`<esc>ea`<esc>
nmap [ i[<esc>ea]()<esc>
nmap > 0i> <esc>
nmap ;- i---<CR><CR>---<esc>ki
nmap ;y ;-
nmap ;1 i#<space>
nmap ;2 i##<space>
nmap ;3 i###<space>
nmap ;4 i####<space>
nmap ;5 i#####<space>
nmap ;6 i######<space>

" visual mode
vmap * c*<C-R>"*<esc>
vmap _ c_<C-R>"_<esc>
vmap ` c`<C-R>"`<esc>
vmap [ c[<C-R>"]()<esc>

" sets a new command Q to just q.
command! Q q

" sets command W to just w.
command! W w

" script abbreviations
iab hsk #!/usr/bin/env<SPACE>stack<CR>--<SPACE>stack<SPACE>--resolver<SPACE>lts-9.11<SPACE>script<CR>
iab rby #!/usr/bin/env<SPACE>ruby
iab nde #!/usr/bin/env<SPACE>node
iab bsh #!/usr/bin/bash

" Set Tabs to spaces
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=4
set shiftround

set wrap
set linebreak
set columns=80

" netrw browser customization
" let g:netrw_browse_split = 2
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
