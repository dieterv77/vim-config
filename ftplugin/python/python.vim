setlocal softtabstop=4
setlocal shiftwidth=4
setlocal foldcolumn=1
setlocal foldnestmax=3
setlocal foldmethod=indent

function! ReadPyTemplate()
   execute('0read $HOME/'.g:myvimpath.'/templates/python-template.py')
endfunction

map ,rt :call ReadPyTemplate()<CR>

map ,pf  :!pyflakes %<CR>
map <f9> :w<CR>:!python %<CR>

map ,ie $a<CR>from IPython import embed; embed()<ESC>
map ,de <ESC>:g/from IPython import embed; embed()/d<CR>

setlocal keywordprg=pydoc

if !has('python')
   let g:SuperTabDefaultCompletionType = "<c-p>"
endif
