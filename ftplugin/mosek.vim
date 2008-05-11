let b:match_words='\[\@<=\(\w.\{-}\)[ \]]\@=:\[\@<=/\1\]'
function! CallMosekMatchPy()
   execute 'pyf $HOME/'.g:myvimpath.'/ftplugin/mosekmatch.py'
endfunction

imap <F9> <ESC>:call CallMosekMatchPy()<CR>a
nmap <F9> :call CallMosekMatchPy()<CR>
