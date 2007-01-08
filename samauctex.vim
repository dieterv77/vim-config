" Modified April 10, 2006 by Sam to get different behavior for cite and
" ref
" 
" Vim filetype plugin
" Language:	LaTeX
" Maintainer: Carl Mueller, cmlr@math.rochester.edu
" Last Change:	July 30, 2004
" Version:  2.0008
" Website:  http://www.math.rochester.edu/u/cmlr/vim/syntax/index.html


" "========================================================================="
" "========================================================================="
" Tab key mapping   {{{
" In a math environment, the tab key moves between {...} braces, or to the end
" of the line or the end of the environment.  Otherwise, it does word
" completion.  But if the previous character is a blank, or if you are at the
" end of the line, you get a tab.  If the previous characters are \ref{
" then a list of \label{...} completions are displayed.  Choose one by
" clicking on it, pressing Enter, or pressing K.  q quits the display.
" (Thanks to Vim-Latex, http://vim-latex.sourceforge.net).

inoremap <Tab> <C-R>=<SID>TexInsertTabWrapper ('backward')<CR>
inoremap <M-Space> <C-R>=<SID>TexInsertTabWrapper ('backward')<CR>
inoremap <C-Space> <C-R>=<SID>TexInsertTabWrapper ('forward')<CR>
function! s:TexInsertTabWrapper(direction) 

if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
	      return "\<Tab>"
else
  let line = getline('.')
  let len = strlen(line)
  let column = col('.') - 1

  " With this setup, line[column] is the character just to the right of
  " where user pressed <Tab>
  
  " Determine if we are at end of line
  if strlen(line[column]) == 0
    let g:EOL = 1
  else
    let g:EOL = 0
  endif

  " Determine what column the slash (\) is in (going backwards)
  let slashcol = column-1
  while slashcol >= 0
    if line[slashcol] == '\'
      break
    endif
    let slashcol = slashcol-1
  endwhile

  " mystr should contain exactly what user intended
  let mystr = strpart(line,slashcol,column-slashcol)

  let match1 = match(mystr,'ref.*,[^}]*$')
  let match2 = match(mystr,'ref.*{[^}]*$')
  let match3 = match(mystr,'cite.*,[^}]*$')
  let match4 = match(mystr,'cite.*{[^}]*$')

  if match1 != -1 || match2 != -1

    " Move back one. This ensures cursor is on last character intended
    " by user. Useful for GenericInsertion. Probably could be removed.
    " Also update column variable.
    normal h

    if match1 != -1 
      let m = matchstr(mystr,'[^,]*$')
      let g:commaflag = 1
    else
      let m = matchstr(mystr,'[^{]*$')
      let g:commaflag = 0
    endif
    let tmp = tempname()
    vertical 20split
    execute "write! ".tmp
    execute "edit ".tmp
    g!/\\label{/delete"
    %s/.*\\label{//e
    %s/}.*//e
    if strlen(m) > 0
      execute "g!/" . m . "/delete"
    endif
    noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>RefInsertion()<CR>a
    noremap <buffer> <CR> :call <SID>RefInsertion()<CR>a
    noremap <buffer> q :bwipeout!<CR>a
    return "\<Esc>"
  elseif match3 != -1 || match4 != -1

    " Move back one. This ensures cursor is on last character intended
    " by user. Useful for GenericInsertion. Probably could be removed.
    " Also update column variable.
    normal h

    if match3 != -1 
      let m = matchstr(mystr,'[^,]*$')
      let g:commaflag = 1
    else
      let m = matchstr(mystr,'[^{]*$')
      let g:commaflag = 0
    endif
    let tmp = tempname()
    execute "write! ".tmp
    execute "split ".tmp
    let l = search('\\bibliography{')
    bwipeout!
    if l == 0
      return ''
    else
      let s = getline(l)
      let beginning = matchend(s, '\\bibliography{')
      let ending = matchend(s, '}', beginning)
      let f = strpart(s, beginning, ending-beginning-1)
      let tmp = tempname()
      execute "below split ".tmp
      let file_exists = 0
      while f != ''
        let comma = match(f, ',[^,]*$')
        if comma == -1
          let file = f.'.bib'
          if filereadable(file)
            let file_exists = 1
            execute "0r ".file
          endif
          let f = ''
        else
          let file = strpart(f, comma+1)
          let file = file.'.bib'
          if filereadable(file)
            let file_exists = 1
            execute "0r ".file
          endif
          let f = strpart(f, 0, comma)
        endif
      endwhile
      if file_exists == 1
        if strlen(m) != 0
          normal gg
          let lfirst = line('.')
          normal G
          let lsecond = line('.')
          exe "g/" . m . "\\c/call <SID>BibPrune(m)"
          exe lfirst . ',' . lsecond . 'delete'
        endif
        normal w!
        noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>CiteInsertion()<CR>a
        noremap <buffer> <CR> :call <SID>CiteInsertion()<CR>a
        noremap <buffer> q :bwipeout!<CR>a
        return "\<Esc>"
      else
        bwipeout!
        return ''
      endif
    endif

  else

      return "\<C-N>" 

  endif
endif
endfunction 

function! s:RefInsertion()
    normal 0y$
    bwipeout!
    call <SID>GenericInsertion()
endfunction

function! s:CiteInsertion()
    let thisline = getline('.')
    let thiscol  = col('.')
    if thisline[thiscol-1] == '@' || search('@','b') != 0
        normal f{lyt,
        bwipeout!
        call <SID>GenericInsertion()
    else
        bwipeout!
    endif
endfunction

function! s:GenericInsertion()
    let thisline = getline('.')
    if g:commaflag == 1
      let specchar = ','
    else
      let specchar = '{'
    end
    while thisline[col('.') - 1] != specchar
      if g:EOL == 1
        normal x
      else
        normal xh
      endif
    endwhile
    normal "0p
endfunction

function! s:BibPrune(m)
  let thisline = getline('.')
  if thisline[col('.')-1] != '@'
  ?@
  endif
  let lfirst = line('.')
  normal f{
  normal %
  let lsecond = line('.')
  exe lfirst . ',' . lsecond . 'yank'
  normal GpGo
endfunction

" }}}
" "========================================================================="

" vim:fdm=marker
