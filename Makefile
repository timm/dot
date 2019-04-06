#!/usr/bin/make -f
SHELL = /bin/bash

# Optionally, if my.mk exists then include its local config.
-include my.mk

# This my.mk file might set the following variables.
# If not, they will be set as follows.

What     ?= Github101#
Who      ?= Tim Menzies#
When     ?= 2018,2019#
Email    ?= timm@ieee.org#
Title    ?= Init methods for a repo#
Where    ?= github.com/timm/dot/#

dConfig  ?= $(HOME)/.config#
dDot     ?= $(dConfig)/dot#
dTmp     ?= $(HOME)/tmp#

dTests   ?= tests#
dSrc     ?= src#
dData    ?= data#
dDoc     ?= docs#
dEtc     ?= $(dSrc)/,#

############################################################
# Don't touch these two lines
dDirs    = $(dTmp) $(dConfig) $(dDot)#
dGhub    = $(dSrc) $(dTests) $(dData) $(dDoc) $(dEtc)#

############################################################
help:
	@echo "$$HELP"

############################################################

all: dirs bashrc tmux  $(HOME)/.vim/bundle vimrc
	@echo "To complete, please '. ~/.bashrc'"

############################################################
chmods: ; @chmod +x $(Here)/*

heres: $(Here)/blank.lua 
lua:  ~/.gitignore use.lua $(Tests)/use.lua

############################################################
.PHONY: dirs

dirs:
	@$(foreach d,$(dDirs), \
              if [ ! -d "$d" ]; then \
              	 echo mkdir $d; mkdir $d; fi; )

dirsGh: 
	@$(foreach d,$(dGHub), \
              if [ ! -d "$d" ]; then \
              	 echo mkdir $d; mkdir $d; fi; )
	@$(foreach d,$(dGhub),                  \
	      if [ ! -f "$d/README.md" ]; then   \
	         touch $d/README.md;               \
                 git add $d/README.md; fi; )

############################################################
bashrc: dirs $(dDot)/bashrc 

$(HOME)/.bashrc: ; @touch $@

$(dDot)/bashrc: $(HOME)/.bashrc 
	@echo "$$BASHRC" > $@
	@(grep ". $@" $< || echo ". $@" >> $< )>/dev/null

############################################################
vimrc: dirs $(dDot)/vimrc

$(HOME)/.vimrc: ; @touch $@

$(dDot)/vimrc: $(HOME)/.vimrc 
	@echo "$$VIMRC" > $@
	@(grep "source $@" $< || echo "source $@" >> $<)>/dev/null

############################################################
$(HOME)/.vim/bundle: 
	@if [ ! -d "$@" ]; then \
          git clone https://github.com/gmarik/Vundle.vim.git $@/Vundle.vim; fi
	@vim +PluginInstall +qall 

macVimInstall:
	brew unlink macvim
	brew install vim
	brew upgrade vim

ubuntuVimInstall:
	sudo add-apt-repository  -y ppa:jonathonf/vim
	sudo apt update
	sudo apt-get -y upgrade vim
	sudo apt autoclean
	sudo apt-get clean
	sudo apt autoremove
	
############################################################

aptget = if [ ! `which $(1)` ]>&2; then sudo apt-get -y install $(2); fi#

ubuntuInstall: ubuntuBat ubuntuVimInstall
	sudo apt-get -y update
	sudo apt-get -y upgrade
	$(call aptget,aspell,aspell)
	$(call aptget,clisp,clisp)
	$(call aptget,cmatrix,cmatrix)
	$(call aptget,ctags,ctags)
	$(call aptget,gnuplot,gnuplot)
	$(call aptget,gst,gnu-smalltalk)
	$(call aptget,htop,htop)
	$(call aptget,luajit,luajit)
	$(call aptget,lua,lua5.2)
	$(call aptget,mc,mc)
	$(call aptget,ncdu,ncdu)
	$(call aptget,pip,python-pip)
	@sudo -H pip install --upgrade pip
	$(call aptget,python,python3)
	$(call aptget,ranger,ranger)
	$(call aptget,robots,bsdgames)
	$(call aptget,swipl,swi-prolog)
	$(call aptget,tmux,tmux)
	$(call aptget,tree,tree)
	$(call aptget,wget,wget)
	sudo -H pip install pycco
	@if [ ! `which bat` ] >&2; then \
           cd $(dTmp); \
	   wget https://github.com/sharkdp/bat/releases/download/v0.6.1/bat_0.6.1_amd64.deb; \
	   sudo dpkg -i bat_0.6.1_amd64.deb; \
	fi
	sudo apt autoclean
	sudo apt-get clean
	sudo apt autoremove

ubuntuBat: dirs
	cd $(dTmp)
	wget -nc https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb
	sudo dpkg -i bat_0.9.0_amd64.deb
	rm  bat_0.9.0_amd64.deb

define brew
  if [ ! `which brew` ] >&2; then\
    /usr/bin/ruby -e \
       $(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install) ; fi
  if [ ! `which $(1)` ] >&2; then brew install $(2); fi
endef

macInstall: macVimInstall
	@sudo easy_install pip
	@if [ ! `which pycco`  ] >&2; then sudo -H pip install pycco; fi
	@(call brew,aspell,aspell)
	@(call brew,clisp,clisp)
	@(call brew,cmatrix,cmatrix)
	@(call brew,ctags,ctags)
	@(call abrew,gnuplot,gnuplot)
	@(call brew,gst,gnu-smalltalk)
	@(call brew,htop,htop)
	@(call brew,luajit,luajit)
	@(call brew,lua,lua)
	@(call brew,lua,lua5.2)
	@(call brew,mc,mc)
	@(call brew,ncdu,ncdu)
	@(call brew,pycco,pycco)
	@(call brew,python,python3)
	@(call brew,ranger,ranger)
	@(call brew,reattach-to-user-namespace,reattach-to-user-namespace)
	@(call brew,swipl,swi-prolog)
	@(call brew,tmux,tmux)
	@(call brew,tree,tree)
	@(call brew,wget,wget)

############################################################
tmux:  dirs $(dDot)/tmux $(dDot)/tmux-session1

$(HOME)/.tmux.conf: 
	@touch $@

$(dDot)/tmux: $(HOME)/.tmux.conf 
	@echo "$$TmuxConf" > $@
	@(grep "source-file $@" $< || echo "source-file $@" >> $< )>/dev/null

$(dDot)/tmux-session1 :
	@echo "$$TmuxSession" > $@

	
############################################################
github: dirs dirsGh ignore ../LICENSE.md ../CITATION.md ../CONTRIBUTING.md ../requirements.txt ../CODE_OF_CONDUCT.md
	 
macIgnore: ; @echo "$$MacSkip$$VimSkip"          > .gitignore; git add .gitignore        
luaIgnore: ; @echo "$$MacSkip$$VimSkip$$LuaSkip" > .gitignore; git add .gitignore
pyIgnore:  ; @echo "$$MacSkip$$VimSkip$$PySkip"  > .gitignore; git add .gitignore

../LICENSE.md         : ; echo "$$LICENSE"  > $@; git add $@
../CITATION.md        : ; echo "$$CITATION" > $@; git add $@
../CONTRIBUTING.md    : ; echo "$$CONTRIB"  > $@; git add $@
../requirements.txt   : ; echo "$$REQUIRES" > $@; git add $@
../CODE_OF_CONDUCT.md : ; echo "$$CONDUCT"  > $@; git add $@

#use.lua               : ; echo "$$USE"      > $@; git add $@
#$(Tests)/use.lua      : ; echo "$$USE"      > $@; git add $@
#$(Here)/blank.lua     : ; echo "$$BLANK"    > $@; git add $@

############################################################
define HELP
About DOT
=========

This Makefile contains all the config tricks that are global to all my
Mac and Unix installations as well all my Github repos.

The goal here is that if ever I land on a new machine or an empty Ubuntu
container, I can download this Makefile, do the following, then in just
a few minutes I can be up and running in my kinda envrionment:

- Some cool tricks for:
	- mux, vim8, bash, git, etc
- Some standard packages installed: 
	- apsell, bat, ctags, htop, mc, ncdu, pycco, ranger, tmux, 
	  tree, vim8, wget, etc.
- My favorite languages installed: 
	- clisp, gnuplot, gnu-smalltalk, lua, luajit, python-pip, 
          python3, swi-prolog, etc
- And some silly things: cmatrix, bsdgames (unix only), etc

I also add "," to the PATH so any directory can have a local
set of executables in `,/`.

To achieve all this, code adds stuff (without overriding) to 
`.bashrc`, `.vimrc`, `.tmux.config`. 

It also creates `~/.config/dot` for all its local config files

Lastly, it esnures that ~/.vim/bundle contains the VIM package manager.

Install Instructions
====================

**IMPORTANT NOTE:** Each of the following assumes that the step before
has been executed before.

Step1: Initial Install
----------------------

Before you do anything else, then anywhere, onetime install.

	make macInstall    all # if mac 
	make ubuntuInstall all # if ubuntu

Note: this could take a few minutes.

Step2: Updates
---------------

Next, if ever u have updated this Makefile and want to push out new
configs

	make -B all

Note: this should be very fast. 

Step3: Making all those Github files
------------------------------------

Next, if you u want to create all those Github files then check out a
repo, cd into its root. Optionally, you might want to write a "my.mk"
file that sets some of the text to be written into the standrrd Github
files (e.g., your email). Anyway, after that, type

	make github LuaIgnore # for a Lua rep
	make github PyIgnore  # for a Python repo

Note: this should be very fast. Existing files will not be overwritten.

endef
export HELP

############################################################
define BASHRC

_c0="\033[00m"     # white
_c1="\033[01;32m"  # green
_c2="\033[01;34m"  # blue
_c3="\033[31m"     # red
_c5="\033[35m"     # purple
_c6="\033[33m"     # yellow
_c7="\033[36m"     # turquoise

here() { cd $$1; basename "$$PWD"; }

PROMPT_COMMAND='echo -ne "$$(hostname -s):$${_c6}$$(git branch 2>/dev/null | grep '^*' | colrm 1 2) \033]0;$$(here ../..)/$$(here ..)/$$(here .)\007";PS1="$${_c1}$$(here ../..)/$$_c2$$(here ..)/$$_c3$$(here .) $${_c6}\!>$${_c0}\e[m "'

alias vi=vim
alias matrix="cmatrix -bs -u 6"
alias mc='mc -x'
alias ls='ls -GF'
alias get='git pull'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias put='gc; git commit -am saving; git push; git status'
alias gc="git config credential.helper 'cache --timeout=3600'"

pathadd() {
      if  [[ ":$$PATH:" != *":$$1:"* ]]; then
          export PATH="$${PATH:+"$$PATH:"}$$1"
      fi
}
pathadd ,
endef
export BASHRC

############################################################
define VIMRC

autocmd BufEnter * silent! lcd %:p:h

filetype off
syntax on 
filetype indent plugin on

set autoindent
set background=light
set backspace=indent,eol,start

set nobackup
set noswapfile
set directory=$(Tmp)

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

set clipboard=unnamed

set statusline=\ %F%m%r%h%w\ [%{&ff}:%Y]%=\ %l,%v\ 

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
if $$TERM == "xterm-256color" || $$TERM == "screen-256color" || $$COLORTERM == "gnome-terminal"
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
Plugin 'majutsushi/tagbar'
"Plugin 'valloric/youcompleteme'

" Gruvbox
" Molokai
" Inkpot

call vundle#end()
filetype plugin indent on

autocmd vimenter * NERDTree 
autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinPos = "right"

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

set background=dark    " Setting dark mode
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

nmap <F8> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>
endef
export VIMRC

############################################################
define REQUIRES
lua>=5.1
luajit>=5.1
pycco>=0.6
python>=3.7
endef
export REQUIRES

############################################################
define LuaSkip
### Lua ###
# Compiled Lua sources
luac.out

# luarocks build files
*.src.rock
*.zip
*.tar.gz

# Object files
*.o
*.os
*.ko
*.obj
*.elf

# Precompiled Headers
*.gch
*.pch

# Libraries
*.lib
*.a
*.la
*.lo
*.def
*.exp

# Shared objects (inc. Windows DLLs)
*.dll
*.so
*.so.*
*.dylib

# Executables
*.exe
*.out
*.app
*.i*86
*.x86_64
*.hex
endef
export LuaSkip

############################################################
define VimSkip
### Vim ###
[._]*.s[a-w][a-z]
[._]s[a-w][a-z]
*.un~
Session.vim
.netrwhist
*~
endef 
export VimSkip

############################################################
define MacSkip
### Mac  ###
# General
.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon

# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk
endef 
export MacSkip

############################################################
define PySkip
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
.python-version

# pipenv
#   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
#   However, in case of collaboration, if having platform-specific dependencies or dependencies
#   having no cross-platform support, pipenv may install dependencies that don’t work, or not
#   install all needed dependencies.
#Pipfile.lock

# celery beat schedule file
celerybeat-schedule

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/
endef
export PySkip

############################################################
define CITATION

# CITATION

Please cite this as

- $(Who), _$(Title)_, $(When)

Bibtex:

    @misc{$(What),
      author="$(Who)",
      year="$(When)",
      title="$(Title)",
      note="Download from http://$(Where)"
    }
endef
export CITATION

############################################################
define CONDUCT

# Contributor Covenant Code of Conduct

## Our Pledge

In the interest of fostering an open and welcoming environment, we
as contributors and maintainers pledge to making participation in
our project and our community a harassment-free experience for
everyone, regardless of age, body size, disability, ethnicity, sex
characteristics, gender identity and expression, level of experience,
education, socio-economic status, nationality, personal appearance,
race, religion, or sexual identity and orientation.

## Our Standards

Examples of behavior that contributes to creating a positive
environment include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome 
  sexual attention or advances
* Trolling, insulting/derogatory comments, and personal 
  or political attacks 
* Public or private harassment 
* Publishing others' private information, such as a 
  physical or electronic address, without explicit permission
* Other conduct which could reasonably be considered 
  inappropriate in a professional setting

## Our Responsibilities

Project maintainers are responsible for clarifying the standards
of acceptable behavior and are expected to take appropriate and
fair corrective action in response to any instances of unacceptable
behavior.

Project maintainers have the right and responsibility to remove,
edit, or reject comments, commits, code, wiki edits, issues, and
other contributions that are not aligned to this Code of Conduct,
or to ban temporarily or permanently any contributor for other
behaviors that they deem inappropriate, threatening, offensive, or
harmful.

## Scope

This Code of Conduct applies both within project spaces and in
public spaces when an individual is representing the project or its
community. Examples of representing a project or community include
using an official project e-mail address, posting via an official
social media account, or acting as an appointed representative at
an online or offline event. Representation of a project may be
further defined and clarified by project maintainers.

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior
may be reported by contacting the project team at $(Email).
All complaints will be reviewed and investigated and will result
in a response that is deemed necessary and appropriate to the
circumstances. The project team is obligated to maintain confidentiality
with regard to the reporter of an incident.  Further details of
specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct
in good faith may face temporary or permanent repercussions as
determined by other members of the project's leadership.

## Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage],
version 1.4, available at
https://www.contributor-covenant.org/version/1/4/code-of-conduct.html

[homepage]: https://www.contributor-covenant.org

For answers to common questions about this code of conduct, see
https://www.contributor-covenant.org/faq

endef
export CONDUCT

############################################################
define LICENSE

# LICENSE

$What  Copyright (c) $When, $Who
All rights reserved, BSD 3-Clause License

Redistribution and use in source and binary forms, with
or without modification, are permitted provided that
the following conditions are met:

- Redistributions of source code must retain the above
  copyright notice, this list of conditions and the 
  following disclaimer.
- Redistributions in binary form must reproduce the
  above copyright notice, this list of conditions and the 
  following disclaimer in the documentation and/or other 
  materials provided with the distribution.
- Neither the name of the copyright holder nor the names 
  of its contributors may be used to endorse or promote 
  products derived from this software without specific 
  prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

endef
export LICENSE

############################################################
define LuaBlank
-- vim: ft=lua ts=2 sw=2 sts=2 et : cindent : formatoptions+=cro
-- $(What) copyright (c) $(When) $(Who), $(Email)
-- All rights reserved, opensource.org/licenses/BSD-3-Clause
-- For examples of usage, see $(Tests)/xxx.lua.
--------- --------- --------- --------- --------- --------- ---------

local Object=require('use')('src/lib.lua')

--------- --------- --------- --------- --------- --------- ---------
return isMain('lib') and rogues() 
endef 
export LuaBlank

############################################################
define USE
-- vim: ft=lua ts=2 sw=2 sts=2 et : cindent : formatoptions+=cro
-- $(What) copyright (c) $(When) $(Who), $(Email)
-- All rights reserved, opensource.org/licenses/BSD-3-Clause
--------- --------- --------- --------- --------- --------- ---------

local root = '../'
local seen = {}

function use(f, show)
  if not seen[f] then 
    if show then io.stderr:write('-- ' .. f .. '\n') end
    seen[f] = dofile(root .. f)
  end 
  return seen[f]
end 

return use
endef 
export USE

############################################################
define TmuxSession
split-window -h -p 33 "htop"
split-window -v -p 83 
split-window "mc -x"
rename-window "main"
new-window 
rename-window "news"
send-keys "cd ~/gits/timm/timm.github.io" C-m
split-window -h  -p 50
send-keys "cd ~/gits/timm/timm.github.io/etc; vim news.lua" C-m
rename-window "other"
endef
export TmuxSession

############################################################
define TmuxConf
set -g aggressive-resize on

# change the prefix from 'C-b' to 'C-a'
# (remap capslock to CTRL for easy access)
unbind C-b
set -g prefix C-Space
bind C-Space send-prefix


# start with window 1 (instead of 0)
set -g base-index 1

# start with pane 1
set -g pane-base-index 1

# split panes using | and -, make sure they open in the same path
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

unbind '"'
unbind %

# open new windows in the current path
bind c new-window -c "#{pane_current_path}"

# reload config file
bind r source-file ~/.tmux.conf

unbind p
bind p previous-window

# shorten command delay
set -sg escape-time 1

# don't rename windows automatically
set-option -g allow-rename off

# mouse control (clickable windows, panes, resizable panes)
set -g mouse on

# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# enable vi mode keys
set-window-option -g mode-keys vi

# set default terminal mode to 256 colors
set -g default-terminal "screen-256color"

# fix pbcopy/pbpaste
if 'command -v reattach-to-user-namespace >/dev/null' \
    'set -gq @osx-pasteboard true'

if 'tmux show -gv @osx-clipboard' \
    'set -g default-command "reattach-to-user-namespace -l $SHELL"'

# present a menu of URLs to open from the visible pane. sweet.
bind-key u capture-pane \;\
    save-buffer /tmp/tmux-buffer \;\
    split-window -l 10 "urlview /tmp/tmux-buffer"


bind P paste-buffer
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X copy-selection
bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

######################
### DESIGN CHANGES ###
######################

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

#  modes
setw -g clock-mode-colour colour5
setw -g mode-attr bold
setw -g mode-fg colour1
setw -g mode-bg colour18

# panes
set -g pane-border-bg colour0
set -g pane-border-fg colour19
set -g pane-active-border-bg colour0
set -g pane-active-border-fg colour9

# statusbar
set -g status-position top
set -g status-justify left
set -g status-bg colour18
set -g status-fg colour137
set -g status-attr dim
set -g status-left ''
#set -g status-right '#[fg=colour233,bg=colour19,bold] %d/%m #[fg=colour233,bg=colour8,bold] %H:%M:%S '
set -g status-right '#[fg=colour233,bg=colour19,bold] %d/%m #[fg=colour233,bg=colour8,bold] %H:%M '
set -g status-right-length 50
set -g status-left-length 20

setw -g window-status-current-fg colour1
setw -g window-status-current-bg colour19
setw -g window-status-current-attr bold
setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '

setw -g window-status-fg colour9
setw -g window-status-bg colour18
setw -g window-status-attr none
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

setw -g window-status-bell-attr bold
setw -g window-status-bell-fg colour255
setw -g window-status-bell-bg colour1

# messages
set -g message-attr bold
set -g message-fg colour232
set -g message-bg colour16

############################################
# layouts
bind S source-file $(dDot)/tmux-session1 
endef
export TmuxConf


