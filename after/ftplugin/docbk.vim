set filetype=xml syntax=docbook
syntax on
setlocal spell
execute 'so $HOME/'.g:myvimpath.'/custom/closetag.vim'
"Map the tag completion to <F9>
imap <F9> <C-_>
nmap <F9> <C-_>
"Set typing textwidth
set textwidth=72
