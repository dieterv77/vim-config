" 
" File:    latex-mik.vim
" Purpose: LaTeX support (MikTeX) for GVIM on Win32-systems 
" Version: 0.6
" Author:  Volker Kiefel <volker dot kiefel at freenet dot de>
"
" Documentation of this script may be found in latex-mik.pdf, source of
" documentation: latex-mik.tex.
"
" For installation, please put this file (latex-mik.vim) into the vim 
" plugin-directory
"
" This script adds a menu for LaTeX-related functions for .tex, .bib-files
"
" Usage:
" To process multiple file LaTeX-projects, enter the project name (e.g.
" ``myproject'') at the prompt, if ``myproject.tex'' is the main file.
"
" Menu options address 
"
"   (pdf)latex
"   bibtex
"   makeindex
"   yap (dvi-viewer)
"   dvips
"   gsview32
"   tth
"
" Latex-mik supports entering commands, environments and BibTeX entries.
"
" This script is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
"
" V0.1: initial upload
" v0.2: unused code removed
" v0.3: BibTeX document type unpublished corrected
" v0.4: Documentation added
" v0.5: Documentation corrected
" v0.6: Environment definitions completed; the most important commands have
"       mapped to `,la' (LaTeXProject) `,vi' (ViewFile) etc.; documentation
"       updated
"


:function! GetProjName()
  let s:projektname = input("Enter project name [default current file]: ")
  if (s:projektname=="" || s:projektname==" ")
   let s:projektname = expand("%:t:r")
  endif
  echo " (".s:projektname.")"
:endfunction

:function! LoadBibLog()
  if exists("s:projektname") == 0
   call GetProjName()
   return
  endif
	let befehl="tabe ".s:projektname.".blg"
	execute(befehl)
:endfunction

:function! LoadLog()
  if exists("s:projektname") == 0
   call GetProjName()
   return
  endif
	let befehl="tabe ".s:projektname.".log"
	execute(befehl)
:endfunction

:function! ExeYap()
  if exists("s:projektname") == 0
   call GetProjName()
   return
  endif
  let s:zlnr=line(".")
if has("gui_running")
  let befehl="silent !start yap -s ".s:zlnr.expand("%:t")." ".s:projektname.".dvi"
else
  let befehl="!yap -s ".s:zlnr.expand("%:t")." ".s:projektname.".dvi &"
endif
  execute(befehl)
:endfunction

:function! ExeLatex()
  if exists("s:projektname") == 0
    call GetProjName()
   return
  endif
if has("gui_running")
  let befehl="silent !latex -src ".s:projektname
else
  let befehl="!latex -src ".s:projektname
endif

  execute(befehl)
:endfunction

:function! ExeTexify()
  if exists("s:projektname") == 0
    call GetProjName()
   return
  endif
  let befehl="silent !texify ".s:projektname.".tex"
  execute(befehl)
:endfunction


:function! Exedvips()
  if exists("s:projektname") == 0
    call GetProjName()
   return
  endif
if has("gui_running")
  let befehl="silent !dvips -t letter ".s:projektname
else
  let befehl="!dvips -t letter ".s:projektname
endif

  execute(befehl)
:endfunction

:function! Exelps()
  if exists("s:projektname") == 0
    call GetProjName()
   return
  endif
if has("gui_running")
  let befehl="silent  !latex -src ".s:projektname
else
  let befehl="!latex -src ".s:projektname
endif
  execute(befehl)
if has("gui_running")
  let befehl="silent !dvips -t letter ".s:projektname
else
  let befehl="!dvips -t letter ".s:projektname
endif
  execute(befehl)
:endfunction

:function! Exexpdf()
  if exists("s:projektname") == 0
    call GetProjName()
   return
  endif
  let befehl="!xpdf ".s:projektname.".pdf &" 
  execute(befehl)
:endfunction

:function! Exegvps()
  if exists("s:projektname") == 0
    call GetProjName()
   return
  endif
if has("gui_running")
  let befehl="!gsview32 ".s:projektname.".ps"
else
  let befehl="!gsview32 ".s:projektname.".ps &"
endif
  execute(befehl)
:endfunction

