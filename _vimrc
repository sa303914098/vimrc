"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Owner:	Donson - http://www.donsonx.com
" Modified: 2010-08-03 10:57:29
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set runtimepath=~/vim,$VIMRUNTIME
" source ~/vim/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors & Fonts & Syntax
"    -> Set FileEncodeing
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Shortcuts Mapping
"    -> Statusline
"    -> Moving around, tabs and buffers
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> General Abbrevs
"    -> Editing mappings
"
"    -> Plugin Settings
"    -> Set OminComplete
"    -> JavaScript section
"
" Get out of VI's compatible mode..
set nocompatible
if v:version < 700
    echoerr 'This vimrc requires Vim 7 or later.'
    finish
endif

if has("win32")
    let $VIMFILES = $VIM.'/vimfiles'
    let $VIMRC = $VIM.'/_vimrc'
else
    let $VIMFILES = $HOME.'/.vim'
    let $VIMRC = $HOME.'/.vimrc'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=800

" Enable pathogen
call pathogen#runtime_append_all_bundles()

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source $VIMRC

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7
set wildmenu "Turn on WiLd menu
set wildmode=longest,full
set wildignore=*.bak,*.o,*.e,*~,*.pyc,*.svn
set ruler "Always show current position
set cmdheight=2 "The commandbar height
set hidden "Change buffer - without saving
set number " Show line number
" Do not redraw, when running macros.. lazyredraw
set lazyredraw
" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase "Ignore case when searching
set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set magic "Set magic on, for regular expressions
set showmatch "Show matching bracets when text indicator is over them
set showfulltag
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Make GUI File Open use current directory
set browsedir=buffer
" Have the mouse enabled all the time:
set mouse=a
" show incomplete commands
set showcmd
" Always switch to the current file directory
"set autochdir
"Set the terminal title
set title
let &titleold=getcwd()
" Don't break the words with following character
set iskeyword+=_,$,@,%,#,- et title

" Folding settings
set nofoldenable        "dont fold by default
set foldmarker={,}
set foldopen=block,hor,mark,percent,quickfix,tag
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set foldlevel=1         "this is just what i use
map <leader>f1 :set fdm=manual<cr>
map <leader>f2 :set fdm=indent<cr>
map <leader>f3 :set fdm=marker<cr>

" Don't display start text :help iccf
set shortmess=atI
" Use matchit.vim
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set FileEncodeing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("multi_byte")
    set encoding=utf-8
    set fileencodings=utf-8,chinese,latin-1
    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " Don' use Unicode

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        set fileencoding=chinese
        " language messages en_US.utf-8
        language messages zh_CN.utf-8
        let &termencoding=&encoding
        set guifont=Consolas:h12:cDEFAULT
        " set guifont=Courier_New:h12:cDEFAULT
        set guifontwide=YaHei\ Consolas\ Hybrid:h12
        " set guifontwide=YouYuan:h12:cDEFAULT
        source $VIMRUNTIME\delmenu.vim
        source $VIMRUNTIME\menu.vim
        " set path+=E:\Vingel\bin\python\Lib\site-packages\
        if version >= 603
          set helplang=cn
        endif
    else
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of gvim was not compiled with +multi_byte"
endif

"if has("mac")
   "set shell=bash
     "colorscheme pablo
"endif

"if has("gui_macvim")
    "set transparency=2
"endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors & Fonts & Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax
syntax enable

if has("gui_running")
    colorscheme desertEx
    " Highlight current
    set cursorline
    set cursorcolumn
    hi cursorline guibg=#333333
    hi CursorColumn guibg=#333333
    " Toggle Menu and Toolbar and switch fullscreen mode
    set guioptions-=b " Hide bottom scrollbar
    set guioptions-=R " Hide right scrollbar
    set guioptions-=r
    set guioptions-=l " Hide left scrollbar
    set guioptions-=L
    set guioptions-=m " Hide Menu
    set guioptions-=T " Hide Toolbar
    map <silent> <F11> :if &guioptions =~# 'm' <Bar>
                \set guioptions-=m <bar>
                \else <Bar>
                \set guioptions+=m <Bar>
                \endif<cr>
    " Auto Maximize when vim starts.
    if has("win32")
        au GUIEnter * simalt ~x
    elseif has("unix")
        au GUIEnter * winpos 0 0
        "set lines=999 columns=9999
    endif
else
    set background=dark
    colorscheme vivi
endif

" Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

" Syntax
au BufRead,BufNewFile *.js set ft=javascript.jquery

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

set isfname-=\= " fix filename completion in VAR=/path

