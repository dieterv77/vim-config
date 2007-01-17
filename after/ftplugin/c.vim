" Stuff that shows function definition in preview window
function! Run_hints()
	if has("gui_running")
		silent !ctags -R .
		silent !bash < C:\cygwin\usr\local\bin\hints-vim > hints
		so hints
"      set ch=2
	else
		silent !ctags -R .
		silent !hints-vim > hints
		so hints
"      set ch=2
	endif
endfunction

map ,hints    :call Run_hints()<CR>
"