:function! Exegvpdf()
  if exists("s:projektname") == 0
    call GetProjName()
   return
  endif
if has("gui_running")
  let befehl="silent !start gsview32 ".s:projektname.".pdf"
else
  let befehl="!gsview32 ".s:projektname.".pdf &"
endif
  execute(befehl)
:endfunction

:function! ExePDFLaTeX()
  if exists("s:projektname") == 0
    call GetProjName()
   return
  endif
if has("gui_running")
  let befehl="silent !pdflatex ".s:projektname
else
  let befehl="!pdflatex ".s:projektname
endif
  execute(befehl)
:endfunction

:function! ExeBibtex()
  if exists("s:projektname") == 0
   call GetProjName()
   return
  endif
if has("gui_running")
  let befehl="silent !bibtex ".s:projektname
else
  let befehl="!bibtex ".s:projektname
endif
  execute(befehl)
:endfunction

:function! Exetohtml()
  if exists("s:projektname") == 0
   call GetProjName()
   return
  endif
  let befehl="!tth ".s:projektname.".tex"
  execute(befehl)
:endfunction


:function! ExeMakeindex()
  if exists("s:projektname") == 0
   call GetProjName()
   return
  endif
  let befehl="!makeindex ".s:projektname
  execute(befehl)
:endfunction

:function! Empty_env()
 :let umgebung = input("Enter environment Name: ")
 :if strlen(umgebung) == 0
   :echo "Environment aborted"
   :return
 :elseif umgebung == "itemize" || umgebung == "enumerate"
   :let ausgabe = "\\begin{".umgebung."}\n  \\item \n\\end{".umgebung."}"
   :put!=ausgabe
 :elseif umgebung == "description" 
	:let ausgabe = "\\begin{".umgebung."}\n  \\item[] \n\\end{".umgebung."}"
	:put!=ausgabe
 :elseif umgebung == "minipage"
"   :let envoption = input("Enter minipage type for latex209 or latex2e [209, 2e]: ")
"   :if envoption == "2e"
     :let ausgabe = "\\begin{".umgebung."}[][][]{}\n\n\\end{".umgebung."}"
"   :else
"     :let ausgabe = "\\begin{".umgebung."}[]{}\n\n\\end{".umgebung."}"
"   :endif
   :put!=ausgabe
 :elseif umgebung == "tabular"
   :let ausgabe = "\\begin{".umgebung."}[]{}\n\n\\end{".umgebung."}"
   :put!=ausgabe
 :elseif umgebung == "array"
   :let ausgabe = "\\begin{".umgebung."}[]{}[]\n\n\\end{".umgebung."}"
   :put!=ausgabe
 :elseif umgebung == "table" || umgebung == "figure"
   :let ausgabe = "\\begin{".umgebung."}[]\n\n  \\caption[]{}\n  \\label{}\n\\end{".umgebung."}"
   :put!=ausgabe
 :elseif umgebung == "theorem"
   :let ausgabe = "\\begin{".umgebung."}{}[]\n\n\\end{".umgebung."}"
   :put!=ausgabe
 :else
   :let ausgabe = "\\begin{".umgebung."}\n\n\\end{".umgebung."}"
   :put!=ausgabe
 :endif
 :normal V%=
 :normal j$
:endfunction

