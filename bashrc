#!/usr/bin/env bash

# config
DOT="$HOME/gits/timm/dot"
Files="bashrc tmux.conf gitignore vimrc"
GITS="$HOME/workspace $HOME/gits/[A-Za-z0-9_]*/[A-Za-z0-9_]*"

want() {
	got mc
	got tree  
	got tmux  
	got ncdu
	got htop
	got clisp 
	got aspell
	got ranger
	got cmatrix
	got lua    lua5.2
	got gst    gnu-smalltalk
	got swipl  swi-prolog
	got robots bsdgames
}

# end config
# ######################################################

# colors
White="\033[00m"
Red="\033[31m"
Green="\033[01;32m"
Yellow="\033[33m"
Blue="\033[01;34m"
Purple="\033[35m$"
Turquoise="\033[36m$"

_c0="\[${White}\]"
_c1="\[$Green\]"
_c2="\[$Blue\]"
_c3="\[$Red\]"
_c5="\[$Purple\]$"
_c6="$Yellow"
_c7="$Turquoise"

got() { # internal: install if not installed
  if which $1 > /dev/null; then 
    true 
  else 
    echo ""
    echo -e "${Yellow}# ----| $1 |--------------------------------${White}"
    echo ""
    sudo apt-get -y install ${2:-$1}
  fi
}
clean() { # optinally, reclaim as much hard drive as you can
  sudo apt autoclean
  sudo apt-get clean
  sudo apt autoremove
}
aclock0() {
  (cd $HOME/bin
  wget -O aclock 'https://github.com/tenox7/aclock/blob/master/binaries/x86/aclock-i386-linux2?raw=true'
  chmod +x aclock)
}
bat0() { # optinally, install the very cool "bat" replacement for "cat"
  cd $HOME/tmp
  wget -nc https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb
  sudo dpkg -i bat_0.9.0_amd64.deb
  rm  bat_0.9.0_amd64.deb
}
vim0() { # optionally, get the latest version of vim
  echo -e "${Yellow}Vim8 update. Takes about a minute.${White}"
  read -t 10 -p "Continue? [Cnt-C to abort]"
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt update
  sudo apt-get upgrade vim
  if [ ! -d "$HOME/.vim/bundle" ]; then
     git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
     vim +PluginInstall +qall 
  fi
}
puts() { # push all unsaved changes in all github repos
  for d in $GITS; do
    if [ -d "$d" ]; then
      printf "\n${Yellow}#---| $d |-----------${White}\n"
      (cd $d
      git commit -am saving; git  push
      )
    fi
  done
}

###########################
# make the prompty pretty
here() { cd $1; basename "$PWD"; }

PROMPT_COMMAND='echo -ne "${_c6}\033]0;$(here ../..)/$(here ..)/$(here .)\007";PS1="${_c1}$(here ../..)/$_c2$(here ..)/$_c3$(here .) ${_c6}\!>${_c0}\e[m "'

##########################
# useful aliases
alias ll='ls -GF'
alias get='git pull'
alias put='git commit -am saving; git push; git status'
alias gc="git config credential.helper 'cache --timeout=3600'"
alias vi=vim

##########################
#### start up

# create my usual dirs
mkdir -p $HOME/tmp $HOME/bin

# install stuff if it aint already there
# call 'clean'  after the above installs
want

# ensure certain $HOME/.dotfiles exists
for f in $Files; do
  g=$HOME/workspace/$f
  h=$HOME/.$f
  if [ -f "$g" ]; then
    if [ ! -f "$h" ]; then 
      echo "# $h"
      ln -sf $g $h 
    fi 
  fi
done

# ensure $HOME/.bashrc loads this file
LINE=". $DOT/bashrc"
FILE=$HOME/.bashrc
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
