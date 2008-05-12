" Only load this indent file when no other was loaded yet.
if exists("b:did_indent")
 finish
endif
let b:did_indent = 1


" Some preliminary setting
setlocal indentkeys=!,o,O,[,/


setlocal indentexpr=GetMosekIndent(v:lnum)

" Only define the function once.
if exists("*GetMosekIndent")
  finish
endif


function GetMosekIndent(lnum)
  " Search backwards for the first non-empty line.
  let plnum = v:lnum - 1
  while plnum > 0 && getline(plnum) =~ '^\s*$'
    let plnum = plnum - 1
  endwhile

  if plnum == 0
    " This is the first non-empty line, use zero indent.
    return 0
  endif

  let curind = indent(plnum)
  if getline(plnum) =~ '\[\w.\{-}\]'
     if getline(plnum) !~ '\[/.\{-}\]$'
        return curind + &sw
     endif
  endif
  if getline(v:lnum) =~ '\[/.\{-}\]'
     if getline(v:lnum) !~ '^\s\{-}\[\w.\{-}\]'
        return curind - &sw
     endif
  endif
  return curind
endfunction