:function! Plain_env()
 :if visualmode() != "V"
	:echo "No text highlighted linewise"
	:return
 :endif
 :let umgebung = input("Enter environment Name: ")
 :if strlen(umgebung) == 0
   :echo "Environment aborted"
   :return
 :elseif umgebung == "itemize" || umgebung == "enumerate"
   :let head = "\\begin{".umgebung."}\n  \\item "
   :let tail = "\n\\end{".umgebung."}"
 :elseif umgebung == "description" 
   :let head = "\\begin{".umgebung."}\n  \\item[] "
   :let tail = "\n\\end{".umgebung."}"
 :elseif umgebung == "minipage"
   :let envoption = input("Enter minipage type for latex209 or latex2e [209, 2e]: ")
   :if envoption == "2e"
     :let head = "\\begin{".umgebung."}[][][]{}\n"
     :let tail = "\n\\end{".umgebung."}"
   :else
     :let head = "\\begin{".umgebung."}[]{}\n"
     :let tail = "\n\\end{".umgebung."}"
   :endif
 :elseif umgebung == "tabular"
   :let head = "\\begin{".umgebung."}[]{}\n"
   :let tail = "\n\\end{".umgebung."}"
 :elseif umgebung == "array"
   :let head = "\\begin{".umgebung."}[]{}[]\n"
   :let tail = "\n\\end{".umgebung."}"
 :elseif umgebung == "table" || umgebung == "figure"
   :let head = "\\begin{".umgebung."}[]\n"
   :let tail = "\n  \\caption[]{}\n  \\label{}\n\\end{".umgebung."}"
 :elseif umgebung == "theorem"
   :let head = "\\begin{".umgebung."}{}[]\n"
   :let tail = "\n\\end{".umgebung."}"
 :else
   :let head = "\\begin{".umgebung."}\n"
   :let tail = "\n\\end{".umgebung."}"
 :endif
 :let @m = tail
 :normal `>
 :normal "mp
 :let @m = head
 :normal `<
 :normal "mP
:endfunction

:function! Empty_com()
 :let befehl = input("Enter command Name: ")
 :if strlen(befehl)==0
   :echo "Command aborted"
   :return
 :elseif befehl == "newcommand" || befehl == "renewcommand"
   :let @m = "\\".befehl."{}[]{}"
   :normal "mPhhhh
 :elseif befehl == "multicolumn" 
   :let @m = "\\".befehl."{}{}{}"
   :normal "mPhhhh
 :elseif befehl == "colorbox" || befehl == "textcolor"
   :let @m = "\\".befehl."{}{}"
   :normal "mPhh
 :elseif befehl == "usepackage" ||
     \   befehl == "foilhead" ||
     \   befehl == "includegraphics"
   :let @m = "\\".befehl."[]{}"
   :normal "mPhh
 :elseif befehl == "verb"
   :let @m = "\\".befehl."++"
   :normal "mP
 :else
   :let @m = "\\".befehl."{}"
   :normal "mP
 :endif
:endfunction

:function! Plain_com()
 :if visualmode() != "v"
   :echo "No text highlighted characterwise"
   :return
 :endif
 :let befehl = input("Enter command Name: ")
 :if strlen(befehl)==0
   :echo "Command aborted"
   :return
 :elseif befehl == "newcommand" || befehl == "renewcommand"
   :let head = "\\".befehl."{}[]{"
   :let tail == "}"
 :elseif befehl == "multicolumn" 
   :let head = "\\".befehl."{}{}{"
   :let tail = "}"
 :elseif befehl == "colorbox" || befehl == "textcolor"
   :let head = "\\".befehl."{}{"
   :let tail = "}"
 :elseif befehl == "usepackage" ||
     \   befehl == "foilhead" ||
     \   befehl == "includegraphics"
   :let head = "\\".befehl."[]{"
   :let tail = "}"
 :elseif befehl == "$"
   :let head = "$"
   :let tail = "$"
 :elseif befehl == "\""
   :let head = "\"`"
   :let tail = "\"'"
 :elseif befehl == "'"
   :let head = "``"
   :let tail = "''"
 :elseif befehl == "verb"
   :let head = "\\".befehl."+"
   :let tail = "+"
 :else
   :let head = "\\".befehl."{"
   :let tail = "}"
 :endif
 :let @m = tail
 :normal `>
 :normal "mp
 :let @m = head
 :normal `<
 :normal "mP
:endfunction

:function! LatexUnMenu()
  unmenu &LaTeX
:endfunction

