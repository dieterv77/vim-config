syntax on
if exists("did_indent_on")
  finish
endif
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
set autowrite
set showcmd


"Set font for gui
set guifont=Lucida_Console:h11:cANSI

"Setting for enhanced commentify
let g:EnhCommentifyUserBindings='yes'
let g:EnhCommentifyMultiPartBlocks='yes'

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
	colo default 
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

"Mapping to move between tabs
nnoremap <C-j> :tabp<CR>
nnoremap <C-k> :tabn<CR>

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
vnoremap <F11> :w! ~/.vim/vimcp<CR>
noremap <F12> :.r ~/.vim/vimcp<CR>

"Tab should do tab completion if possible
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

"Set folding for header files to 2 levels (because of namespace brackets)
au BufNewFile,BufRead *.h   setlocal foldnestmax=2

"Fold xml files
let g:xml_syntax_folding = 1

"Set mapleader to ,
let mapleader=','

"Set taglist stuff
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Auto_Highlight_Tag=0
let Tlist_Highlight_Tag_On_BufEnter=0
let Tlist_Show_One_File=1
let Tlist_Sort_Type="name"
let Tlist_Enable_Fold_Column=0
