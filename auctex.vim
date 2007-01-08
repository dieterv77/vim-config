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

    " Check to see if you're in a math environment.  Doesn't work for $$...$$.
    let line = getline('.')
    let len = strlen(line)
    let column = col('.') - 1
    let ending = strpart(line, column, len)
    let n = 0

    let dollar = 0
    while n < strlen(ending)
	if ending[n] == '$'
	    let dollar = 1 - dollar
	endif
	let n = n + 1
    endwhile

    let math = 0
    let ln = line('.')
    while ln > 1 && getline(ln) !~ '\\begin\|\\end\|\\\]\|\\\['
	let ln = ln - 1
    endwhile
    if getline(ln) =~ 'begin{\(eq\|arr\|align\|mult\)\|\\\['
	let math = 1
    endif

    " Check to see if you're between brackets in \ref{} or \cite{}.
    " Inspired by Vim-Latex: http://vim-latex.sourceforge.net
    " Typing q returns you to editing
    " Typing <CR> or Left-clicking takes the data into \ref{} or \cite{}.
    " Within \cite{}, you can enter a regular expression followed by <Tab>,
    " Only the citations with matching authors are shown.
    " \cite{c.*mo<Tab>} will show articles by Mueller and Moolinar, for example.
    " Once the citation is shown, you type <CR> anywhere within the citation.
    " The bibtex files listed in \bibliography{} are the ones shown.
	 if strpart(line,column-5,5) == '\ref{'
		 let tmp = tempname()
		 vertical 20split
		 execute "write! ".tmp
		 execute "edit ".tmp
		 g!/\\label{/delete
		 %s/.*\\label{//e
		 %s/}.*//e
		 noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>RefInsertion()<CR>a
		 noremap <buffer> <CR> :call <SID>RefInsertion()<CR>a
		 noremap <buffer> q :bwipeout!<CR>i
		 return "\<Esc>"
	 elseif strpart(line,column-8,8) == '\eqnref{'
		 let tmp = tempname()
		 vertical 20split
		 execute "write! ".tmp
		 execute "edit ".tmp
		 g!/\\label{eqn:/delete
		 %s/.*\\label{//e
		 %s/}.*//e
		 noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>RefInsertion()<CR>a
		 noremap <buffer> <CR> :call <SID>RefInsertion()<CR>a
		 noremap <buffer> q :bwipeout!<CR>i
		 return "\<Esc>"
	 elseif match(strpart(line,0,column),'\\cite.*{[^}]*$') != -1
		 let m = matchstr(strpart(line,0,column),'[^{]*$')
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
					silent %g/author\c/call <SID>BibPrune(m)
				 endif
				 noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>CiteInsertion()<CR>a
				 noremap <buffer> <CR> :call <SID>CiteInsertion()<CR>a
				 noremap \<buffer> q :bwipeout!<CR>i
				 return "\<Esc>"
			 else
				 bwipeout!
				 return ''
			 endif

		 endif
"    elseif dollar == 1   " If you're in a $..$ environment
"       if ending[0] =~ ')\|]\||\|\}'
"          return "\<Right>"
"       elseif ending =~ '{'
"          return "\<Esc>f{a"
"       else
"          return "\<Esc>f$a"
"       end
"       "return "\<Esc>f$a"
"    elseif math == 1    " If you're in a regular math environment.
"       if ending =~ '^\s*&'
"          return "\<Esc>f&a"
"       elseif ending[0] =~ ')\|]\||'
"          return "\<Right>"
"       elseif ending =~ '{'
"          return "\<Esc>f{a"
"       elseif ending =~ '}'
"          if line =~ '\\label'
"             return "\<Down>"
"          else
"             return "\<Esc>f}a"
"          endif
"       elseif column == len    "You are at the end of the line.
"          return "\<Esc>/\\\\end\\|\\\\]\<CR>$o"
"       else
"          return "\<C-O>$"
"       endif
	 else   " If you're not in a math environment.
		 " Thanks to Benoit Cerrina (modified)
		 if ending[0] == ')'  " Go past right parentheses.
			 return "\<Right>"
		 elseif !column || line[column - 1] !~ '\k' 
			 return "\<Tab>" 
		 elseif a:direction == 'backward'
			 return "\<C-P>" 
		 else 
			 return "\<C-N>" 
		 endif 

	 endif
 endfunction 

function! s:RefInsertion()
    normal 0y$
    bwipeout!
    let thisline = getline('.')
    let thiscol  = col('.')
    if thisline[thiscol-1] == '{'
	normal p
    else
	normal P
	if thisline[thiscol-1] == '}'
	    normal l
	    if thisline[thiscol] == ')'
		normal l
	    endif
	endif
    endif
endfunction

function! s:CiteInsertion()
    +
    if search('@','b') != 0
        normal f{lyt,
        bwipeout!
		  let thisline = getline('.')
		  let thiscol  = col('.')
		  if thisline[thiscol-1] == '{'
			  normal p
		  else
			  if thisline[thiscol-2] == '{'
				  normal P
			  else
				  "              Depending on if this is the end of the line, just
				  "              delete from different places 
				  if thiscol == strlen(thisline)
					  normal vT{"_dp
				  else		
					  normal hvT{"_dP
				  endif
			  endif
		  endif
	  else
        bwipeout!
    endif
endfunction

function! s:BibPrune(m)
    if getline(line('.')) !~? a:m
        ?@
        let lfirst = line('.')
        /@
        let lsecond = line('.')
        if lfirst < lsecond
	    exe lfirst.','.(lsecond-1).'delete'
        else
	    exe lfirst.',$delete'
        endif
    endif
endfunction

" }}}
" "========================================================================="

" vim:fdm=marker