:function! LatexMenu()
menu 8000.5.80  &LaTeX.Blank\ Template             :read C:\cygwin\home\vimfiles\plugin\templates\tex-article.tex<CR>
menu 8000.5.100 &LaTeX.-sep1-                       <nul>
menu 8000.10.010 &LaTeX.BibTeXE&ntry.&Article        i@article{,<cr>author = {},<cr>title = {},<cr>year = {},<cr>journal = {},<cr>OPTpages = {},<cr>OPTvolume = {},<cr>OPTmonth = {},<cr>OPTnumber = {}<cr>}<cr>
menu 8000.10.020 &LaTeX.BibTeXE&ntry.B&ook           i@book{,<cr>ALTauthor = {},<cr>ALTeditor = {},<cr>title = {},<cr>year = {},<cr>publisher = {},<cr>OPTaddress = {},<cr>OPTedition = {}<cr>}<cr>
menu 8000.10.020 &LaTeX.BibTeXE&ntry.Bookle&t        i@booklet{,<cr>ALTauthor = {},<cr>title = {},<cr>OPThowpublished = {},<cr>OPTaddress = {},<cr>OPTyear = {},<cr>OPTmonth = {}<cr>}<cr>
menu 8000.10.030 &LaTeX.BibTeXE&ntry.I&nbook         i@inbook{,<cr>ALTauthor = {},<cr>ALTeditor = {},<cr>title = {},<cr>OPTtype = {},<cr>year = {},<cr>publisher = {},<cr>OPTaddress = {},<cr>ALTpages = {},<cr>ALTchapter = {},<cr>OPTedition = {}<cr>}<cr>
menu 8000.10.040 &LaTeX.BibTeXE&ntry.&Incollection   i@incollection{,<cr>author = {},<cr>OPTeditor = {},<cr>title = {},<cr>booktitle = {},<cr>year = {},<cr>publisher = {},<cr>OPTpages = {},<cr>OPTaddress = {},<cr>OPTedition = {}<cr>}<cr>
menu 8000.10.050 &LaTeX.BibTeXE&ntry.Inproce&edings  i@inproceedings{,<cr>author = {},<cr>title = {},<cr>booktitle = {},<cr>year = {},<cr>OPTeditor = {},<cr>OPTvolume = {},<cr>OPTnumber = {},<cr>OPTnumber = {},<cr>OPTseries = {},<cr>OPTpages = {},<cr>OPTaddress = {},<cr>OPTmonth = {},<cr>OPTorganization = {},<cr>OPTpublisher = {},<cr>OPTnote = {}<cr>}<cr>
menu 8000.10.060 &LaTeX.BibTeXE&ntry.Manua&l         i@manual{,<cr>title = {},<cr>OPTauthor = {},<cr>OPTorganization = {},<cr>OPTaddress = {},<cr>OPTedition = {},<cr>OPTmonth = {},<cr>OPTyear = {},<cr>OPTnote = {}<cr>}<cr>
menu 8000.10.070 &LaTeX.BibTeXE&ntry.Masterst&hesis  i@mastersthesis{,<cr>author = {},<cr>title = {},<cr>school = {},<cr>year = {},<cr>OPTtype = {},<cr>OPTaddress = {},<cr>OPTmonth = {},<cr>OPTnote = {}<cr>}<cr>
menu 8000.10.080 &LaTeX.BibTeXE&ntry.Mi&sc           i@misc{,<cr>OPTauthor = {},<cr>OPTtitle = {},<cr>OPThowpublished = {},<cr>OPTmonth = {},<cr>OPTyear = {},<cr>OPTnote = {}<cr>}<cr>
menu 8000.10.090 &LaTeX.BibTeXE&ntry.&Phdthesis      i@phdthesis{,<cr>author = {},<cr>title = {},<cr>school = {},<cr>year = {},<cr>OPTtype = {},<cr>OPTaddress = {},<cr>OPTmonth = {},<cr>OPTnote = {}<cr>}<cr>
menu 8000.10.100 &LaTeX.BibTeXE&ntry.P&roceedings    i@proceedings{,<cr>title = {},<cr>year = {},<cr>OPTeditor = {},<cr>OPTvolume = {},<cr>OPTnumber = {},<cr>OPTseries = {},<cr>OPTaddress = {},<cr>OPTpublisher = {},<cr>OPTnote = {}<cr>OPTmonth = {},<cr>OPTmonth = {},<cr>OPTorganization = {}<cr>}<cr>
menu 8000.10.110 &LaTeX.BibTeXE&ntry.Te&chreport     i@techreport{,<cr>title = {},<cr>author = {},<cr>institution = {},<cr>year = {},<cr>OPTtype = {},<cr>OPTnumber = {},<cr>OPTaddress = {},<cr>OPTmonth = {},<cr>OPTnote = {}<cr>}<cr>
menu 8000.10.120 &LaTeX.BibTeXE&ntry.&Unpublished    i@unpublished{,<cr>author = {},<cr>title = {},<cr>OPTmonth = {},<cr>OPTyear = {},<cr>note = {}<cr>}<cr>
menu 8000.10.900 &LaTeX.-sep1-                       <nul>
vmenu 8000.20     &LaTeX.&Environment\ on\ Region<tab>,ren    <Esc>:call Plain_env()<cr>
nmenu 8000.22     &LaTeX.Empty\ &Environment<tab>,en          :call Empty_env()<cr>
vmenu 8000.25     &LaTeX.&Commands\ on\ Region<tab>,rcm       <Esc> :call Plain_com()<cr>
nmenu 8000.25     &LaTeX.Empty\ &Commands<tab>,cm             :call Empty_com()<cr>
menu 8000.28.010 &LaTeX.-sep2-  <nul>
menu 8000.58     &LaTeX.&LatexandDvips<tab>,lps     :call Exelps()<cr>
menu 8000.59     &LaTeX.&TeXifyProject<tab>,te       :call ExeTexify()<cr>
menu 8000.60     &LaTeX.&LaTeXProject<tab>,la        :call ExeLatex()<cr>
menu 8000.65     &LaTeX.&BibTeXProject<tab>,bib      :call ExeBibtex()<cr><Space>
menu 8000.84     &LaTeX.&IndexProject                :call ExeMakeindex()<cr><Space>
menu 8000.70     &LaTeX.&ViewFile<tab>,yap            :call ExeYap()<cr>
menu 8000.62     &LaTeX.&PDFLaTeX<tab>,pdf                    :call ExePDFLaTeX()<cr>
menu 8000.63     &LaTeX.&dvips<tab>,ps                       :call Exedvips()<cr><Space>
menu 8000.71     &LaTeX.&gsview\ ps<tab>,gvps                      :call Exegvps()<cr><Space>
menu 8000.72     &LaTeX.&gsview\ pdf<tab>,gvpdf			:call Exegvpdf<cr><Space>
menu 8000.85     &LaTeX.LaTeX\ to\ &HTML             :call Exetohtml()<cr><Space>
menu 8000.66     &LaTeX.-sep4-                       <nul>
menu 8000.90     &LaTeX.Projec&tname<tab>,pr      :call GetProjName()<cr>
menu 8000.92     &LaTeX.LoadLog<tab>,log  			:call LoadLog()<cr>
menu 8000.95     &LaTeX.LoadBibLog<tab>,blg  			:call LoadBibLog()<cr>
:endfunction

