" color
color minimal

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
nmap cs ct.
nmap <leader>c :vsp ~/.vim/citations<RETURN>
nmap <leader>t :set expandtab!

" insert mode mappings
imap fj <esc>
" short paste
imap <expr> ;p getreg('')

" visual mode mappings
" quick select line
vmap <leader> $
vmap fj <esc>
vmap <BS> <DEL>
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

" sets a new command Q to just q. 
command! Q q

" sets command W to just w.
command! W w

" abbreviation
iab jekq <p<SPACE>class="quote"<SPACE>id="q:n"><CR><TAB><sup<SPACE>id="fnref:n"><CR><TAB><TAB><a<SPACE>href="#fn:n"<SPACE>class="footnote"><CR><TAB><TAB></a><CR><TAB></sup><CR></p><CR>><SPACE>**<a<SPACE>id="fn:n"<SPACE>href="#q:n"></a>**
iab <expr> ;d strftime("%F %H:%M:%S")
iab ;e scg.olsen@gmail.com
" script abbreviations
iab hsk #!/usr/bin/env<SPACE>stack<CR>--<SPACE>stack<SPACE>--resolver<SPACE>lts-9.11<SPACE>script<CR>
iab rby #!/usr/bin/env<SPACE>ruby
iab nde #!/usr/bin/env<SPACE>node
iab bsh #!/usr/bin/env bash
iab lsp #!/usr/bin/env clisp

" set command T to tabedit
nmap <leader>te :tabedit 
nnoremap <leader><leader> :tabnext<CR>

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
