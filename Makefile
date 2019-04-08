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
	 
macIgnore: ; @echo "$$MacSkip$$VimSkip$$JekyllSkip"          > .gitignore; git add .gitignore        
luaIgnore: ; @echo "$$MacSkip$$VimSkip$$JekyllSkip$$LuaSkip" > .gitignore; git add .gitignore
pyIgnore:  ; @echo "$$MacSkip$$VimSkip$$JekyllSkip$$PySkip"  > .gitignore; git add .gitignore

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

I also add "../bin" to the PATH so any directory can have a local
set of executables in a sibling `../bin` directory.

To achieve all this, my configs are written to ~/.config/dot
which contains files are that loaded from
`~/.bashrc`, `~/.vimrc`, `~/.tmux.config`. 

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
alias ls='ls --color'
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
pathadd ../bin
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
define JekyllSkip
### Jekyll ###
_site
.sass-cache
.jekyll-metadata
Gemfile.lock
endef
export JekyllSkip

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
send-keys "ranger" C-m
split-window "mc -x"
rename-window "main"
new-window 
rename-window "news"
#send-keys "cd ~/gits/timm/timm.github.io" C-m
split-window -h  -p 50
#send-keys "cd ~/gits/timm/timm.github.io/etc; vim news.lua" C-m
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

dollar = $$#
slash = \\\\#
docs/tools.md : ; @echo "$$xxxdocs_tools_md" > $@; git add $@
    
define xxxdocs_tools_md
---
title: Tools
layout: default
---

Stuff you can use
endef
export xxxdocs_tools_md

docs/sitemap.md : ; @echo "$$xxxdocs_sitemap_md" > $@; git add $@
    
define xxxdocs_sitemap_md
---
title: Sitemap
layout: default
---

Around here
endef
export xxxdocs_sitemap_md

docs/faq.md : ; @echo "$$xxxdocs_faq_md" > $@; git add $@
    
define xxxdocs_faq_md
---
title: Frequently Asked Questions
layout: default
---

Funny you should ask...
endef
export xxxdocs_faq_md

docs/index.md : ; @echo "$$xxxdocs_index_md" > $@; git add $@
    
define xxxdocs_index_md
---
title: Demo page
layout: default
---

## Code

```python 
# try to work in less that 60 characters wide
#       1        2        3        4        5        60
def aa(): return b()
```

## Footnotes

Four score and seven years[^1] ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.

Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this.

## Centered tables

| Header1 | Header2 | Header3 |
|:--------|:-------:|--------:|
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|----
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|=====
| Foot1   | Foot2   | Foot3|
{: rules="groups" class="center"}


## Responsive Images

![](https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg?cs=srgb&dl=beautiful-beautiful-flowers-bird-1133957.jpg&fm=jpg){:class="img-responsive img-rounded"}

## Tabbed content

<ul id="profileTabs" class="nav nav-tabs">
    <li class="active"><a href="#profile" data-toggle="tab">Profile</a></li>
    <li><a href="#about" data-toggle="tab">About</a></li>
    <li><a href="#match" data-toggle="tab">Match</a></li>
</ul>
  <div class="tab-content">
<div role="tabpanel" class="tab-pane active" id="profile">
<p>
I will maintain the utmost respect for human life.
</p><p>
I make these promises solemnly, freely and upon my honour.

</p>
</div>

<div role="tabpanel" class="tab-pane" id="about">
    <p> I wanna be a nurse and help people when they are sick! And when they are well!</p>
    <img  src="http://aux2.iconspalace.com/uploads/pharmacist-female-icon-256.png">
</div>

<div role="tabpanel" class="tab-pane" id="match">
    <ul>
    <li>
    The total health of my patients will be my first consideration.</li>
<li>
I will hold in confidence all personal matters coming to my knowledge.</li>
<li>

I will not permit consideration of religion, nationality, race or social standing to intervene between my duty and my patient.
</li>
</ul>
</div>
</div>


## Maths

