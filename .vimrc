" 0 jumps to start of line.
nmap 0 ^

" leader must be typed before executing personal commands.
let mapleader = ","

" opens vimrc in seperate window.
nmap <leader>vr :sp $MYVIMRC
nmap <leader>vi :vnew $MYVIMRC

" load in rc without quiting.
nmap <leader>so :source $MYVIMRC

" exit insert mode mapping.
imap fj <esc>

" display line numbers.
set number 

" move through wrapped lines as if they are seperate.
nmap k gk
nmap j gj

" sets a new command Q to just q. 
command! Q q