:function! LatexUnMap()
  unmap ,gvps
  unmap ,gvpdf
  unmap ,lps
  unmap ,bib
  unmap ,pdf
  unmap ,xpdf
  unmap ,ps
  unmap ,la
  unmap ,yap
  unmap ,te
  unmap ,pr
  vunmap ,ren
  unmap ,en
  vunmap ,rcm
  unmap ,cm
  unmap ,cl
:endfunction


:function! LatexMap()
  map ,gvps     :call Exegvps()<cr>
  map ,gvpdf   :call Exegvpdf()<cr>
  map ,lps   :call Exelps()<cr>
  map ,bib    :call ExeBibtex()<cr>
  map ,pdf    :call ExePDFLaTeX()<cr>
  map ,xpdf   :call Exexpdf()<cr> 
  map ,ps     :call Exedvips()<cr>
  map ,la     :call ExeLatex()<cr>
  map ,yap     :call ExeYap()<cr>
  map ,te     :call ExeTexify()<cr>
  map ,pr    :call GetProjName()<cr>
  vmap ,ren <Esc>:call Plain_env()<cr>
  map ,en   :call Empty_env()<cr>
  vmap ,rcm  <Esc> :call Plain_com()<cr>
  map ,cm   :call Empty_com()<cr>
  map ,cl  <Esc>72i%<Esc>
  map ,log  :call LoadLog()<cr>
  map ,blg  :call LoadBibLog()<cr>
:endfunction
