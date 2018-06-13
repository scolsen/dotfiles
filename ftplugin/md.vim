" *Keybindings*
" NORMAL Mode
nnoremap <leader>* i*<esc>ea*<esc>
nnoremap <leader>_ i_<esc>ea_<esc>
nnoremap <leader>` i`<esc>ea`<esc>
nnoremap <leader>[ i[<esc>ea]()<esc>
nnoremap <leader>> 0i> <esc>
nnoremap <leader>- i---<CR><CR>---<esc>ki
nnoremap <leader># i#<esc>

" VISUAL Mode
vnoremap <leader>* <esc>`>a*<esc>`<i*<esc>gv2l
vnoremap <leader>_ <esc>`>a_<esc>`<i_<esc>gv2l
vnoremap <leader>` <esc>`>a`<esc>`<i`<esc>gv2l
vnoremap <leader>[ <esc>`>a]()<esc>`<i[<esc>gv2l

" *Autocmds*
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

" Convert mds using pandoc
augroup markdown
  autocmd!
  autocmd BufWritePost *.md call s:pan()
augroup END
