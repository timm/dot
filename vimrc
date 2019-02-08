autocmd BufEnter * silent! lcd %:p:h

filetype off
syntax on 
filetype indent plugin on

set autoindent
set background=light
set backspace=indent,eol,start

set nobackup
set noswapfile
set directory=~/.tmp,~/.vim-tmp,~/tmp,/var/tmp,/tmp 

set hlsearch
set ignorecase
set incsearch
set laststatus=2
set matchpairs+=<:>
set matchtime=15
set modelines=3
set mouse=a
set nocompatible
set nohlsearch
set ruler
set scrolloff=3
set showcmd
set showmatch
set showmode
set smartcase
set splitbelow
"set syntax=on
set title
set ttyfast
set visualbell
"set number
set wrap

set matchpairs+=<:>


set statusline=%F%m%r%h%w\ [%{&ff}:%Y]%=\ %l,%v\ 

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"set fillchars+=vert:\
"colorscheme torte
"colorscheme default
"hi VertSplit guifg=#202020 guibg=#202020 gui=NONE ctermfg=DarkGray ctermbg=DarkGray cterm=NONE
set paste

if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end     

" show trailing whitespace chars
set list
set listchars=tab:>-,trail:.,extends:#,nbsp:.

"Last up in this section I just fix the terminal code support so both my backspace and delete keys work as expected on OS X.

" Setup term color support
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tbastos/vim-lua'
Plugin 'scrooloose/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'soli/prolog-vim'
"Plugin 'valloric/youcompleteme'

" Gruvbox
" Molokai
" Inkpot

call vundle#end()
filetype plugin indent on

autocmd vimenter * NERDTree 
autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

set background=dark    " Setting dark mode
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
