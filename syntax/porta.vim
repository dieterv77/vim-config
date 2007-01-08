" Language:      porta


if version < 600
 syntax clear
elseif exists("b:current_syntax")
 finish
endif




"--
syn keyword portaEntityKeyword	  DIM	VALID	INEQUALITIES_SECTION
syn keyword portaEntityKeyword	  CONE_SECTION	CONV_SECTION	END	  
syn keyword portaEntityKeyword    LOWER_BOUNDS UPPER_BOUNDS

"--


"--
syn keyword portavar	 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 




syn match portaoperators   "<=\|==\|>="





"--


















if version >= 508 || !exists("did_porta_syntax_inits")
  if version < 508
    let did_ampl_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting. Can be overridden later.
  HiLink portaEntityKeyword	String
  HiLink portavar		Type
  HiLink portaoperators		Operator	
  delcommand HiLink
endif

let b:current_syntax = "porta"

" vim: ts=8


