# Timm's NCSU VCL set up



## Installation

- Set up git

    # replace UPPER case words with your detaiks
    git config --global user.name "FIRST_NAME LAST_NAME"
    git config --global user.email "MY_NAME@EXAMPLE.COM"

- Cd into your eos file space. 

    # replace t/tjmenzie with 1st letter of username, then username
    cd /afs/unity.ncsu.edu/users/t/tjmenzie

- Make a config directory
- Download timmnix.sh
- Run timmnix.sh

    mkdir .config
    cd .config
    wget -O timmnix.sh https://raw.githubusercontent.com/timm/dot/master/ncsu/vcl/timmnix.sh
    bash timmnix.sh

- Then relaunch bash to get everything 
      - log out then login again
      - or do `. $HOME/.bashrc`


