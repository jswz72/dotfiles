set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
call vundle#begin()

" Package manager
Plugin 'gmarik/vundle'

" Automcplete
Plugin 'Valloric/YouCompleteMe'

Plugin 'inkarkat/vim-ingo-library.git'

" Multiple highlights via <leader>m
Plugin 'inkarkat/vim-mark.git'

" Filetree navigator
Plugin 'scrooloose/nerdtree.git'

" Autocomment out code via <leader>gc.
" Do whole line with <leader>gcc
Plugin 'tomtom/tcomment_vim'

" Auto-detect and display source control changs on save
Plugin 'mhinz/vim-signify'

" Show location of marks
Plugin 'jacquesbh/vim-showmarks'

Plugin 'majutsushi/tagbar'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'http://gitlab.aristanetworks.com/vim-scripts/mts.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" Include the system settings
if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

" Include Arista-specific settings
:if filereadable( $VIM . "/vimfiles/arista.vim" )
   source $VIM/vimfiles/arista.vim
:endif

" Put your own customizations below

if  filereadable( "cscope.out" )
   silent exe "cs add /src/cscope.out"
endif

if  filereadable( "py_cscope.out" )
   silent exe "cs add /src/py_cscope.out"
endif

let g:pymode_python = 'python'
" To avoid python-mode trimming whitespace and messing up reviews
let g:pymode_trim_whitespaces = 0
let g:python_recommended_style = 0
set number
set relativenumber
"set timeoutlen=100
set tabstop=3
set shiftwidth=3

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap n nzz

" inoremap qq <Esc>
" inoremap qw <Esc>

fun! ShowFuncName()
   let lnum = line(".")
   let col = col(".")
   echohl ModeMsg
   if &filetype == "python"
      " Show class name cuz its easier than func name for python
      " doesn't take into account nested clases :(
      let spaces = lnum - 3
      let spaces = repeat(' ', 3)
      echo getline(search("class [A-Z].*(.*", 'b'))
      echohl None
   else
      " find enclosing function in .tin/.cpp
      echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
      echohl None
   endif
   call search("\\%" . lnum . "l" . "\\%" . col . "c")
   endfun
map = :call ShowFuncName() <CR>

:command! Vd colo elflord

"Call nerdtree with Nt, wait till its loaded
autocmd VimEnter * :command Nd NERDTree
autocmd VimEnter * :command Nt NERDTreeToggle
autocmd VimEnter * :command Cm MarkClear
" let g:mwDefaultHighlightingPalette = 'extended'

autocmd VimResized * wincmd =
autocmd FileType python nnoremap gd :call GoDef()<CR>
autocmd FileType diff normal gg


hi VertSplit ctermfg=yellow
set fillchars+=vert:\

highlight traces ctermfg=blue
match traces /TRACE[0-9]/

if &term == "screen"
   set t_ts=^[]2;
   set t_fs=^[
endif

set title titlestring=vim

set titleold=
:auto BufEnter * let &titlestring='vim'

"Vim signify stuff to work with a p4
let g:signify_vcs_cmds = {
   \ 'perforce': 'a p4 diff -du 0 %f' }
 let g:signify_vcs_cmds_diffmode = {
       \ 'perforce': 'a p4 print %f',
       \ }

" Swap between tac and tin files
command! Etac :execute( 'edit ' . substitute(@%,'\.tin','\.tac', 'g') )
command! Etin :execute( 'edit ' . substitute(@%,'\.tac','\.tin', 'g') )
nnoremap -a :Etac<cr>
nnoremap -i :Etin<cr>

"
" " For lightline
" set laststatus=2
" set noshowmode

" let g:airline_theme='base16_spacemacs'

map ,* *<C-O>:%s///gn<CR>

inoremap df <Esc>
nnoremap <leader>ev :vsp $MYVIMRC<Esc>
nnoremap <leader>sv :source $MYVIMRC<Esc>
nnoremap <leader>8 :TagbarToggle<CR>
nnoremap <leader>hh :noh<CR>

" nnoremap <leader>c viwC

nnoremap <space><space> :e #<Esc>

hi WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None
hi VertSplit ctermfg=8 ctermbg=8
hi LineNr ctermfg=6
hi CursorLineNr ctermfg=1

" One color for add/delte, highlight background for change
highlight DiffAdd term=bold cterm=bold ctermfg=7 ctermbg=6 gui=bold guifg=Blue guibg=LightCyan
highlight DiffDelete term=bold cterm=bold ctermfg=7 ctermbg=6 gui=bold guifg=Blue guibg=LightCyan
highlight DiffChange term=bold cterm=bold ctermfg=7 ctermbg=6 gui=bold guifg=Blue guibg=LightCyan
highlight DiffText term=bold cterm=bold ctermfg=7 ctermbg=red gui=bold guifg=Blue guibg=red

" set cul
" :autocmd InsertEnter * set nocul
" :autocmd InsertLeave * set cul
"
hi CursorLine cterm=NONE ctermbg=0
:command! Ch hi CursorLine cterm=NONE ctermbg=2
:command! Chb hi CursorLine cterm=NONE ctermbg=0


" Overload gd to literally go to def in python file
" TODO work on fallback if not function
fun! GoDef()
   let res = search("def " . expand("<cword>") . "(")
   if !res
      :norm! gd
   endif
endfun


" fun! NoNums()
"    set nonumber
"    set norelativenumber
" endfun
" :command NN :call NoNums()

" Open bug under cursor
nnoremap <leader>b :new <bar> .!a4 bugs <C-r><C-w> -A<CR>
" Open logfile in reg0 (yank)
nnoremap <leader>l :new <bar> .!wget -qO- <C-r>0<CR>

let g:netrw_http_cmd="curl"
let g:netrw_http_xcmd="-L -o"

autocmd QuickFixCmdPost * copen
