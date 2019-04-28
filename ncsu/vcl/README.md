# Timm's NCSU VCL set up



## Installation

- Set up git

	# replace UPPER case words with your details
	# e.g. git config --global user.name "Tim Menzies"
	# e.g. git config --global user.email "timm@ieee.org"

	git config --global user.name "FIRST_NAME LAST_NAME"
	git config --global user.email "MY_NAME@EXAMPLE.COM"
	git config --global push.default simple

- Cd into your eos file space. 

	# replace U/USERNAME with 1st letter of username, then username
	# e.g. cd /afs/unity.ncsu.edu/users/t/tjmenzie

	cd /afs/unity.ncsu.edu/users/U/USERNAME

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


