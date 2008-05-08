" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn case match

syntax match mosekComment /#.*/
syntax match mosekString /'.\{-}'/

syn match   mosekTagName
    \ +\(\[/\=\)\@<=.\{-}[ \]]\@=+
    \ contained



" start tag
syn region   mosekTag
         \ matchgroup=Operator start=+\[+
         \ matchgroup=Operator end=+\]+
         \ contained
         \ contains=mosekTagName,mosekString


" highlight the end tag
syn region   mosekEndTag
         \ matchgroup=Operator start=+\[/+
         \ matchgroup=Operator end=+\]+
         \ contained
         \ contains=mosekTagName


" tag elements with syntax-folding.
syn region   mosekRegion
         \ start=+\[\w.\{-}\]+
         \ end=+\[/\w.\{-}\]+
         \ contains=mosekTag,mosekEndTag,mosekRegion,mosekComment,mosekString
         \ fold
         \ extend
         \ keepend

syn sync fromstart
set foldmethod=syntax

highlight link mosekKeywords Type
highlight link mosekComment Comment
highlight link mosekTag Tag
highlight link mosekEndTag Tag
highlight link mosekString String
highlight link mosekTagName Identifier



let b:current_syntax = "mosek"

" vim: ts=8
