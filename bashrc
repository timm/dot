mkdir -p $HOME/tmp

Files="bashrc tmux.conf gitignore vimrc"

ok() {
  if which $1 > /dev/null; then 
    true 
  else 
    echo ""
    echo "# ----| $1 |--------------------------------"
    echo ""
    sudo apt-get -y install ${2:-$1}
  fi
}

ok mc
ok tmux  
ok ncdu
ok htop
ok clisp 
ok ranger
ok cmatrix
ok lua   lua5.2
ok gst   gnu-smalltalk
ok swipl swi-prolog

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

_c1="\[\033[01;32m\]"
_c2="\[\033[01;34m\]"
_c3="\[\033[31m\]"
_c6="\033[33m"
_c5="\[\033[35m\]$"
_c0="\[\033[00m\]"
_c7="[\033]01;19\]"

here() { cd $1; basename "$PWD"; }

PROMPT_COMMAND='echo -ne "${_c6}\033]0;$(here ../..)/$(here ..)/$(here .)\007";PS1="${_c1}$(here ../..)/$_c2$(here ..)/$_c3$(here .) ${_c6}\!>${_c0}\e[m "'

alias ll='ls -GF'
alias get='git pull'
alias put='git commit -am saving; git push; git status'
alias gc="git config credential.helper 'cache --timeout=3600'"