map <leader>t2 :setlocal shiftwidth=2<cr>
map <leader>t4 :setlocal shiftwidth=4<cr>
map <leader>t8 :setlocal shiftwidth=4<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcuts Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Select All
map <leader>a ggVG
" BufExplorer
map <leader>b :BufExplorer<cr>
" Switch to current dir, see also :set autochdir
map <leader>cd :cd %:p:h<cr>
" Temp text buffer
map <leader>e :e ~/.buffer<cr>
" Remove the Windows ^M
map <leader>M :%s/\r//g<cr>
" Fast Quit
map <leader>q :q<cr>
" Fast editing of the .vimrc
map <leader>ev :e! $VIMRC<cr>
" Fast reloading of the .vimrc
map <leader>s :source $VIMRC<cr>
" Undolist
map <leader>u :undolist<cr>
" Fast saving
map <leader>w :w!<cr>
map <C-S> <Esc>:w!<cr>

" Mapping Q to exit instead of Ex mode
map Q :x<cr>
nmap :X :x
nmap :W :w
nmap :Q :q
" Bash like
imap <C-A> <Home>
imap <C-E> <End>
imap <C-K> <Esc>d$i
imap <C-B> <Left>
imap <C-F> <Right>

" Command-line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

" Key mappings to ease browsing long lines
"noremap <C-J> gj
"noremap <C-K> gk

" Usefull when insert a new indent line
"imap jj <cr><C-O>O
" Remove tag content see :help object-select
imap ff <C-O>cit

" Move lines (Eclipse like)
nmap <C-Down> :<C-u>move .+1<cr>
nmap <C-Up> :<C-u>move .-2<cr>
imap <C-Down> <C-o>:<C-u>move .+1<cr>
imap <C-Up> <C-o>:<C-u>move .-2<cr>
vmap <C-Down> :move '>+1<cr>gv
vmap <C-Up> :move '<-2<cr>gv

" Windows issues
vmap <leader>c "+y
vmap <leader>x "+x
map <leader>v "+gP
inoremap <leader>v <C-O>"+gP
" Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
" Set clipboard+=unnamed

" Easily change between backslash and forward slash with f/ or f\
nnoremap <silent> f/ :let tmp=@/<CR>:s:\\:/:ge<CR>:let @/=tmp<CR>
nnoremap <silent> f<Bslash> :let tmp=@/<CR>:s:/:\\:ge<CR>:let @/=tmp<CR>

" Undo
inoremap <C-z> <C-O>u

" Use shell with ctrl-z
"map <C-Z> :shell<cr>

" Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''
" Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>
" SVN Diff
"map <F8> :new<cr>:read !svn diff<cr>:set syntax=diff buftype=nofile<cr>gg
" ROT13
map <F12> ggVGg?

map <leader>sp :vsplit <cr>

" Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=xhtml<cr>
map <leader>2 :set ft=css<cr>
map <leader>3 :set ft=javascript<cr>
map <leader>4 :set syntax=python<cr>
map <leader>5 :set ft=php<cr>
map <leader>$ :syntax sync fromstart<cr>

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/Donson/', "~/", "g")
    return curdir
endfunction

"Format the statusline
set statusline=%F%m%r%h%w\ CW\ %r%{CurDir()}%h\ [%Y,%{&ff},%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ [POS=%l,%v,%p%%,%L]

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  if g:cmd == g:cmd_edited
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map auto complete of (, ", ', [,{
inoremap ( ()<esc>:let leavechar=")"<cr>i
inoremap [ []<esc>:let leavechar="]"<cr>i
inoremap { {}<esc>:let leavechar="}"<cr>i
inoremap < <><esc>:let leavechar=">"<cr>i
inoremap ' ''<esc>:let leavechar="'"<cr>i
inoremap " ""<esc>:let leavechar='"'<cr>i
inoremap )) (<esc>o)<esc>:let leavechar=")"<cr>O
inoremap ]] [<esc>o]<esc>:let leavechar="]"<cr>O
inoremap }} {<esc>o}<esc>:let leavechar="}"<cr>O
vnoremap #( <esc>`>a)<esc>`<i(<esc>
vnoremap #[ <esc>`>a]<esc>`<i[<esc>
vnoremap #{ <esc>`>a}<esc>`<i{<esc>
vnoremap #< <esc>`>a><esc>`<i<<esc>
vnoremap #' <esc>`>a'<esc>`<i'<esc>
vnoremap #" <esc>`>a"<esc>`<i"<esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

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

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist.vim
"set tags=./tags "now using autotags.vim to set tags
map <leader>t :TlistToggle<cr>
let Tlist_Auto_Open=0 " let the tag list open automagically
let Tlist_Compact_Format = 1 " show small menu
let Tlist_Ctags_Cmd = $VIMFILES.'\lib\ctags58\ctags.exe' " location of ctags
let Tlist_Enable_Fold_Column = 0 " do show folding tree
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
let Tlist_Sort_Type = "order" " order by
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always) read my functions
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_Menu = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_OnSelect = 1
let Tlist_Inc_Winwidth = 0
let tlist_html_settings = 'html;s:Structure;o:Objects(ID);c:Classes;h:Headers;f:function'
let tlist_xhtml_settings = 'html;s:Structure' ";o:Objects(ID);c:Classes;h:Headers;f:function'
let tlist_javascript_settings = 'javascript;f:function;c:class;o:object;m:method;s:string;a:array;n:constant'
let tlist_php_settings = 'php;c:class;d:constant;f:function'

