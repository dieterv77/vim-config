syntax clear javaBraces
syntax clear javaDocComment

syn region javaBraces start="{" end="}" transparent fold
syn region javaDocComment start="/\*\*" end="\*/" keepend contains=javaCommentTitle,@javaHtml,javaDocTags,javaDocSeeTag,javaTodo,@Spell fold

set foldmethod=syntax
set foldnestmax=2
syn sync fromstart
setlocal foldcolumn=2
