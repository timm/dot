# Timm's NCSU VCL set up


## What this gives you

### Lottsa stuff installed

### A Better Shell

### A Better Tmux

### A Better VIM

 
## Installation

In this install, all config files are written to EOS space
(since, in VCL, everything in the login directories are reset every login).

_Step1:_ Set up git

```sh
# replace UPPER case words with your details
# e.g. git config --global user.name "Tim Menzies"
# e.g. git config --global user.email "timm@ieee.org"

git config --global user.name "FIRST_NAME LAST_NAME"
git config --global user.email "MY_NAME@EXAMPLE.COM"
git config --global push.default simple
```

_Step2:_ Cd into your eos file space. 

```sh
# replace U/USERNAME with 1st letter of username, then username
# e.g. cd /afs/unity.ncsu.edu/users/t/tjmenzie

cd /afs/unity.ncsu.edu/users/U/USERNAME
```

_Step3:_ For the conf directory:

- First make that director
- Then download timmnix.sh
- Then run `timmnix.sh`

```sh
mkdir .config
cd .config
wget -O timmnix.sh https://raw.githubusercontent.com/timm/dot/master/ncsu/vcl/timmnix.sh
bash timmnix.sh
```

_Step4:_ Then relaunch bash to get everything 

- log out then login again
- or do `. $HOME/.bashrc`


