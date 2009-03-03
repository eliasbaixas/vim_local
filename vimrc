"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          _
"      __ | \
"     /   | /
"     \__ | \
" by Amix - http://amix.dk/
"
" Maintainer:	Amir Salihefendic <amix3k at gmail.com>
" Version: 2.8
" Last Change: 26/10/06 17:44:17
"
" Sections:
" ----------------------
"   *> General
"   *> Colors and Fonts
"   *> Fileformats
"   *> VIM userinterface
"   ------ *> Statusline
"   *> Visual
"   *> Moving around and tabs
"   *> General Autocommands
"   *> Parenthesis/bracket expanding
"   *> General Abbrevs
"   *> Editing mappings etc.
"   *> Command-line config
"   *> Buffer realted
"   *> Files and backups
"   *> Folding
"   *> Text options
"   ------ *> Indent
"   *> Spell checking
"   *> Plugin configuration
"   ------ *> Yank ring
"   ------ *> File explorer
"   ------ *> Minibuffer
"   ------ *> Tag list (ctags) - not used
"   ------ *> LaTeX Suite things
"   *> Filetype generic
"   ------ *> Todo
"   ------ *> VIM
"   ------ *> HTML related
"   ------ *> Ruby & PHP section
"   ------ *> Python section
"   ------ *> Cheetah section
"   ------ *> Vim section
"   ------ *> Java section
"   ------ *> JavaScript section
"   ------ *> C mappings
"   ------ *> SML
"   ------ *> Scheme bindings
"   *> Snippets
"   ------ *> Python
"   ------ *> javaScript
"   *> Cope
"   *> MISC
"
"  Tip:
"   If you find anything that you can't understand than do this:
"   help keyword OR helpgrep keywords
"  Example:
"   Go into command-line mode and type helpgrep nocompatible, ie.
"   :helpgrep nocompatible
"   then press <leader>c to see the results, or :botright cw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible

"Sets how many lines of history VIM har to remember
set history=500

"Enable filetype plugin
filetype plugin on
filetype indent on

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time:
"set mouse=a

"Set mapleader
let mapleader = ","
let maplocalleader=","
let g:mapleader = ","

"Fast saving
nmap <leader>w :w!<cr>

" HighLight or de-HighLight last search
nmap <Leader>hl :set hls!<bar>set hls?<cr>

"Fast reloading of the .vimrc
map <leader>s :source ~/vim_local/vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/vim_local/vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/vim_local/vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable

"Set font to Monaco 10pt
if MySys() == "mac"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h13
  set shell=/bin/bash
elseif MySys() == "windows"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
  set gfn=Monospace\ 10
  set shell=/bin/bash
endif
if has("gui_running")
  set guioptions-=T
  "set guioptions-=e
  set background=dark
  let psc_style='cool'
  colorscheme ps_color
else
  colorscheme ron
endif

set encoding=utf8

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=cheetah<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

autocmd BufEnter * :syntax sync fromstart

"Highlight current
if has("gui_running")
  set cursorline
endif

"Omni menu colors
hi Pmenu guibg=#1a293f
hi PmenuSel guibg=#54657d guifg=#ffffff

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=5

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

" the way the selection works
set selection=inclusive 

" show currently writed command in N mode
set showcmd

"The commandbar is 2 high
set cmdheight=2

"Show line number
" set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set smartcase   " don't ignore case for searching for strings containing UpCase letters
set nohlsearch  " do not highlight all found matches
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

" When switching buffers, remember history/undo even when not saved
set hidden

" I'm human, be nice to me, please
set confirm

" Include only one space when joining rows
set nojoinspaces 

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch

  """"""""""""""""""""""""""""""
  " => Statusline
  """"""""""""""""""""""""""""""
  "Always hide the statusline
  set laststatus=2

  function! CurDir()
     let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
     return curdir
  endfunction

  "Format the statusline
  set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


""""""""""""""""""""""""""""""
" => Visual
""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /
map <c-space> ?

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrows
"Bclose function ca be found in "Buffer related" section
map <leader>bd :Bclose<cr>
"Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i

" Moving on long lines
noremap <Up> g<Up>
noremap <Down> g<Down>
noremap k gk
noremap j gj
inoremap <Up> <C-o>g<Up>
inoremap <Down> <C-o>g<Down>

