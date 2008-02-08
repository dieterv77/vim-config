set foldcolumn=1
set foldnestmax=3
setlocal foldmethod=indent
map ,rt  :read $HOME/.vim/templates/python-template.py<cr>
map <f9> :w<CR>:!python %<CR>
