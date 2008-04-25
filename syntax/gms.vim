"Vim syntax file
"Language: gams
"
"
"For version 5.x: Clear all syntax items
"For version 6.x: Quit when a syntax file was already loaded
if version < 600
syntax clear
elseif exists("b:current_syntax")
finish
endif
"
"A bunch of gams keywords
syn keyword gamsStatement Sets Set SET SETS set sets
syn keyword gamsStatement Table table TABLE
syn keyword gamsStatement Parameter Parameters PARAMETER PARAMETERS parameter
"parameter parameters
syn keyword gamsStatement Model model MODEL model
syn keyword gamsStatement Solve solve SOLVE
syn keyword gamsStatement Equations Equation equation EQUATIONS
"equations
syn keyword gamsStatement Variable variable Variables variables VARIABLE VARIABLES
syn keyword gamsStatement $option $OPTION $Option
syn keyword gamsStatement display DISPLAY Display
syn keyword gamsStatement option Option
syn keyword gamsStatement Alias alias
syn keyword gamsStatement Scalar scalar SCALAR
syn keyword gamsStatement xxpto
"
syntax keyword gamsFunction ABS abs Abs ASC asc Asc
syntax keyword gamsFunction abs acos acosh alias asin asinh atan atan2
syntax keyword gamsFunction atanh ceil ctime cos cosh exp floor log log10
syntax keyword gamsFunction max min precision round sin sinh sqrt tan tanh
syntax keyword gamsFunction time trunc div
"
syntax keyword gamsTodo contained TODO
"
syn match gamsSpecial "^\$\<[^ ]\+\>"
"
"integer number, or floating point number without a dot.
syn match gamsNumber "\<\d\+\>"
"floating point number, with dot
syn match gamsNumber "\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match gamsNumber "\.\d\+\>"
"
"integer number, or floating point number without a dot.
syn match gamsNumber "\<\d\+\>"
"floating point number, with dot
syn match gamsNumber "\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match gamsNumber "\.\d\+\>"
"
"String and Character contstants
syn region gamsString start=+"+ skip=+\\\\\|\\"+ end=+"+
"
"syn match gamsComment "^\*.*$"
syntax match gamsComment "^\*.*"
syntax region gamsComment start="^\$ontext" end="^\$offtext"
syn match gamsMathsOperator "-\|=\|[:<>+\*^/\\]\|AND\|OR"
"
"Define the default highlighting.
"For version 5.7 and earlier: only when not done already
"For version 5.8 and later: only when an item doesn't have
"highlighting yet
if version >= 508 || !exists("did_gams_syntax_inits")
if version < 508
let did_gams_syntax_inits = 1
command -nargs=+ HiLink hi link <args>
else
command -nargs=+ HiLink hi def link <args>
endif
"
HiLink gamsLabel Label
HiLink gamsConditional Conditional
HiLink gamsRepeat Repeat
HiLink gamsLineNumber Comment
HiLink gamsNumber Number
HiLink gamsError Error
HiLink gamsStatement Statement
HiLink gamsString String
HiLink gamsComment Comment
HiLink gamsSpecial Special
HiLink gamsTodo Todo
HiLink gamsFunction Identifier
HiLink gamsTypeSpecifier Type
HiLink gamsFilenumber gamsTypeSpecifier
hi gamsMathsOperator term=bold cterm=bold gui=bold
"
delcommand HiLink
endif
"
let b:current_syntax = "gams"
"
"vim: ts=8
