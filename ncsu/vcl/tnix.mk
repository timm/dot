## Tnix v1 : VCL image management tool
## (c) 2019, Tim Menzies, timm@ieee.org
##     
## usage: . tnix    (quick set up)
##        tnix help (list commands)
##        tnix com  (run 1 com)
##      
Julia=1.1.0
define Apts =
aptitude aspell build-essential  \
bsdgames clisp cmatrix ctags gawk gnuplot gnu-smalltalk haskell-platform \
htop luajit lua5.2 mc ncdu nodejs pandoc python-pip python3 \
swi-prolog source-highlight tmux tree vim wget 
endef

Letter=$(shell echo $(USER) | cut -c 1)
Tnix=$(shell echo "/afs/unity.ncsu.edu/users/$(Letter)/$(USER)")

D=https://raw.githubusercontent.com/timm/dot/master/ncsu/vcl
A=sudo apt -qq -y 
C=$(Tnix)/.config

help: tnix.mk
	@sed -n 's/^## //p' $<

## update   : Quick updates (do regularly)
update: os dirs files progs clean

## once     : Some quick updates (to do once)
once: git0 vundle

## install  : Slow updates (skip if do not cannot save image)
install: os apts scripts vim0 pythons fish clean

## all      : Shorthand for install, once, update
all: install once update

scripts: 
	cd $(HOME); \
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - ; \
	sudo npm i -g coffeescript typescript ts-node @types/node

pythons: pip pycco

os:
	$A update
	$A upgrade -y

dirs:
	mkdir -p $C
	mkdir -p $(Tnix)/tmp
	mkdir -p $(Tnix)/opt/julia

files: $C/tnix.mk $C/dotbashrc $C/dottmux $C/dotvimrc $C/tmux-session1 

W=wget -O $@ $D/$@
$C/tnix.mk       : ; $W
$C/dothtop       : ; $W
$C/dotbashrc     : ; $W
$C/dottmux       : ; $W
$C/dotvimrc      : ; $W
$C/tmux-session1 : ; $W

progs: $(HOME)/.config/htop/htoprc $(Tnix)/opt/julia/julia-$(Julia)

$(HOME)/.config/htop/htoprc:
	mkdir -p $(dir $@)
	cp $C/dothtop $@

$(Tnix)/opt/julia/julia-$(Julia):
	mkdir -p $@/bin
	cd $@
	wget -O julia$(Julia).tar.gz https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-$(Julia)-linux-x86_64.tar.gz
	tar xzf julia$(Julia).tar.gz

git0:
	git config --global user.email "$(shell bash -c 'read  -p Enter_your_git_user_email\  ; echo $$REPLY')"
	git config --global user.name  "$(shell bash -c 'read  -p Enter_your_git_user_name\   ; echo $$REPLY')"

apts:
	$A install $(Apts)
	sudo aptitude install npm

pip:
	if [ ! `which pip` ]>&2; then \
     		curl https://bootstrap.pypa.io/get-pip.py -o $(HOME)/get-pip.py; \
     		python $(HOME)/get-pip.py; \
     		rm $(HOME)/get-pip.py; \
  	fi
	sudo -H pip install --upgrade pip

pycco:
	sudo -H pip install pycco

fish:
	if [ ! `which asciiquarium` ]>&2; then \
    		sudo add-apt-repository -y ppa:ytvwld/asciiquarium > /dev/null; \
    		$A update; \
		$A install asciiquarium; \
  	fi

## vim8     : Install Vim8 stuff
vim8: vim0 vundle

vim0:
	sudo add-apt-repository   -y ppa:jonathonf/vim > /dev/null
	$A update
	$A upgrade vim

V=$C/vim/bundle

vundle: $C/dotvimrc
	if [ ! -d "$V" ]; then \
    		mkdir -p $V ;\
    		git clone https://github.com/gmarik/Vundle.vim.git $V; \
  	fi
	-vim  -u "$C/dotvimrc" +PluginInstall +qall 

clean:
	sudo apt autoclean
	sudo apt clean
	sudo apt autoremove

## commit   : Secret stuff, for me
commit: files
	cd $(Tnix)/gits/timm/dot/ncsu/vcl; \
	cp /bin/tnix . ; \
	cp $C/* . ; \
	git add * ; \
	git commit -am saving; \
	git push

