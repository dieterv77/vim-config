if exists("loaded_dieter_xml") || &cp
  finish
endif
let loaded_dieter_xml = 1

if !exists('g:xml_syntax_folding') 
   let s:userinput = input("Fold xml syntax ([y]/n)?\n")
   if (s:userinput == "y") || (s:userinput == "")
      let g:xml_syntax_folding = 1
   endif
   unlet s:userinput
endif

if exists('g:xml_syntax_folding')
   set foldmethod=syntax
   set foldnestmax=7
   set foldcolumn=2
   syntax on
endif

function! CallSetXMLFolding()
   set foldmethod=syntax
   set foldnestmax=7
   set foldcolumn=2
   let g:xml_syntax_folding=1
   syntax on
endfunction

nmap ,rf :call CallSetXMLFolding()<CR>

execute 'so $HOME/'.g:myvimpath.'/custom/closetag.vim'
"Map the tag completion to <F9>
imap <F9> <C-_>
nmap <F9> <C-_>
