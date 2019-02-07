#!/usr/bin/env bash

# config
DOT="$HOME/gits/timm/dot"
Files="bashrc tmux.conf gitignore vimrc"
GITS="$HOME/workspace $HOME/gits/[A-Za-z0-9_]*/[A-Za-z0-9_]*"

want() {
	got mc
	got wget  
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
}
like() {
	got robots bsdgames
        echo "if u want games, use "
        echo "https://gist.github.com/jdmartin/24807e561fe8f90eca256f4e3b92c7fa"
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

box="$(uname -s)"
case "${unameOut}" in
    Linux*)     box=Linux;;
    Darwin*)    box=Mac;;
    CYGWIN*)    box=Cygwin;;
    MINGW*)     box=MinGw;;
    *)          box="UNKNOWN:${unameOut}"
esac

got() { # internal: install if not installed
  if which $1 > /dev/null; then 
    true 
  else 
    echo ""
    echo -e "${Yellow}# ----| $1 |--------------------------------${White}"
    echo ""
    machine
    if [ "$box" == "Linux" ]; then
      sudo apt-get -y install ${2:-$1}
    else
      echo "installing ${2:-$1}"
      brew install ${2:-$1}
    fi
  fi
}
clean() { # optinally, reclaim as much hard drive as you can
  sudo apt autoclean
  sudo apt-get clean
  sudo apt autoremove
}
mac-bat0() { # optinally, install the very cool "bat" replacement for "cat"
  brew install bat
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
  if [ "$box" == "Linux" ]; then
      sudo apt-get -y install ${2:-$1}
      sudo add-apt-repository ppa:jonathonf/vim
      sudo apt update
      sudo apt-get upgrade vim
  else
      brew unlink macvim
      brew install vim
      brew upgrade vim
  fi
  if [ ! -d "$HOME/.vim/bundle" ]; then
     git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
     vim +PluginInstall +qall 
  fi
}
brew0() {
  if [ "$box" == "Mac" ]; then
       if which brew > /dev/null; then 
         true 
       else 
         /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
       fi
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
alias vi=vim
alias matrix="cmatrix -bs -u 6"
alias mc='mc -x'
alias ll='ls -GF'
alias get='git pull'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias put='git commit -am saving; git push; git status'
alias gc="git config credential.helper 'cache --timeout=3600'"

##########################
#### start up

# create my usual dirs
mkdir -p $HOME/tmp $HOME/bin

# install stuff if it aint already there
# call 'clean'  after the above installs
brew0
want

# ensure certain $HOME/.dotfiles exists
for f in $Files; do
  g=$HOME/gits/timm/dot/$f
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
  if [ ! -f "$FILE" ]; then touch $FILE; fi
  grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# ensure $HOME/.profile $HOME/.bashrc
  LINE=". $HOME/.bashrc"
  FILE=$HOME/.profile
  if [ ! -f "$FILE" ]; then touch $FILE; fi
  grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
