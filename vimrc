autocmd BufEnter * silent! lcd %:p:h
"filetype indent plugin on
set autoindent
set background=light
set backspace=indent,eol,start
set backupdir^=$HOME/tmp
set ignorecase
set incsearch
set laststatus=2
set matchtime=15
set modelines=3
set mouse=a
set nocompatible
set nohlsearch
set ruler
set scrolloff=3
set showmatch
set smartcase
set splitbelow
"set syntax=on
set title
set visualbell
set number
"syntax on 
"set fillchars+=vert:\
colorscheme torte
"hi VertSplit guifg=#202020 guibg=#202020 gui=NONE ctermfg=DarkGray ctermbg=DarkGray cterm=NONE
set paste

if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tbastos/vim-lua'

call vundle#end()
filetype plugin indent on

autocmd vimenter * NERDTree 
autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
