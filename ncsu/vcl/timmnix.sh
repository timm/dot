
. ./dot

get="sudo apt-get -qq -y "
set -x

os() {
	$get update
	$get upgrade
}

lots() {
	$get install aspell clisp ctags gnuplot gnu-smalltalk htop luajit lua5.2 mc ncdu python-pip 
	sudo -H pip install --upgrade pip
	$get install python3 swi-prolog tmux tree wget
	# lit programming stuff
	sudo -H pip install pycco
}

fun() {
	$get  install bsdgames cmatrix
	sudo add-apt-repository  -y ppa:ytvwld/asciiquarium
	$get update 
	$get install asciiquarium
}

bashing() {
	Bashrc=$Dot/dotbashrc
	There=$HOME/.bashrc
	(grep ". $Bashrc" $There || echo ". $Bashrc" >> $There )>/dev/null
}

vim8() {
	sudo add-apt-repository  -y ppa:jonathonf/vim
	$get update
	$get upgrade vim
}

vundle() {
	mkdir -p $Dot/vim/bundle
	mkdir -p $Dot/tmp
	cd $Dot/vim/bundle
	git clone https://github.com/gmarik/Vundle.vim.git
	vim +PluginInstall +qall 
}

os
lots
fun
bashing
vim8
vundle
