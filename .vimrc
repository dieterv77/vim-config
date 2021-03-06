"Set mapleader to ,
let mapleader=","
let maplocalleader=","

execute pathogen#infect()

syntax on
if exists("did_indent_on")
  finish
endif

nmap <Leader>s :set softtabstop=3 shiftwidth=3<CR>
set softtabstop=3
set shiftwidth=3
filetype plugin indent on
set backspace=eol,start,indent
set whichwrap=h,l,<,>,[,]
filetype plugin on
set showmatch
set expandtab
set linebreak
set incsearch
set nohlsearch
set autowriteall
set showcmd
set modeline

set hidden

set cino=t0,(0,W1s

"Set font for gui
"set guifont=Lucida_Console:h11:cANSI
set guifont="Monospace 11"

"Setting for enhanced commentify
let g:EnhCommentifyUserBindings='yes'
let g:EnhCommentifyMultiPartBlocks='yes'
let g:EnhCommentifyRespectIndent = 'yes'
let g:EnhCommentifyPretty = 'yes'

"Some latex stuff
let g:tex_flavor = 'latex' "Do this to ensure filetype is latex, not plaintex
let g:tex_indent_items = 1

"Some spelling stuff
set mousemodel=popup_setpos
set spelllang=en_us
set spellfile=mywords.latin1.add

if has("gui_running")
	colo morning
else
	colo dieter 
endif

"Define statusline stuff
:set statusline====\ %<%f\ ===\ %h%m%r%=%-14.(%l,%c%V%)\ %P
:set laststatus=2


"Mapping to open filename under cursor
map gf :e <cfile><CR>


"menus for non-gui case
if !(has("gui_running"))
	source $VIMRUNTIME/menu.vim
	set wildmenu
	set cpo-=<
	set wcm=<C-Z>
	map <F4> :emenu <C-Z>
endif

if has("win32")
   set shell=C:\\Windows\\system32\\cmd.exe
endif

"Mapping to move between tabs
nnoremap <C-j> :tabp<CR>
nnoremap <C-k> :tabn<CR>

"Mapping to open and close folds
nn - zc
nn + zo

"Don't match parenthesis with highlighting
let loaded_matchparen = 1

"Set omnicompletion based on syntax
if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
				\	if &omnifunc == "" |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
endif

"Set up some commands to do copying between vimsessions
if has("win32")
   vnoremap <F11> :w! C:\cygwin\home\dvandenbussche\vimfiles\vimcp<CR>
   noremap <F12> :.r C:\cygwin\home\dvandenbussche\vimfiles\vimcp<CR>
else
   vnoremap <F11> :w! ~/.vim/vimcp<CR>
   noremap <F12> :.r ~/.vim/vimcp<CR>
endif


"Set folding for header files to 2 levels (because of namespace brackets)
au BufNewFile,BufRead *.h   setlocal foldnestmax=2

"Fold xml files
"Turn this on if you don't want the ftplugin to ask you
"let g:xml_syntax_folding = 1
"Making this empty ensures that we don't use the tag completion
"mapping from xml-plugin
let xml_tag_completion_map = "" 

"Set taglist stuff
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Auto_Highlight_Tag=0
let Tlist_Highlight_Tag_On_BufEnter=0
let Tlist_Show_One_File=1
let Tlist_Sort_Type="name"
let Tlist_Enable_Fold_Column=0

"Set pastetoggle to F10
set pastetoggle=<F10>

"Set default ctags key
map <F7> :!ctags -R .<CR>

"Set map to start bufexplorer (besides the <Leader>be)
map <F6> :BufExplorer<CR>

if has("win32")
   let g:myvimpath = 'vimfiles'
   set makeprg=nmake\ /f\ Makefile.Windows
else
   let g:myvimpath = '.vim'
   set makeprg=make\ -f\ Makefile.Linux
endif

autocmd BufRead,BufNewFile *.txt,README,TODO,CHANGELOG,NOTES
        \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2
        \ textwidth=70 wrap formatoptions=tcqn
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif
 au BufReadPost svn-commit.* exe "normal! gg"
endif

let g:EclimLargeFileSize = 10

" Override surround mappings
let g:surround_no_mappings=1
vmap <Leader>s <Plug>Vsurround
vmap <Leader>S <Plug>VSurround
nmap <Leader>sd   <Plug>Dsurround
nmap <Leader>sc   <Plug>Csurround

" Mapping for alternate functionality
nmap <Leader>an :A<CR>
nmap <Leader>as :AS<CR>
nmap <Leader>av :AV<CR>

" Supertab settings
" let g:SuperTabDefaultCompletionType = "context"

" vim-ipython settings
let g:ipy_completefunc = 'local'
