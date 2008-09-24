if !exists('g:xml_syntax_folding') && input("Fold xml syntax (y/n)?\n") == "y"
   let g:xml_syntax_folding = 1
   set foldmethod=syntax
   set foldnestmax=5
   set foldcolumn=2
endif

function! CallSetXMLFolding()
   set foldmethod=syntax
   set foldnestmax=5
   set foldcolumn=2
   let g:xml_syntax_folding = 1
   syntax on
endfunction

nmap ,rf :call CallSetXMLFolding()<CR>

execute 'so $HOME/'.g:myvimpath.'/custom/closetag.vim'
"Map the tag completion to <F9>
imap <F9> <C-_>
nmap <F9> <C-_>
