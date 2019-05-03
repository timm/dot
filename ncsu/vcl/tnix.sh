#!/bin/bash

export Tnix="/afs/unity.ncsu.edu/users/`echo $USER | cut -c 1`/$USER"
. $HOME/.bashrc
cd $Tnix
if [ -n "$1" ]; then 
  cd .config
  sudo make -f tnix.mk $1
fi
