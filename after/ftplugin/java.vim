execute 'map ,rt  :0read $HOME/'.g:myvimpath.'/templates/java-template.java<cr>'

map <f9> :w<CR>:!javac %;java %:r<CR>
