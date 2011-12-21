setlocal softtabstop=4
setlocal shiftwidth=4
setlocal foldcolumn=1
setlocal foldnestmax=3
setlocal foldmethod=indent
map ,rt  :0read $HOME/.vim/templates/python-template.py<cr>
if isdirectory("C:\\Python27\\Scripts")
   map ,pf  :!python.exe C:\\Python27\\Scripts\\pyflakes %<CR>
else
   map ,pf  :!pyflakes %<CR>
endif
map <f9> :w<CR>:!python %<CR>

setlocal keywordprg=pydoc
setlocal omnifunc=pythoncomplete#Complete

