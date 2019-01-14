mkdir -p $HOME/tmp

Files="bashrc gitignore tmux.conf vimrc"

if which lua   > /dev/null; then true; else sudo apt-get -y install lua5.2; fi
if which clisp > /dev/null; then true; else sudo apt-get -y install clisp; fi
if which tmux  > /dev/null; then true; else sudo apt-get -y install tmux; fi
if which swipl > /dev/null; then true; else sudo apt-get -y install swi-prolog; fi
if which gst   > /dev/null; then true; else sudo apt-get -y install gnu-smalltalk; fi

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

PROMPT_COMMAND='echo -ne "${_c6}> \033]0;$(here ../..)/$(here ..)/$(here .)\007";PS1="${_c1}$(here ../..)/$_c2$(here ..)/$_c3$(here .) ${_c6}\!>${_c0}\e[m "'

alias ll='ls -GF'
alias get='git pull'
alias put='git commit -am saving; git pull; git status'
