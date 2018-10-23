" *Options*
set statusline=λ\ %=%f\ %y\ line:%l\ column:%c
set wrap linebreak nolist
set hlsearch
set tabstop=8
set expandtab
set softtabstop=2
set shiftwidth=2
set shiftround
set autoindent
set smartindent
set spell
" set textwidth=80

syntax enable
filetype plugin on
color gruvbox
set background=dark
let g:gruvbox_contrast_dark='soft'


" *Keybindings*
let mapleader = " "

" NORMAL Mode
" Window Navigation
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l
nmap <leader>h <c-w>h

nmap k gk
nmap j gj
nmap 0 ^

nmap <leader>vr :sp $MYVIMRC
nmap <leader>vi :vnew $MYVIMRC
nmap <leader>so :source $MYVIMRC
nmap <leader>n :set number!<RETURN>
nmap <leader>s ]s
nmap <leader>c :vs ~/.vim/citations<RETURN>
nmap <leader>t :set expandtab!
nmap <leader>b :Vex<RETURN>
nmap <leader>L :set list!<RETURN>
nmap <leader>m `m
nmap <leader>d "_d
nmap <leader>te :tabedit 
nnoremap <leader><leader> :tabnext<CR>

" INSERT Mode
imap fj <esc>

" VISUAL Mode
vmap fj <esc>
vmap <leader> $
vmap <BS> <DEL>
vmap s /\./e<CR>

" *Packages*
" Package management with minpac
packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type':'opt'})
call minpac#add('vim-airline/vim-airline')
call minpac#add('tpope/vim-fugitive')
call minpac#add('rizzatti/dash.vim')
call minpac#add('flazz/vim-colorschemes')
call minpac#add('vim-syntastic/syntastic')
call minpac#add('sjl/clam.vim')
call minpac#add('idris-hackers/idris-vim')
call minpac#add('tpope/vim-fireplace')
call minpac#add('mhinz/vim-signify')
call minpac#add('junegunn/goyo.vim')
call minpac#add('rhysd/vim-crystal')


" *Functions*
" macOS tagging functions
function! s:getOS()
  let g:os = substitute(system('uname'), '\n', '', '')
endfunction

function! s:setTag(tag)
  call s:getOS()
  if g:os != "Darwin"
    echom "Tagging only supported on macos systems."  
  else
    execute '!xattr -w com.apple.metadata:_kMDItemUserTags ' . a:tag . ' ' . expand('%') 
  endif
endfunction

function! s:listTags()
  call s:getOS()
  if g:os != "Darwin"
    echom "Tagging only supported on macos systems."  
  else
    execute 'new | setlocal buftype=nofile bufhidden=hide noswapfile | r !mdls -name kMDItemUserTags -raw ' . expand('%') 
  endif
endfunction

" *Commands*
command! Q q
command! W w
command! Tags call s:listTags()
command! Packup call minpac#update()
command! Packclean call minpac#clean()

" *Abbreviations*
iab jekq <p<SPACE>class="quote"<SPACE>id="q:n"><CR><TAB><sup<SPACE>id="fnref:n"><CR><TAB><TAB><a<SPACE>href="#fn:n"<SPACE>class="footnote"><CR><TAB><TAB></a><CR><TAB></sup><CR></p><CR>><SPACE>**<a<SPACE>id="fn:n"<SPACE>href="#q:n"></a>**
iab <expr> ;d strftime("%F %H:%M:%S")
iab ;e scg.olsen@gmail.com

" script abbreviations
iab hsk #!/usr/bin/env<SPACE>stack<CR>--<SPACE>stack<SPACE>--resolver<SPACE>lts-9.11<SPACE>script<CR>
iab rby #!/usr/bin/env<SPACE>ruby
iab nde #!/usr/bin/env<SPACE>node
iab bsh #!/usr/bin/env bash
iab lsp #!/usr/bin/env clisp

" *Netrw Settings*
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:lite_dfm_normal_bg_cterm = 0

" Gruvbox color overrides
hi! link markdownH1 GruvboxFg1
hi! link markdownH2 GruvboxFg1
hi! link markdownH3 GruvboxFg1
hi! link markdownH4 GruvboxFg1
hi! link markdownH5 GruvboxFg1
hi! link markdownH6 GruvboxFg1
hi! link markdownHeadingDelimiter GruvboxFg1
