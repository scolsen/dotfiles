" color
color minimal

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
" change sentence, do not overwrite period.
nmap cs ct.
" hotkey toggle tab expansion for files that require spaces and files that require tabs.
nmap <leader>t :set expandtab!
nmap <leader>f :Goyo

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
" vmap * c*<C-R>"*<esc>
vnoremap * <esc>`>a*<esc>`<i*<esc>gv2l
vnoremap _ <esc>`>a_<esc>`<i_<esc>gv2l
vnoremap ` <esc>`>a`<esc>`<i`<esc>gv2l
vnoremap [ <esc>`>a]()<esc>`<i[<esc>gv2l

"Autocmds for md
function! s:pan()
  let result=search('pandocTargets:')
  if result > 0  
    let line=getline(result)
    let targets = split(line)[1:]
  else 
    echom "No pandocTargets: YAML front matter found."
    return 1
  endif
  echom "Converting to: " . join(targets, ', ')
  for target in targets
    execute '!pandoc -s <afile> -o <afile>:t:r.' . target
  endfor
endfunction

" convert mds to rtf
augroup markdown
  autocmd!
  autocmd BufWritePost *.md call s:pan()
augroup END

augroup lisps
  autocmd!
  autocmd BufRead,BufNewFile *.{lisp,lsp,clj,cl} setlocal textwidth=80
augroup END

" sets a new command Q to just q.
command! Q q

" sets command W to just w.
command! W w

" set command T to tabedit
nmap <leader>te :tabedit 
nnoremap <leader><leader> :tabnext<CR>

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

" Open gloabl search results in a temporary buffer
command! -nargs=? Find let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a
" Yank all in place.
command! -nargs=? GYank let @a='' | execute 'g/<args>/y A' | execute 'g/<args>/d'
" Register paste
nmap <leader>p "ap

set wrap
" set columns=80

" netrw browser customization
let g:netrw_liststyle = 3

" Goyo settings
let g:goyo_width=120

execute pathogen#infect()
