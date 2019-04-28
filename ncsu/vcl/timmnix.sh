trap "set +x" 0 1 2 3 9 15
export Dot="/afs/unity.ncsu.edu/users/$(echo $USER | cut -c 1)/$USER/.config"

get="sudo apt -qq -y "

files() {
  local web='https://raw.githubusercontent.com/timm/dot/master/ncsu/vcl'
  for f in timmnix dotbashrc dottmux dotvimrc tmux-session1 ; do
    if [ ! -f "$f" ]; then
      wget -O $f $web/$f
    fi
  done
  cp timmnix $HOME
  chmod +x $HOME/timmnix
}

os() {
  $get update
  $get upgrade
}

julia11() {
	mkdir -p $HOME/opt/julia
	cd $HOME/opt/julia
	wget -O julia1.1.0.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.0-linux-x86_64.tar.gz
	tar xzf julia1.1.0.tar.gz
}
lots() {
  $get install vim aspell clisp ctags gawk gnuplot gnu-smalltalk htop luajit lua5.2 mc ncdu python-pip pfyd
  $get install nodejs npm
  $get install haskell-platform pandoc
  #sudo npm install -g typescript
  #sudo npm install -g codescript
  curl https://bootstrap.pypa.io/get-pip.py -o $HOME/get-pip.py
  sudo python $HOME/get-pip.py
  rm $HOME/get-pip.py
  sudo -H pip install --upgrade pip
  $get install python3 swi-prolog tmux tree wget source-highlight
  # lit programming stuff
  sudo -H pip install pycco
}

fun() {
  $get  install bsdgames cmatrix
  sudo add-apt-repository   -y ppa:ytvwld/asciiquarium > /dev/null
  $get update 
  $get install asciiquarium
}

bashing() {
  Bashrc=$Dot/dotbashrc
  There=$HOME/.bashrc
  (grep ". $Bashrc" $There || echo ". $Bashrc" >> $There )>/dev/null
}

vim8() {
  sudo add-apt-repository   -y ppa:jonathonf/vim > /dev/null
  $get update
  $get upgrade vim
}

vundle() {
  mkdir -p $Dot/tmp
  local d="$Dot/vim/bundle"
  if [ ! -d "$d" ]; then
    mkdir -p $d
    git clone https://github.com/gmarik/Vundle.vim.git $d
  fi
  vim -u dotvimrc +PluginInstall +qall 
}

set -x
files; os;
lots; fun;
julia11
bashing
vim8; vundle
sudo apt autoclean
sudo apt clean
sudo apt autoremove
set +x 
