augroup filetypedetect
au BufNewFile,BufRead *.mod	setf ampl
au BufNewFile,BufRead *.ampl	setf ampl
au BufNewFile,BufRead *.dat	setf ampl
augroup END
augroup filetypedetect
au BufRead,BufNewFile *.ieq setf porta
au BufRead,BufNewFile *.poi setf porta
augroup END
augroup filetypedetect
au BufRead,BufNewFile *.gms setf gms
augroup END

augroup filetypedetect
au BufRead,BufNewFile *.opf setf mosek
augroup END


augroup filetypedetect
au BufNewFile,BufRead *.i set filetype=swig 
augroup END

"augroup filetypedetect
"au BufRead,BufNewFile *.m setf octave
"augroup END

"Set Linux.config, Windows.config, Solaris.config to be make filetype
augroup filetypedetect
au BufNewFile,BufRead Linux.config set filetype=make
au BufNewFile,BufRead Windows.config set filetype=make
au BufNewFile,BufRead Windows.config set filetype=make
au BufNewFile,BufRead Common.config set filetype=make
augroup END
"au BufRead,BufNewFile *  setfiletype txt