" NERD_tree.vim
map <leader>n :NERDTreeToggle<cr>
let NERDTreeIgnore=['Thumbs.db','\~$','.DS_Store', '\.svn$', '\.git', '\.pyc$', '\.mp3', '\.jpg', '\.gif','\.swf', '\.zip', '\.pdf', '\.gz', '\.bz2', '\.dmg', '\.doc', '\.tar', '\.png', '\.rtf']

" project.vim
"map <leader>p :Project<cr>

" html.vim
"let g:no_html_toolbar = 1
"let g:do_xhtml_mappings = 'yes'
"let g:html_tag_case = 'lowercase'

" closetag.vim
"let g:closetag_html_style=1

" ToHTML
let use_xhtml = 1
let html_use_css = 1
let html_number_lines = 0

" mru.vim (History file List, Most Recent Used)
"map <leader>h :MRU <cr>
"let MRU_Max_Entries = 30
"let MRU_Exclude_Files='^/tmp/.*\|^/var/tmp/.*'
"let MRU_Include_Files='\.c$\|\.cpp$\|\.h$\|\.hpp$'  " For C Source
"let MRU_Window_Height=15
"let MRU_Add_Menu=0

" fencview.vim
"let g:fencview_autodetect = 0

" acp.vim & SnipMate.vim
let g:acp_behaviorSnipmateLength =1
let g:acp_enableAtStartup = 1
let g:acp_completeOption = '.,w,b,u,t,i,k'
let g:snips_author = 'Donson <http://www.donsonx.com/>'
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=html.django_template.jquery " For SnipMate & jquery

" fuf.vim
"map <leader>fb :FufDirWithCurrentBufferDir<cr>
"map <leader>fd :FufDir<cr>
"map <leader>ff :FufFile<cr>
"map <leader>ft :FufTag<cr>
"map <leader>fh :FufHelp<cr>

" JSLint.vim
"let g:jslint_command = $VIMFILES . '/extra/jslint/jsl'
"let g:jslint_command_options = '-conf ' .  $VIMFILES . '/extra/jslint/jsl.conf -nofilelisting -nocontext -nosummary -nologo -process'
"autocmd BufWritePost,FileWritePost *.js call JavascriptLint()

""""""""""""""""""""""""""""""
" => ZenCoding
"""""""""""""""""""""""""""""""
let g:user_zen_expandabbr_key = '<c-j>'
let g:use_zen_complete_tag = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set OminComplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=longest,menu
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,htm set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType php setlocal dict+=$VIMFILES/dict/php_functions.txt
autocmd FileType c set omnifunc=ccomplete#Complete

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH
autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Csstidy
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
    autocmd FileType css,html,htm map <leader>ct <Esc>:'<,'>! csstidy - --silent=true --template=high --preserve_css=true --compress_colors=false<CR>
    autocmd FileType css,html,htm map <leader>ct0 <Esc>:'<,'>! csstidy - --silent=true --template=low<CR>
    autocmd FileType css,html,htm map <leader>ct1 <Esc>:'<,'>! csstidy - --silent=true<CR>
    autocmd FileType css,html,htm map <leader>ct2 <Esc>:'<,'>! csstidy - --silent=true --template=high<CR>
    autocmd FileType css,html,htm map <leader>ct3 <Esc>:'<,'>! csstidy - --silent=true --template=highest<CR>
    autocmd FileType css,html,htm map <leader>cta <Esc>:%! csstidy - --silent=true --template=high<CR>
    autocmd FileType css,html,htm map <leader>ctm <Esc>:%! csstidy - --template=high<CR>
    autocmd FileType css,html,htm map <leader>cthe <Esc>:%! csstidy - --silent=true --template=highest<CR>
    autocmd FileType css,html,htm map <leader>cthm <Esc>:%! csstidy - --template=highest<CR>
endif

""""""""""""""""""""""""""""""
" => calendar.vim
"""""""""""""""""""""""""""""""
let g:calendar_diary="D:/Donson/diary"
map <leader>cr :Calendar<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Refresh Firefox (preserving scroll) on Vim save, using MozRepl
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufWriteCmd *.html,*.css,*.gtpl :call Refresh_firefox()
"function! Refresh_firefox()
  "if &modified
    "write
    "silent !echo  'vimYo = content.window.pageYOffset;
                 "\ vimXo = content.window.pageXOffset;
                 "\ BrowserReload();
                 "\ content.window.scrollTo(vimXo,vimYo);
                 "\ repl.quit();'  |
                 "\ nc localhost 4242 2>&1 > /dev/null
  "endif
"endfunction

set dictionary+=$VIMFILES/dict/dicts.txt
