# All my config

## Platfroms.

Windows not (yet)s upported. Volunteers anyone?

The default installation platform is `Platform=Ubuntu. 

If installing to Mac then, in the following, replace the phrase


```
make
```

with

```
make Platform=Mac
```



## Downloading ###

Somewhere, store the `Makefile`.

```
wget -O Makefile https://github.com/timm/dot/blob/master/etc/Makefile 
```

## Setting up a new repo

Create a fresh repo and Go to the root of that repo.  Then:

```
mkdir etc
cp path-to-make-file etc/Makefile
git add Makefile
````

Now, install the standard Github files using (e.g.)

```
cd etc
make Who="Tim Menzies" When="2020"                 \
     What="dot.timm.19" Where="github.com/timm/dot"  \ 
     Email="timm@ieee.org" Title="All my config"      \
     github
```

## Installing standard packages

```
cd etc
make packages
```

At the time of this writing, this installs:

- aspell 
- bat  -M
- bsdgames -M
- clisp
- cmatrix
- ctags
- gnuplot
- gnu-smalltalk
- htop
- luajit
- lua5.2
- ncdu
- pip
- pycco
- python3
- ranger
- reattach-to-user=namespace -U
- swi-prolog
- tmux
- tree
- wget

(In the above, -U= "not on unix" and -M= "not on mac".)	