$(dollar)$(dollar)
$(slash)begin{align*}
  & $(slash)phi(x,y) = $(slash)phi $(slash)left($(slash)sum_{i=1}^n x_ie_i, $(slash)sum_{j=1}^n y_je_j $(slash)right)
  = $(slash)sum_{i=1}^n $(slash)sum_{j=1}^n x_i y_j $(slash)phi(e_i, e_j) = $(slash)$(slash)
  & (x_1, $(slash)ldots, x_n) $(slash)left( $(slash)begin{array}{ccc}
      $(slash)phi(e_1, e_1) & $(slash)cdots & $(slash)phi(e_1, e_n) $(slash)$(slash)
      $(slash)vdots & $(slash)ddots & $(slash)vdots $(slash)$(slash)
      $(slash)phi(e_n, e_1) & $(slash)cdots & $(slash)phi(e_n, e_n)
    $(slash)end{array} $(slash)right)
  $(slash)left( $(slash)begin{array}{c}
      y_1 $(slash)$(slash)
      $(slash)vdots $(slash)$(slash)
      y_n
    $(slash)end{array} $(slash)right)
$(slash)end{align*}
$(dollar)$(dollar)

## Notes

[^1]: i.e. 47 years
endef
export xxxdocs_index_md

docs/_layouts/default.html : ; @echo "$$xxxdocs__layouts_default_html" > $@; git add $@
    
define xxxdocs__layouts_default_html
<!DOCTYPE html>
<html>
	<head>
		{% include header.html %}
	</head>
	<body>
		<div class=wrapper>
			{% include banner.html %}
			<h1>{{page.title}}</h1>
			{{ content }}
			<hr>
			<center>
				{% include footer.html %}
			</center>
		</div>
	</body>
</html>
endef
export xxxdocs__layouts_default_html

docs/tutorials.md : ; @echo "$$xxxdocs_tutorials_md" > $@; git add $@
    
define xxxdocs_tutorials_md
---
title: Tutorials
layout: default
---

Tips and tricks.
endef
export xxxdocs_tutorials_md

docs/contact.md : ; @echo "$$xxxdocs_contact_md" > $@; git add $@
    
define xxxdocs_contact_md
---
title: Contact
layout: default
---

Contact us! 
endef
export xxxdocs_contact_md

docs/about.md : ; @echo "$$xxxdocs_about_md" > $@; git add $@
    
define xxxdocs_about_md
---
title: About Us
layout: default
---

We are great!
endef
export xxxdocs_about_md

docs/_includes/style.css : ; @echo "$$xxxdocs__includes_style_css" > $@; git add $@
    
define xxxdocs__includes_style_css

@import url('https://fonts.googleapis.com/css?family=Nunito:300,300i,600,600i');