""""""""""""""""""""""""""""""""""""""""""""
" Filename Completetion
""""""""""""""""""""""""""""""""""""""""""""
set wildchar=<Tab>
set wildmenu
set wildmode=longest:full,full

""""""""""""""""""""""""""""""""""""""""""""
" Restore screen on vim exit
""""""""""""""""""""""""""""""""""""""""""""
set t_ti=7[?47h
set t_te=[2J[?47l8

""""""""""""""""""""""""""""""""""""""""""""
" Long lines
""""""""""""""""""""""""""""""""""""""""""""
set linebreak		 " wrap line at whitespace
set showbreak=+  " and show me that the line is continuing from previous line
set display=lastline " don't show us ugly @@@@@@@@@@ when line too long on screen 
" Move freely on long lines wrapped around the screen

" Usually I'm using macro 'a', so here's shortcut for it's invocation
nmap <F11> @a
nmap <F9> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR> :!cscope -b -i cscope.files -f cscope.out<CR> :cs reset<CR>
map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
map <F6> ebyw:cs f t "<CR>
map <F5> ebyw:cs f c "<CR>
map [1;3C :bn<CR>
map [1;3D :bp<CR>
map  :bn<CR>
map  :bp<CR>
map  :cn<CR>
map  :redo<CR>
map  :cp<CR>
map  :q<CR>
map  :bd<CR>
"map  :redo<CR>
map [[ ?{w99[{
map ][ /}b99]}
map ]] j0[[%/{
map [] k$][%?}
"map gd /[^a-zA-Z_]<CR>byn[[/\<"\><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $e ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i

imap <m-l> <esc>:exec "normal f" . leavechar<cr>a
imap <d-l> <esc>:exec "normal f" . leavechar<cr>a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My information
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xname Amir Salihefendic
iab cancle cancel
iab Cancle Cancel
iab xcabo  //XXX: Cabo



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<cr>

cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $tc <C-\>eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
map <c-q> :sb 

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

" Buffer - reverse everything ... :)
map <F9> ggVGg?

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set nofen
set fdl=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4

map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>

set smarttab
set lbr
set tw=500

   """"""""""""""""""""""""""""""
   " => Indent
   """"""""""""""""""""""""""""""
   "Auto indent
   set ai

   "Smart indet
   set si

   "C-style indeting
   "set cindent

   "Wrap lines
   set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   " => Vim Grep
   """"""""""""""""""""""""""""""
   let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
   set grepprg=/bin/grep\ -nH

   """"""""""""""""""""""""""""""
   " => Yank Ring
   """"""""""""""""""""""""""""""
   map <leader>y :YRShow<cr>
   let g:yankring_persist = 0

   """"""""""""""""""""""""""""""
   " => File explorer
   """"""""""""""""""""""""""""""
   "Split vertically
   let g:explVertical=1

   "Window size
   let g:explWinSize=35

   let g:explSplitLeft=1
   let g:explSplitBelow=1

   "Hide some files
   let g:explHideFiles='^\.,.*\.class$,.*\.swp$,.*\.pyc$,.*\.swo$,\.DS_Store$'

   "Hide the help thing..
   let g:explDetailedHelp=0


   """"""""""""""""""""""""""""""
   " => Minibuffer
   """"""""""""""""""""""""""""""
   let g:miniBufExplModSelTarget = 1
   let g:miniBufExplorerMoreThanOne = 2
   let g:miniBufExplModSelTarget = 0
   let g:miniBufExplUseSingleClick = 1
   let g:miniBufExplMapWindowNavVim = 1
   let g:miniBufExplVSplit = 25
   let g:miniBufExplSplitBelow=1

   let g:bufExplorerSortBy = "name"

   autocmd BufRead,BufNew :call UMiniBufExplorer
   
   map <leader>u :TMiniBufExplorer<cr>:TMiniBufExplorer<cr>


   """"""""""""""""""""""""""""""
   " => Tag list (ctags) - not used
   """"""""""""""""""""""""""""""
   let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
   let Tlist_WinWidth = 50

   map <F5> :TlistToggle<cr>
   map <F8> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


   """"""""""""""""""""""""""""""
   " => LaTeX Suite things
   """"""""""""""""""""""""""""""
   let g:Tex_DefaultTargetFormat="pdf"
   let g:Tex_ViewRule_pdf='xpdf'

   "Bindings
   autocmd FileType tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

   "Auto complete some things ;)
   autocmd FileType tex inoremap $i \indent 
   autocmd FileType tex inoremap $* \cdot 
   autocmd FileType tex inoremap $i \item 
   autocmd FileType tex inoremap $m \[<cr>\]<esc>O


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " => Set Omni complete functions
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   autocmd FileType css set omnifunc=csscomplete#CompleteCSS

   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " => Todo
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim
   au BufNewFile,BufRead *.mako set ft=mako

   """"""""""""""""""""""""""""""
   " => VIM
   """"""""""""""""""""""""""""""
   autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>
   

   """"""""""""""""""""""""""""""
   " => HTML related
   """"""""""""""""""""""""""""""
   " HTML entities - used by xml edit plugin
   let xml_use_xhtml = 1
   "let xml_no_auto_nesting = 1

   " two xml pretty-printers
   command XMLTidy %!tidy -q -i -xml
   command XMLLint %!xmllint --format - 2>&1


   "To HTML
   let html_use_css = 1
   let html_number_lines = 0
   let use_xhtml = 1


   """"""""""""""""""""""""""""""
   " => Ruby & PHP section
   """"""""""""""""""""""""""""""
   autocmd FileType ruby map <buffer> <leader><space> :w!<cr>:!ruby %<cr>
   autocmd FileType php compiler php
   autocmd FileType php map <buffer> <leader><space> <leader>cd:w<cr>:make %<cr>

   filetype plugin on
   autocmd FileType cpp call Prepare_for_c() 
   autocmd FileType c call Prepare_for_c()
   autocmd FileType po call Prepare_for_po() 
   autocmd FileType tex call Prepare_for_tex()
   autocmd FileType pov call Prepare_for_pov()
   autocmd FileType perl call Prepare_for_perl()
   autocmd FileType sh call Prepare_for_sh()
   autocmd FileType php call Prepare_for_phphtml()
   autocmd FileType html call Prepare_for_phphtml()
   autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
   au BufNewFile,BufRead *.cfg   call s:cfgType()
   au FileType,BufNewFile,BufRead *.rl setf ragel

   function Prepare_for_phphtml()
   set tabstop=3
   set shiftwidth=3
   set cindent
   endfunction

   function Prepare_for_sh()
   set tabstop=3
   set shiftwidth=3
   set autoindent
   endfunction

   function Prepare_for_perl()
   set textwidth=78
   set shiftwidth=3
   set tabstop=3
   set cindent
   hi Comment ctermfg=Green
   set formatoptions=cq
   iab usrbinperl #!/usr/bin/perl<CR><CR>use strict;<CR><CR>
   endfunction

   function Prepare_for_c()
       "set tabstop=3
       set sts=4
       set ts=8
       set shiftwidth=3
       set cindent
       "	set formatoptions=croql
       ab #i #include <><LEFT>
       ab #I #include ""<LEFT>
       ab #d #define
       iab printf( printf("\n");<LEFT><LEFT><LEFT><LEFT><LEFT>
       iab while( while () {<CR>}<UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
       iab for( for (;;) {<CR>}<UP><RIGHT><RIGHT><RIGHT><RIGHT>
       iab if( if () {<CR>}<UP><RIGHT><RIGHT><RIGHT>
       iab elsif if () {<CR>} else {<CR>}<UP><UP><RIGHT><RIGHT><RIGHT>
       iab intmain int main (int argc, char **argv) {<CR>return 0;<CR>}<UP>
       iab /*/ /*<CR><HOME> *	func() - desc<CR><HOME> *		 returns ...<CR><HOME> *<CR><HOME> *	param: desc<CR><HOME> */<CR>
       "  Tohle se moc nepovedlo
       "  exec ":command! -range Comment :execute \"normal <esc><esc>i/*<esc>gv<esc><esc>lla*/<esc>\""
       nmap <Leader>s :A<CR>
       nmap <Leader>doc i/**<CR><BS>* function_name:<CR>* @param1: desc<CR>*<CR>* function description<CR>*<CR>* Returns: what<CR>*/<CR><ESC>?function_name<CR>
   endfunction

   function Prepare_for_tex()
       set makeprg=cslatex\ %
   endfunction

   function Prepare_for_po()
       set makeprg=msgfmt\ -c\ -o\ /dev/null\ -vv\ %
       autocmd BufWritePre,FileWritePre * ks|call PO_date()|'s
       nmap <F9> :make<CR>
       nmap <F8> :ks<CR>:w<CR>:call PO_spell()<CR>:'s<CR>
       "  nmap <F4> j0wDk0wv$hyj$pj
       " replace msgstr with msgid
       " <F4> should copy field #msgstr to field #msgdst
       nmap <F4> j?^#<CR>/^msgid<CR>V/^msgstr<CR>kY/^msgstr<CR>P/^msgstr<CR>V/^$<CR>kd?^msgid<CR>dwimsgstr <esc>
       imap <F10> "\n"<CR>
       nmap <C-I> j?^#<CR>/^msgstr<CR>wa
   endfunction

   function Prepare_for_pov()
       set cinoptions=s,e0,n0,f0,{0,}0,^0,:s,=s,ps,ts,c3,+0,(2s,us,)20,*30,gs,hs
       set shiftwidth=2
       set cinkeys=0{,0},!^F,o,O,*<Return>
       set cinwords=#while,else
       set autoindent
       set nosmartindent
       set cindent
       "  set makeprg=povray\ +I\ %\ +D\ +P
       exec "command! Help :execute '!links ~/bin/povray31/html/povuser.htm'"
   endfunction

   function PO_spell()
       execute "normal :w"
       let file=bufname(winbufnr(winnr()))
       let command="pospell -n ".file." -p ispell -- -d czech -p ~/po_dictionary.ispell \\%f"
       execute (system (command))
       execute "normal :e\<CR>\<C-l>"
   endfunction

   function PO_date()
       if line("$") > 30
           let l = 30
       else
           let l = line("$")
       endif
       exe "1,".l."g/PO-Revision-Date/s/PO-Revision-Date.*/PO-Revision-Date: ".strftime('%Y-%m-%d %H:%M%z').'\\n"'
       exe "1,".l."g/Last-Translator/s/Last-Translator.*/Last-Translator: Vladimír Marek <vlmarek@volny.cz>".'\\n"'
   endfunction

   augroup gzip
       autocmd!
       autocmd BufReadPre,FileReadPre	*.gz set bin
       autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
       autocmd BufReadPost,FileReadPost	*.gz set nobin
       autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")
       autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
       autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

       autocmd FileAppendPre		*.gz !gunzip <afile>
       autocmd FileAppendPre		*.gz !mv <afile>:r <afile>
       autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
       autocmd FileAppendPost		*.gz !gzip <afile>:r
   augroup END

   function GetPerlFold()
       if getline(v:lnum) =~ '^\s*sub\s'
           return ">1"
       elseif getline(v:lnum) =~ '\}\s*$'
           let my_perlnum = v:lnum
           let my_perlmax = line("$")
           while (1)
               let my_perlnum = my_perlnum + 1
               if my_perlnum > my_perlmax
                   return "<1"
               endif
               let my_perldata = getline(my_perlnum)
               if my_perldata =~ '^\s*\(\#.*\)\?$'
                   " do nothing
               elseif my_perldata =~ '^\s*sub\s'
                   return "<1"
               else
                   return "="
               endif
           endwhile
       else
           return "="
       endif
   endfunction

   func! s:cfgType()
       let max = line("$") > 50 ? 50 : line("$")
       for n in range(1, max)
           if getline(n) =~ '^\s*modparam\s*('
               setf openser
               return
           elseif getline(n) =~ '^\s*loadmodule\s*"[^"]\+.so"\s*$'
               setf openser
               return
           elseif getline(n) =~ '^\s*route\s*{\s*'
               setf openser
               return
           endif
       endfor
       setf cfg
   endfunc 


   """"""""""""""""""""""""""""""
   " => Python section
   """"""""""""""""""""""""""""""
   "Run the current buffer in python - ie. on leader+space
   "au FileType python so ~/vim_local/syntax/python.vim

   "Python iMaps
   au FileType python set nocindent
   au FileType python inoremap <buffer> $r return 
   au FileType python inoremap <buffer> $i import 
   au FileType python inoremap <buffer> $p print 
   au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi

   au BufNewFile,BufRead *.jinja set syntax=htmljinja
   syn keyword pythonConstant True None False self

   au FileType python map <leader>C ?class 
   au FileType python map <leader>D ?def 


   """"""""""""""""""""""""""""""
   " => Cheetah section
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah set ft=xml
   autocmd FileType cheetah set syntax=cheetah

   """""""""""""""""""""""""""""""
   " => Vim section
   """""""""""""""""""""""""""""""
   autocmd FileType vim set nofen

   """""""""""""""""""""""""""""""
   " => Java section
   """""""""""""""""""""""""""""""
   au FileType java inoremap <buffer> <C-t> System.out.println();<esc>hi

   "Java comments
   autocmd FileType java source ~/vim_local/macros/jcommenter.vim
   autocmd FileType java let b:jcommenter_class_author='Amir Salihefendic (amix@amix.dk)'
   autocmd FileType java let b:jcommenter_file_author='Amir Salihefendic (amix@amix.dk)'
   autocmd FileType java map <buffer> <F2> :call JCommentWriter()<cr>

   "Abbr'z
   autocmd FileType java inoremap <buffer> $pr private 
   autocmd FileType java inoremap <buffer> $r return 
   autocmd FileType java inoremap <buffer> $pu public 
   autocmd FileType java inoremap <buffer> $i import 
   autocmd FileType java inoremap <buffer> $b boolean 
   autocmd FileType java inoremap <buffer> $v void 
   autocmd FileType java inoremap <buffer> $s String 

   "Folding
   function! JavaFold() 
     setl foldmethod=syntax
     setl foldlevelstart=1
     syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
     syn match foldImports /\(\n\?import.\+;\n\)\+/ transparent fold

     function! FoldText()
       return substitute(getline(v:foldstart), '{.*', '{...}', '')
     endfunction
     setl foldtext=FoldText()
   endfunction
   au FileType java call JavaFold()
   au FileType java setl fen

   au BufEnter *.sablecc,*.scc set ft=sablecc
   au BufEnter *.peep set ft=peephole
   au Syntax peephole so ~/vim_local/syntax/peephole.vim

   "Eclim
   let g:EclimPath = "/Applications/eclipse/plugins/org.eclim_1.2.3/bin/eclim"


   """"""""""""""""""""""""""""""
   " => JavaScript section
   """""""""""""""""""""""""""""""
   au FileType javascript so ~/vim_local/syntax/javascript.vim
   function! JavaScriptFold() 
     setl foldmethod=syntax
     setl foldlevelstart=1
     syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

     function! FoldText()
       return substitute(getline(v:foldstart), '{.*', '{...}', '')
     endfunction
     setl foldtext=FoldText()
   endfunction
   au FileType javascript call JavaScriptFold()
   au FileType javascript setl fen

   au FileType javascript imap <c-t> AJS.log();<esc>hi
   au FileType javascript imap <c-a> alert();<esc>hi
   au FileType javascript setl nocindent
   au FileType javascript inoremap <buffer> $r return 

   au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi
   au FileType javascript,*.htm,cheetah inoremap <buffer> $a AJS.


   """"""""""""""""""""""""""""""
   " => HTML
   """""""""""""""""""""""""""""""
   au FileType html,cheetah set ft=xml
   au FileType html,cheetah set syntax=html


   """"""""""""""""""""""""""""""
   " => C mappings
   """""""""""""""""""""""""""""""
   autocmd FileType c map <buffer> <leader><space> :w<cr>:!gcc %<cr>


   """""""""""""""""""""""""""""""
   " => SML
   """""""""""""""""""""""""""""""
   autocmd FileType sml map <silent> <buffer> <leader><space> <leader>cd:w<cr>:!sml %<cr>


   """"""""""""""""""""""""""""""
   " => Scheme bidings
   """"""""""""""""""""""""""""""
   autocmd BufNewFile,BufRead *.scm map <buffer> <leader><space> <leader>cd:w<cr>:!petite %<cr>
   autocmd BufNewFile,BufRead *.scm inoremap <buffer> <C-t> (pretty-print )<esc>i
   autocmd BufNewFile,BufRead *.scm vnoremap <C-t> <esc>`>a)<esc>`<i(pretty-print <esc>


""""""""""""""""""""""""""""""
" => Snippets
"""""""""""""""""""""""""""""""
   "You can use <c-j> to goto the next <++> - it is pretty smart ;)

   """""""""""""""""""""""""""""""
   " => Python
   """""""""""""""""""""""""""""""
   autocmd FileType python inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("def <++>(<++>):\n<++>\nreturn <++>")<cr>
   autocmd FileType python inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for <++> in <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>\nelse:\n<++>")<cr>


   """""""""""""""""""""""""""""""
   " => JavaScript
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah,html,javascript inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("function <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr>
   autocmd filetype cheetah,html,javascript inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for(<++>; <++>; <++>) {\n<++>;\n}")<cr>
   autocmd FileType cheetah,html,javascript inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}")<cr>
   autocmd FileType cheetah,html,javascript inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}\nelse {\n<++>;\n}")<cr>
   autocmd FileType cheetah,html,javascript inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("<++> = new AJS.Class({\ninit: function(<++>) {\n<++>\n}<++>\n});")<cr>


   """""""""""""""""""""""""""""""
   " => HTML
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah,html inorea <buffer> cahref <c-r>=IMAP_PutTextWithMovement('<a href="<++>"><++></a>')<cr>
   autocmd FileType cheetah,html inorea <buffer> cbold <c-r>=IMAP_PutTextWithMovement('<b><++></b>')<cr>
   autocmd FileType cheetah,html inorea <buffer> cimg <c-r>=IMAP_PutTextWithMovement('<img src="<++>" alt="<++>" />')<cr>
   autocmd FileType cheetah,html inorea <buffer> cpara <c-r>=IMAP_PutTextWithMovement('<p><++></p>')<cr>
   autocmd FileType cheetah,html inorea <buffer> ctag <c-r>=IMAP_PutTextWithMovement('<<++>><++></<++>>')<cr>
   autocmd FileType cheetah,html inorea <buffer> ctag1 <c-r>=IMAP_PutTextWithMovement("<<++>><cr><++><cr></<++>>")<cr>


   """""""""""""""""""""""""""""""
   " => Java
   """""""""""""""""""""""""""""""
   autocmd FileType java inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("public<++> <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr> 
   autocmd FileType java inorea <buffer> cfunpr <c-r>=IMAP_PutTextWithMovement("private<++> <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr> 
   autocmd FileType java inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for(<++>; <++>; <++>) {\n<++>;\n}")<cr> 
   autocmd FileType java inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}")<cr> 
   autocmd FileType java inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}\nelse {\n<++>;\n}")<cr>
   autocmd FileType java inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++> <++> {\n<++>\n}")<cr>
   autocmd FileType java inorea <buffer> cmain <c-r>=IMAP_PutTextWithMovement("public static void main(String[] argv) {\n<++>\n}")<cr>
   

   "Presse c-q insted of space (or other key) to complete the snippet
   imap <C-q> <C-]>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"For Cope
map <silent> <leader><cr> :noh<cr>

"Orginal for all
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"A function that inserts links & anchors on a TOhtml export.
" Notice:
" Syntax used is:
"   *> Link
"   => Anchor
function! SmartTOHtml()
   TOhtml
   try
    %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
    %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
    %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
   catch
   endtry
   exe ":write!"
   exe ":bd"
endfunction

function! DateToUTC()
    %s/setDate/setUTCDate/g
    %s/setMonth/setUTCMonth/g
    %s/setFullYear/setUTCFullYear/g
    %s/setHours/setUTCHours/g
    %s/setMinute/setUTCMinute/g
    %s/setSecond/setUTCSecond/g

    %s/getDate/getUTCDate/g
    %s/getMonth/getUTCMonth/g
    %s/getFullYear/getUTCFullYear/g
    %s/getHours/getUTCHours/g
    %s/getMinute/getUTCMinute/g
    %s/getSecond/getUTCSecond/g
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Zimbra
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ZimbraServer()
    exe "cd ~/Desktop/Zimbra/zimbra/trunk/branches/FRANK/ZimbraServer"
endfunction

function! ZimbraClient()
    exe "cd ~/Desktop/Zimbra/zimbra/trunk/branches/FRANK/ZimbraWebClient"
endfunction

map z1 :call ZimbraClient()<cr>
map z2 :call ZimbraServer()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guitablabel=%N\ %m\ %t

map ½ $
imap ½ $
vmap ½ $
cmap ½ $
