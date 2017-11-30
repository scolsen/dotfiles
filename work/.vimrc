" color
color zellsen

" set right margin to 78
" set textwidth=78

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

" sets a new command Q to just q.
command! Q q

" sets command W to just w.
command! W w

" script abbreviations
iab hsk #!/usr/bin/env<SPACE>stack<CR>--<SPACE>stack<SPACE>--resolver<SPACE>lts-9.11<SPACE>script<CR>
iab rby #!/usr/bin/env<SPACE>ruby
iab nde #!/usr/bin/env<SPACE>node

" Set Tabs to spaces
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=4
set shiftround

" netrw browser customization
let g:netrw_browse_split = 2
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

" Create new sh files with sh.stub
:au BufNewFile *.sh r ~/.vim/templates/%:e.stub

" Create new js files with js.stub
:au BufNewFile *.js r ~/.vim/templates/%:e.stub

" Create new man pages with man.stub
:au BufNewFile *.[1-9] r ~/.vim/templates/%:e.stub

" Create new notes with notes.stub
:au BufNewFile *-notes.md r ~/.vim/templates/notes.stub