body {
	font-weight: 300;
	font-family: "Nunito", "Helvetica Neue", Helvetica, Arial, sans-serif;
	margin-left: 15px;
	margin-right: 15px;
	margin-top: 10px;
}
div.wrapper {
	max-width: 700px;
	margin: auto;
}
code { 
	padding-left: 10px; padding-right: 10px;
}
.alignleft {
	margin-top:0px;
	padding-top:0px;
	float: left;
}
.alignright {
	margin-top:0px;
	padding-top:0px;
	float: right;
}
a:link,
a:visited,
a:hover,
a:active { color:#{{site.about.bold}}; }
a:hover  { background-color: #EEE; }

table.center {
	margin-left:auto; 
	margin-right:auto;
	border-collapse: separate;
	border-spacing: 10px 0;
}
header p { margin: 0px;  padding: 0px; }
header h1 {
	height: 100px; 
	padding-top: 6px; padding-bottom: 5px; 
	margin-top: 0px; margin-bottom:2px;
	color: #fff; border:0px;

	/* IE10+ */
	background-image: -ms-linear-gradient(left, #{{site.about.bold}} 0%, #FFFFFF 100%);

	/* Mozilla Firefox */
	background-image: -moz-linear-gradient(left, #{{site.about.bold}} 0%, #FFFFFF 100%);

	/* Opera */
	background-image: -o-linear-gradient(left, #{{site.about.bold}} 0%, #FFFFFF 100%);

	/* Webkit (Safari/Chrome 10) */
	background-image: -webkit-gradient(linear, left top, right top, color-stop(0, #{{site.about.bold}}), color-stop(100, #FFFFFF));

	/* Webkit (Chrome 11+) */
	background-image: -webkit-linear-gradient(left, #{{site.about.bold}} 0%, #FFFFFF 100%);

	/* W3C Markup */
	background-image: linear-gradient(to right, #{{site.about.bold}} 0%, #FFFFFF 100%);
}
endef
export xxxdocs__includes_style_css

docs/_includes/footer.html : ; @echo "$$xxxdocs__includes_footer_html" > $@; git add $@
    
define xxxdocs__includes_footer_html
<p>
<a href="{{site.url}}/LICENSE">&copy;{{site.about.when}}</a> 
:: <a href="mailto:{{site.about.email}}">{{site.about.email}}</a><br>
<i class="fab fa-github"></i> 
<i class="fab fa-twitter"></i> 
<i class="fas fa-phone"></i> 
</p>
endef
export xxxdocs__includes_footer_html

docs/_includes/banner.html : ; @echo "$$xxxdocs__includes_banner_html" > $@; git add $@
    
define xxxdocs__includes_banner_html
<header>
  <a href="{{site.url}}/index"><font 
    color="#{{site.about.bold}}"<i 
    class="fas fa-home"></i></font></a>
  <h1>&nbsp; 
    <p class=alignleft 
       style="padding-top: 30px;" >&nbsp;{{site.about.title}}</p>
    <p class=alignright 
       style="padding-top: 40px; color:#{{site.about.bold}};
              text-align: right; font-size: 20px;
              font-weight: bold;">{{site.about.what}}
    </p>
  </h1>
</header>

<a href="{{site.url}}/about">about</a> |
<a href="{{site.url}}/sitemap">site map</a> |
<a href="{{site.url}}/news">news</a> |
<a href="{{site.url}}/tools">tools</a> |
<a href="{{site.url}}/tutorials">tutorials</a> |
<a href="{{site.url}}/faq">faq</a> |
<a href="{{site.url}}/contact">contact</a> 
endef
export xxxdocs__includes_banner_html

docs/_includes/header.html : ; @echo "$$xxxdocs__includes_header_html" > $@; git add $@
    
define xxxdocs__includes_header_html
<title>{{page.title}}</title>
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab" 
      rel="stylesheet">
<link rel="stylesheet" 
      href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
      crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/mathjs@5.8.0/dist/math.min.js></script>
<script type="text/x-mathjax-config">
	MathJax.Hub.Config({
	      TeX: {
		equationNumbers: {
	    autoNumber: "AMS"
		}
	      },
	      tex2jax: {
		inlineMath: [ ['$(dollar)','$(dollar)'], ['$(slash)(', '$(slash))'] ],
		displayMath: [ ['$(dollar)$(dollar)','$(dollar)$(dollar)'] ],
		processEscapes: true,
	      }
	    });
</script>
<script type="text/javascript"
	src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
<style>
{% include style.css %}
{% include code_tango.css %}
</style>
endef
export xxxdocs__includes_header_html

docs/_includes/code_tango.css : ; @echo "$$xxxdocs__includes_code_tango_css" > $@; git add $@
    
define xxxdocs__includes_code_tango_css
.highlight .hll { background-color: #ffffcc }
.highlight  { background: #f8f8f8; }
.highlight .c { color: #8f5902; font-style: italic } /* Comment */
.highlight .err { color: #a40000; border: 1px solid #ef2929 } /* Error */
.highlight .g { color: #000000 } /* Generic */
.highlight .k { color: #204a87; font-weight: bold } /* Keyword */
.highlight .l { color: #000000 } /* Literal */
.highlight .n { color: #000000 } /* Name */
.highlight .o { color: #ce5c00; font-weight: bold } /* Operator */
.highlight .x { color: #000000 } /* Other */
.highlight .p { color: #000000; font-weight: bold } /* Punctuation */
.highlight .ch { color: #8f5902; font-style: italic } /* Comment.Hashbang */
.highlight .cm { color: #8f5902; font-style: italic } /* Comment.Multiline */
.highlight .cp { color: #8f5902; font-style: italic } /* Comment.Preproc */
.highlight .cpf { color: #8f5902; font-style: italic } /* Comment.PreprocFile */
.highlight .c1 { color: #8f5902; font-style: italic } /* Comment.Single */
.highlight .cs { color: #8f5902; font-style: italic } /* Comment.Special */
.highlight .gd { color: #a40000 } /* Generic.Deleted */
.highlight .ge { color: #000000; font-style: italic } /* Generic.Emph */
.highlight .gr { color: #ef2929 } /* Generic.Error */
.highlight .gh { color: #000080; font-weight: bold } /* Generic.Heading */
.highlight .gi { color: #00A000 } /* Generic.Inserted */
.highlight .go { color: #000000; font-style: italic } /* Generic.Output */
.highlight .gp { color: #8f5902 } /* Generic.Prompt */
.highlight .gs { color: #000000; font-weight: bold } /* Generic.Strong */
.highlight .gu { color: #800080; font-weight: bold } /* Generic.Subheading */
.highlight .gt { color: #a40000; font-weight: bold } /* Generic.Traceback */
.highlight .kc { color: #204a87; font-weight: bold } /* Keyword.Constant */
.highlight .kd { color: #204a87; font-weight: bold } /* Keyword.Declaration */
.highlight .kn { color: #204a87; font-weight: bold } /* Keyword.Namespace */
.highlight .kp { color: #204a87; font-weight: bold } /* Keyword.Pseudo */
.highlight .kr { color: #204a87; font-weight: bold } /* Keyword.Reserved */
.highlight .kt { color: #204a87; font-weight: bold } /* Keyword.Type */
.highlight .ld { color: #000000 } /* Literal.Date */
.highlight .m { color: #0000cf; font-weight: bold } /* Literal.Number */
.highlight .s { color: #4e9a06 } /* Literal.String */
.highlight .na { color: #c4a000 } /* Name.Attribute */
.highlight .nb { color: #204a87 } /* Name.Builtin */
.highlight .nc { color: #000000 } /* Name.Class */
.highlight .no { color: #000000 } /* Name.Constant */
.highlight .nd { color: #5c35cc; font-weight: bold } /* Name.Decorator */
.highlight .ni { color: #ce5c00 } /* Name.Entity */
.highlight .ne { color: #cc0000; font-weight: bold } /* Name.Exception */
.highlight .nf { color: #000000 } /* Name.Function */
.highlight .nl { color: #f57900 } /* Name.Label */
.highlight .nn { color: #000000 } /* Name.Namespace */
.highlight .nx { color: #000000 } /* Name.Other */
.highlight .py { color: #000000 } /* Name.Property */
.highlight .nt { color: #204a87; font-weight: bold } /* Name.Tag */
.highlight .nv { color: #000000 } /* Name.Variable */
.highlight .ow { color: #204a87; font-weight: bold } /* Operator.Word */
.highlight .w { color: #f8f8f8; text-decoration: underline } /* Text.Whitespace */
.highlight .mb { color: #0000cf; font-weight: bold } /* Literal.Number.Bin */
.highlight .mf { color: #0000cf; font-weight: bold } /* Literal.Number.Float */
.highlight .mh { color: #0000cf; font-weight: bold } /* Literal.Number.Hex */
.highlight .mi { color: #0000cf; font-weight: bold } /* Literal.Number.Integer */
.highlight .mo { color: #0000cf; font-weight: bold } /* Literal.Number.Oct */
.highlight .sa { color: #4e9a06 } /* Literal.String.Affix */
.highlight .sb { color: #4e9a06 } /* Literal.String.Backtick */
.highlight .sc { color: #4e9a06 } /* Literal.String.Char */
.highlight .dl { color: #4e9a06 } /* Literal.String.Delimiter */
.highlight .sd { color: #8f5902; font-style: italic } /* Literal.String.Doc */
.highlight .s2 { color: #4e9a06 } /* Literal.String.Double */
.highlight .se { color: #4e9a06 } /* Literal.String.Escape */
.highlight .sh { color: #4e9a06 } /* Literal.String.Heredoc */
.highlight .si { color: #4e9a06 } /* Literal.String.Interpol */
.highlight .sx { color: #4e9a06 } /* Literal.String.Other */
.highlight .sr { color: #4e9a06 } /* Literal.String.Regex */
.highlight .s1 { color: #4e9a06 } /* Literal.String.Single */
.highlight .ss { color: #4e9a06 } /* Literal.String.Symbol */
.highlight .bp { color: #3465a4 } /* Name.Builtin.Pseudo */
.highlight .fm { color: #000000 } /* Name.Function.Magic */
.highlight .vc { color: #000000 } /* Name.Variable.Class */
.highlight .vg { color: #000000 } /* Name.Variable.Global */
.highlight .vi { color: #000000 } /* Name.Variable.Instance */
.highlight .vm { color: #000000 } /* Name.Variable.Magic */
.highlight .il { color: #0000cf; font-weight: bold } /* Literal.Number.Integer.Long */
endef
export xxxdocs__includes_code_tango_css

docs/LICENSE.md : ; @echo "$$xxxdocs_LICENSE_md" > $@; git add $@
    
define xxxdocs_LICENSE_md
---
title: License
layout: default
---

- This site uses JQuery which is licensed under a [MIT license](https://jquery.org/license/) 
- This site uses Bootstrap which is licensed  under a [MIT license](https://mdbootstrap.com/general/license/)
- The other non-code content of this site is licensed under a [Creative Commons Attribution 4.0 International License](https://github.com/idleberg/Creative-Commons-Markdown/blob/master/4.0/by.markdown).
- The other code content of this code is licenses under a MIT 2-clause license, as follows.

Copyright {{site.about.when}}, {{site.about.who}}

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
endef
export xxxdocs_LICENSE_md

docs/404.md : ; @echo "$$xxxdocs_404_md" > $@; git add $@
    
define xxxdocs_404_md
---
layout: default
permalink: /404.html
---


![](https://www.newbluefx.com/wp-content/uploads/2017/02/robot-error-404.png){:class="img-responsive"}
endef
export xxxdocs_404_md

docs/syllabus.md : ; @echo "$$xxxdocs_syllabus_md" > $@; git add $@
    
define xxxdocs_syllabus_md
---
title: Syllabus
layout: default
---

Theory of Programming Languages   
NCSU, CSC       
Spring 2019  
3 units  
CSC 417-991 (11904)  
Tues/Thurs 4:30 to 5:45     
EE I, Room   1007    

In your professional life you will work with dozens of different programming languages.
What can you learn from 100s of past languages to help you work with your future languages?

## Synopsis


Theory of programming languages with emphasis on programming
language abstractions and implementation issues. Formal models of
syntax and semantics. Static versus dynamic scoping. Parameter passing
mechanisms. Garbage collection. Programming in alternate paradigms such as
applicator, functional, logic, and object-oriented programming languages.


## Staff

### Lecturer

Tim Menzies (Prof)


+ Office Hours: Tuesday, 2:00-4:00 and by request
+ Location of Office Hours: EE II room 3298
+ Slack name: timm
+ Github name: timm
+ E-Mail: timm@ieee.org
  + Only use this email for private matters. All other class 
    communication should be via the class Slack group [http://plm19.slack.com](http://plm19.slack.com).
+ Phone: 304-376-2859
       + **Do not use** this number, except in the most dire of
          circumstances (best way to contact me is via email).


### Teaching assistant

Rahul Krishna, (CSC, Ph.D., May 2019).



+ Office Hours: Monday 11 to 1pm
+ Location of Office Hours: EE2, rm3240
+ Slack name: r.krsn
+ Github name: rahlk


## Group mailing list

During term time, all communication will be via
the Slack group https://plm19.slack.com.
. Students are strongly encouraged to contribute their questions and answers to that shared resource.
+ Note that, for communication of a more private nature, contact the lecturer on the email shown above.


## Prerequisite 

Prerequisite: CSC 316 or ECE 309 or equivalent.

## Texts

### Required


[Exercises in Programming Style](https://www.amazon.com/Exercises-Programming-Style-Cristina-Videira/dp/1482227371)     
by Cristina Videira Lopes    
Chapman and Hall/CRC; 1 edition (June 4, 2014)    
ISBN-10: 1482227371

- [code available on-line](https://github.com/crista/exercises-in-programming-style)
- [Introductory slides](http://gotocon.com/dl/goto-aar-2013/slides/CristinaVideiraLopes_ExercisesInStyle.pdf)


### Suggested

Domain-Specific Languages   
by Martin Fowler   
Addison-Wesley Professional; 1 edition (October 3, 2010)   
ISBN-10: 0321712943 

- [Catalog of DSL patterns](https://martinfowler.com/dslCatalog/)


## Expected Workload
Note that this is a
**programming-intensive** subject that covers many languages
_only some of which the lecturer/GTA have used_.
You will be spending much time in the process of
self-education of different languages.


Sometimes, the lecturer/tutor will require you to attend a review session during their consultation  time. There, students may be asked to review
code, concepts, or comment on the structure of the course. Those sessions are mandatory and failure to attend will result in marks being deducted.

Students MUST be
prepared to dedicate AT LEAST 5-8 working hours a
week to this class (excluding the time spent in the
classroom). Laboratory instruction is not included
in this subject.

## Grades

The following grade scale will be used:

+ A+  (97-100), A (93-96), A-(90-92)
+ B+ (87-89), B (83-86), B-(80-82)
+ C+ (77-79), C (73-76), C-(70-72)
+ D+ (67-69), D (63-66), D-(60-62)
+ F (below 60).

Grades will be added together using:

+ Mid-term  : 24  marks
+ Final Exam : 30 marks
+ Project: 45 marks
    - Work in groups of 3 (Groups  created randomly, see http://tiny.cc/plm19give)

Due dates for the above will shown on subject home page. Late submissions will earn 1 late mark per day (weekend is 1).

## Project


Part1 : 16 marks

- 1+ Grading some other group's homeworks 1abcde (1 mark each). Report to tutor if code does not run
  or if the I/O behavior is not as it should be.
- 1: Writing 4 homeworks 1abcde  (3 mark each)

Part2 : 30 marks (10 per part)

- 2a : Given a data mining pipeline (from the lecturer), replace any one parts of the pipe using
    a different programming language. 
     - FIRST, write a reporting ranking ten abstractions you are thinking
    of trying for that code (where  list includes a short description of each AND a tiny example where that 
    abstraction might be useful).  For a list of abstractions, see below.
     - SECOND, write working code that replicates the i/o of that part of pipe.
    That code should include your attempt to use your top three ranked abstractions (and it is expected
    that you some of your planned abstractions will prove useless). 
     - THIRD add to the report an epilogue
    describing your experience with the abstractions AND your recommendations to other people about
    when to use/to avoid those abstractions. 
     - FOURTH add an end section describing what maximum grades you expect for this section (see below _bonus marks_).
     - FIFTH in some public Github repo (not from NCSU) write
    a sub-directory called "_2a_". Add to that directory your report in pdf format  (I expect 5 pages (no less or more),
    [2 column conference format](https://www.overleaf.com/gallery/tagged/acm-official#.WOuOk2e1taQ) AND
    your working code AND a file canned "run" (that graders will run) AND a text file "run.out" showing the input and output when you run the code.
- 2b : as per 2a but use a different language, and a different part of the pipe and store the outputs to
         a directory "_2b".
- 2c : Grading someone else's group 2 code (not the written report, just checking it works as advertised).
- 2d : bonus marks. as per 2c. Only if allowed by professor. And
   this bonus mark is due same time as 2ab.

List of abstractions

1. See class
2. See the design patters list
3. From the Lopez book
4. From the Fowler book.

Students can develop their project anywhere, anyhow they like but
when they deliver:

- Code must be in a github repo (one per group), not NCSU
- Code must run on command-line Ubunty 16+ on 
  [codeanywhere.com](https://codeanywhere.com/pricing)
- Code must auto-install; i.e. the run script should check the
  environment for missing parts then install those parts.

For example:

```
for i in vim lua clisp  
do if   which $(dollar)i
   then echo "# $(dollar)i installed" 
   else sudo apt-get install $(dollar)i 
   fi
done
```
There is a free [codeanywhere.com](https://codeanywhere.com/pricing)
plan. But, optionally,
students may want to consider _Freelancer_ package.


## Bonus Marks

- Some languages are harder than others. E.g. Python? Easy! But Haskell? Harder! 
- Some parts of the pipe are harder than others.
- Some abstractions are harder than others. E.g. polymorphism? Easy! But monads? Harder!

Later in the term we will we issue _stars_ for each language/parts/abstractions. 

- Zero bonus marks for using _one star_ things. 
- 7% bonus for using _two stars_ things.
- 14% for using _three stars_ things. 

The marks are multiplicative.
So if you use one star things through out then you can score 20 marks for parts 2b,2c.
But if you three star languages, parts, abstractions then 
that would be 20$(slash)*1.14<sup>3</sup> = 30 marks (actually, 29.6 which we'd round to 30).


## Attendance

Attendance is extremely important for your learning
experience in this class. Once you reach three
unexcused absences, each additional absence will
reduce your attendance grade by 10%.

Except for officially allowed reasons, your presence in the class if required from day one.
Late-comers will have to work in their own solo groups (to avoid disruptions to existing groups).

Note that absences for weddings (your own, or someone else's, is not an officially allowed reason).

Exceptions: this subject  will support students who are absent for any of the following
officially allowed reasons:

- Anticipated Absences (cleared with the instructor before the absence).
Examples of anticipated situations include
    - representing an official university function, e.g., participating in a professional meeting, as part of a judging team, or athletic team;
    - required court attendance as certified by the Clerk of Court;
    - religious observances as verified by the Division of Academic and Student Affairs (DASA).
    - Required military duty as certified by the student's commanding officer.
- Unanticipated Absences.  Excuses must be reported to the instructor not more than one week after the return to class.  Examples of unanticipated absences are:
      -  Short-term illness or injury affecting the ability to attend or to be productive academically while in class, or that could jeopardize the health of the individual or the health of the classmates attending.  Students must notify instructors prior to the class absence, if possible, that they are temporarily unable to attend class or complete assignments on time.
      -  Death or serious illnesses in the family when documented appropriately.  An attempt to verify deaths or serious illness will be made by the Division of Academic and Student Affairs.

That support will include changing the schedule of deliverables and/or (in extreme
case) different grading arrangements.


## Academic Integrity

Cheating will be punished to the full extent permitted. Cheating
includes plagerism of other people's work. All students will be working
on public code repositories and **informed reuse** is encouraged where
someone else's product is:

+ Imported and clearly acknowledged (as to where it came from);
+ The imported project is understood, and
+ The imported project is significantly extended.

Students are encouraged to read each others code and report **uninformed reuse**
to the lecturer. The issue will be explored and, if uncovered,
cheating will be reported to the university
and marks will be deducted if the person who is doing the reuse:

+ Does not acknowledge the source of the product;
+ Does not exhibit comprehension of the product when asked about it;
+ Does not significantly extend the product.

All students are expected to maintain traditional
standards of academic integrity by giving proper
credit for all work.  All suspected cases of
academic dishonesty will be aggressively pursued.
You should be aware of the University policy on
academic integrity found in the Code of Student
Conduct.

The  exams will be done individually.  Academic integrity is important.  Do not work together on the exams: cheating on either will be punished to the full extent permitted.

## Disabilities

Reasonable accommodations will be made for students
with verifiable disabilities. In order to take
advantage of available accommodations, students must
register with Disability Services for Students at
1900 Student Health Center, Campus Box 7509,
919-515-7653. For more information on NC State's
policy on working with students with disabilities,
please see the Academic Accommodations for Students
with Disabilities Regulation(REG 02.20.01).

Students are responsible for reviewing the PRRs
which pertain to their course rights and
responsibilities. These include:
http://policies.ncsu.edu/policy/pol-04-25-05 (Equal
Opportunity and Non-Discrimination Policy
Statement), http://oied.ncsu.edu/oied/policies.php
(Office for Institutional Equity and
Diversity),http://policies.ncsu.edu/policy/pol-11-35-01
(Code of Student Conduct), and
http://policies.ncsu.edu/regulation/reg-02-50-03
(Grades and Grade Point Average).

## Non-Discrimination Policy

NC State University provides equality of opportunity
in education and employment for all students and
employees. Accordingly, NC State affirms its
commitment to maintain a work environment for all
employees and an academic environment for all
students that is free from all forms of
discrimination. Discrimination based on race, color,
religion, creed, sex, national origin, age,
disability, veteran status, or sexual orientation is
a violation of state and federal law and/or NC State
University policy and will not be
tolerated. Harassment of any person (either in the
form of quid pro quo or creation of a hostile
environment) based on race, color, religion, creed,
sex, national origin, age, disability, veteran
status, or sexual orientation also is a violation of
state and federal law and/or NC State University
policy and will not be tolerated.

+ Note that, as a lecturer, I am legally required to
  **report** all such acts to the campus policy.

Retaliation
against any person who complains about
discrimination is also prohibited. NC State's
policies and regulations covering discrimination,
harassment, and retaliation may be accessed at
http://policies.ncsu.edu/policy/pol-04-25-05 or
http://www.ncsu.edu/equal_op/. Any person who feels
that he or she has been the subject of prohibited
discrimination, harassment, or retaliation should
contact the Office for Equal Opportunity (OEO) at
919-515-3148.

## Other Information

Non-scheduled class time for field trips or
out-of-class activities are NOT required for this
class. No such trips are currently planned. However,
if they do happen then students are required to
purchase liability insurance. For more information,
see http://www2.acs.ncsu.edu/insurance/
endef
export xxxdocs_syllabus_md

docs/_config.yml : ; @echo "$$xxxdocs__config_yml" > $@; git add $@
    
define xxxdocs__config_yml
url: http://menzies.us/misc
about:
 title: "Jane's Web site"
 who: Jane Donaldson
 when: 2019
 what: 'Purpose, details'
 email: 'timm@ieee.org'
 bold: '006666'
markdown: kramdown
kramdown:
 input: GFM
 auto_ids: true
 hard_wrap: false
 highlighter: rouge
endef
export xxxdocs__config_yml

docs/news.md : ; @echo "$$xxxdocs_news_md" > $@; git add $@
    
define xxxdocs_news_md
---
title: News
layout: default
---

All the that fits to print.
endef
export xxxdocs_news_md

xxxDirs : 
	@mkdir -p docs docs/_includes docs/_layouts

xxx : xxxDirs  docs/tools.md docs/sitemap.md docs/faq.md docs/index.md docs/_layouts/default.html docs/tutorials.md docs/contact.md docs/about.md docs/_includes/style.css docs/_includes/footer.html docs/_includes/banner.html docs/_includes/header.html docs/_includes/code_tango.css docs/LICENSE.md docs/404.md docs/syllabus.md docs/_config.yml docs/news.md
