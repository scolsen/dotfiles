" color
color zellsen

" soft wrap
set wrap linebreak nolist

" map leader must be entered before certain commands
let mapleader = " "

"normal mode mappings
nmap 0 ^
nmap <leader>g <c-w><c-w>
nmap <leader>vr :sp $MYVIMRC
nmap <leader>vi :vnew $MYVIMRC
nmap <leader>so :source $MYVIMRC
nmap <leader>n :set number!<RETURN>
nmap k gk
nmap j gj
nmap <leader>s ]s
nmap ys yf.
nmap <leader>c :vsp ~/.vim/citations<RETURN>

" open nerdtree
nmap <leader>t :NERDTreeToggle<CR>


" insert mode mappings
imap fj <esc>
" short paste
imap <expr> ;p getreg('')

" visual mode mappings
" quick select line
vmap <leader> $
vmap fj <esc>
vmap <BS> <DEL>

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
" vmap * c*<C-R>"*<esc>
vnoremap * <esc>`>a*<esc>`<i*<esc>gv2l
vnoremap _ <esc>`>a_<esc>`<i_<esc>gv2l
vnoremap ` <esc>`>a`<esc>`<i`<esc>gv2l
vnoremap [ <esc>`>a]()<esc>`<i[<esc>gv2l

"Autocmds for md
" convert mds to rtf
augroup markdown
  autocmd!
  autocmd BufWritePost *.md !pandoc -s <afile> -o <afile>:t:r.rtf
augroup END

" sets a new command Q to just q. 
command! Q q

" sets command W to just w.
command! W w

" abbreviation
iab jekq <p<SPACE>class="quote"<SPACE>id="q:n"><CR><TAB><sup<SPACE>id="fnref:n"><CR><TAB><TAB><a<SPACE>href="#fn:n"<SPACE>class="footnote"><CR><TAB><TAB></a><CR><TAB></sup><CR></p><CR>><SPACE>**<a<SPACE>id="fn:n"<SPACE>href="#q:n"></a>**
iab hsk #!/usr/bin/env<SPACE>stack<CR>--<SPACE>stack<SPACE>--resolver<SPACE>lts-9.11<SPACE>script<CR>
iab <expr> ;d strftime("%F %H:%M:%S")
iab ;e scg.olsen@gmail.com

" set tabs to spaces 
set tabstop=8
set expandtab
set softtabstop=2
set shiftwidth=2
set shiftround
set autoindent
set smartindent

" Enable syntax
syntax enable

" Set spell check
setlocal spell

" Customize statusline
set statusline=%f\ -\ %l

" Customize Dir Explorer (netrw) settings
let g:netrw_liststyle = 3

" When opening a file in netrw, open in a vert split
" let g:netrw_browse_split = 2

