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
set textwidth=80

syntax enable
filetype plugin on

" Color
color bernhard

" Print options
set printheader=%<%f\|\ Lines\:\ %L\ Page\:\ %N
set printoptions=number:n,wrap:n,left:24pc,right:1pc,paper:letter

" *Keybindings*
let mapleader = " "

" NORMAL Mode
" Window Navigation
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l
nmap <leader>h <c-w>h

" Leaderless bindings.
nmap k gk
nmap j gj
nmap 0 ^
nmap : q:i

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
call minpac#add('flazz/vim-colorschemes')
call minpac#add('mhinz/vim-signify')
call minpac#add('junegunn/goyo.vim')
call minpac#add('sjl/gundo.vim')
call minpac#add('scolsen/wurm')
call minpac#add('scolsen/fleur')
call minpac#add('scolsen/bernhard')
call minpac#add('scolsen/lamb')
"call minpac#add('scolsen/gadamer')
call minpac#add('google/vim-maktaba')
call minpac#add('google/vim-glaive')
call minpac#add('itchyny/dictionary.vim')
call minpac#add('hellerve/carp-vim')

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
command! RemoveTrailingWhitespace %s/\s\+$//

" *Netrw Settings*
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:lite_dfm_normal_bg_cterm = 0

" Lisp goodness
" au BufReadPost,BufNewFile *.lisp,*.scm,*.carp,*.clj,*.rkt color lamb

" Load minpac plugins
packloadall

" Load maktaba plugins
call maktaba#plugin#Detect()
