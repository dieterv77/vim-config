map <F7> :!ctags -R --languages=c++ --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set completeopt-=preview
set complete-=i
if !has("win32")
   set makeprg=make\ -f\ Makefile.Linux\ $*
endif
execute 'map ,rt  :read $HOME/'.g:myvimpath.'/templates/cpp-template.cpp<cr>'
