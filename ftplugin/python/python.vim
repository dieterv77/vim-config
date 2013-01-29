setlocal softtabstop=4
setlocal shiftwidth=4
setlocal foldcolumn=1
setlocal foldnestmax=3
setlocal foldmethod=indent

function! ReadPyTemplate()
   execute('0read $HOME/'.g:myvimpath.'/templates/python-template.py')
endfunction

map ,rt :call ReadPyTemplate()<CR>

if isdirectory("C:\\Python27\\Scripts")
   map ,pf  :!python C:\\Python27\\Scripts\\pyflakes %<CR>
else
   map ,pf  :!pyflakes %<CR>
endif
map <f9> :w<CR>:!python %<CR>

setlocal keywordprg=pydoc

if !has('python')
   let g:SuperTabDefaultCompletionType = "<c-p>"
endif
