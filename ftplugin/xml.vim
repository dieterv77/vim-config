set foldmethod=syntax
set foldnestmax=5
set foldcolumn=2

execute 'so $HOME/'.g:myvimpath.'/custom/closetag.vim'
"Map the tag completion to <F9>
imap <F9> <C-_>
nmap <F9> <C-_>
