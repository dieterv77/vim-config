"include auctex rippoff
so $HOME/vimfiles/samauctex.vim
"Include folding file stolen from latex-suite
so $HOME/vimfiles/fold/tex-folding.vim
"Start from first line, otherwise folding not quite right
"Create actual folds
call MakeTexFolds(0)
"Set map to redo folds
map ,rf  :call MakeTexFolds(1)<cr>
"Set typing textwidth
set textwidth=72
"Add tex words to dictionary
set dictionary+=$HOME/vimfiles/wordlists/tex-dict.list
set complete+=k
call LatexMenu()
call LatexMap()

set spell
