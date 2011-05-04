setlocal softtabstop=4
setlocal shiftwidth=4
setlocal foldcolumn=1
setlocal foldnestmax=3
setlocal foldmethod=indent
map ,rt  :0read $HOME/.vim/templates/python-template.py<cr>
map ,pf  :!pyflakes %<CR>
map <f9> :w<CR>:!python %<CR>

setlocal keywordprg=pydoc
setlocal omnifunc=pythoncomplete#Complete

