" *Keybindings*
" NORMAL Mode
nnoremap <leader>* i*<esc>ea*<esc>
nnoremap <leader>_ i_<esc>ea_<esc>
nnoremap <leader>` i`<esc>ea`<esc>
nnoremap <leader>[ i[<esc>ea]()<esc>
nnoremap <leader>> 0i> <esc>
nnoremap <leader>- i---<CR><CR>---<esc>ki
nnoremap <leader># i#<esc>a<space>

" VISUAL Mode
vnoremap <leader>* <esc>`>a*<esc>`<i*<esc>gv2l
vnoremap <leader>_ <esc>`>a_<esc>`<i_<esc>gv2l
vnoremap <leader>` <esc>`>a`<esc>`<i`<esc>gv2l
vnoremap <leader>[ <esc>`>a]()<esc>`<i[<esc>gv2l

" *Autocmds*
function! s:pan() abort
  let result=search('pandocTargets:')
  let includes=search('pandocIncludes:')
  let tags=search('tags')
  if includes > 0
    let line=getline(includes)
    let incs=split(line)[1:]
    echom "Including: " . join(incs, ', ')
    let si = ""
    for inc in incs
      if inc !~ "\.md$" 
        let si .= " " . inc . ".md" 
      else 
        let si .= " " . inc
      endif
    endfor
    echom "Compiling: " . join(incs, ', ') 
    execute '!pandoc -s <afile>' . si . ' -o <afile>:t:r-compiled.md'
  else 
    echom "No inclusions."
  endif
  
  if result > 0 
    let line=getline(result)
    let targets=split(line)[1:]
    echom "Converting to: " . join(targets, ', ')
    for target in targets
      execute '!pandoc -s <afile> -o <afile>:t:r.' . target
    endfor
  else 
    echom "No pandoc targets."
  endif

  if tags > 0
    let line=getline(tags)
    let ts=split(line)[1:]
    call map(ts, {i, v -> substitute(v, '|', '', 'g')})
    let fname=expand('%:t')
    let appendages=[]
    echom "Generating tags: " . join(ts, ', ')
    
    if filereadable("./tags")
      let tfile=readfile('./tags')
    else
      let tfile=[]
    endif

    for t in ts
      let fs = map(copy(tfile), {l, v -> split(v, '\s')})
      call filter(fs, {i, v -> len(v) != 0})
      call filter(fs, {x, v -> v[0] == t && v[1] == fname})
        if len(fs) > 0 
          continue
        endif 
      call add(appendages, t . "\t" . fname . "\t" . "/" . t)
    endfor
     
    if len(appendages) > 0 
      new 
      setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
      call append(line('$'), appendages)
      execute 'w >> ' "./tags"
      q
    else
      echom "All tags already generated."
    endif

  else 
    echom "No tags."
  endif

endfunction

" Convert mds using pandoc
augroup markdown
  autocmd!
  autocmd BufWritePost *.md call s:pan()
augroup END
