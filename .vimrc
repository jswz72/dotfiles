" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'

Plugin 'inkarkat/vim-ingo-library.git'

Plugin 'inkarkat/vim-mark.git'

Plugin 'scrooloose/nerdtree.git'

Plugin 'tomtom/tcomment_vim'

Plugin 'mhinz/vim-signify'

call vundle#end()            " required
filetype plugin indent on    " required
" EndVundle

set nocompatible
set tabstop=4
filetype plugin indent on
set shiftwidth=4
set number
set relativenumber
syntax on
set timeoutlen=300  "to shorten delay when using O 

"split nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
nnoremap <C-H> <C-W><C-H>

"auto insert {
inoremap {<CR> {<CR>}<Esc>ko

inoremap df <Esc>

" Capitalize word under cursor
nnoremap <c-u> viwU

nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vsp $MYVIMRC<cr>

" double quote cur word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" single quote cur word
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" center next search occurence
nnoremap n nzz

fun! ShowFuncName()
	let lnum = line(".")
	let col = col(".")
	echohl ModeMsg
	if &filetype == "python"
		"todo
	else
		echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
	endif
	echohl None
	call search("\\%" , lnum , "l" , "\\%" , col , "c")
endfun

hi VertSplit ctermfg=yellow
set fillchars+=vert:~

" Find/print num occurences w/o moving cursor
map ,* *<C-O>:%s///gn<CR>

" Edit last file
nnoremap <space><space> :e #<Esc>
