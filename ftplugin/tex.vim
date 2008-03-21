"include auctex rippoff
execute 'so $HOME/'.g:myvimpath.'/samauctex.vim'
"Include folding file stolen from latex-suite
execute 'so $HOME/'.g:myvimpath.'/fold/tex-folding.vim'
"Start from first line, otherwise folding not quite right
"Create actual folds
call MakeTexFolds(0)
"Set map to redo folds
map ,rf  :call MakeTexFolds(1)<cr>
"Set typing textwidth
set textwidth=72
"Add tex words to dictionary
if has("win32")
   set dictionary+=$HOME/vimfiles/wordlists/tex-dict.list
else
   set dictionary+=$HOME/.vim/wordlists/tex-dict.list
endif
set complete+=k
call LatexMenu()
call LatexMap()

function! CallTexMatchPy()
   execute 'pyf $HOME/'.g:myvimpath.'/ftplugin/texmatch.py'
endfunction

imap <F9> <ESC>:call CallTexMatchPy()<CR>i
nmap <F9> :call CallTexMatchPy()<CR>

map ,rt :call ReadTexTemplate()<CR>

setlocal spell
