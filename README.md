About DOT
=========

This Makefile contains all the config tricks that are global to all my
Mac and Unix installations as well all my Github repos.

The goal here is that if ever I land on a new machine or an empty Ubuntu
container, I can download this Makefile, do the following, then in just
a few minutes I can be up and running in my kinda envrionment:

- Some cool tricks for:
	- mux, vim8, bash and git
- Some standard packages installed: 
	- apsell, bat, ctags, htop, mc, ncdu, pycco, ranger, tmux, 
	  tree, vim8, wget, etc.
- My favorite languages installed: 
	- clisp, gnuplot, gnu-smalltalk, lua, luajit, python-pip, 
          python3, swi-prolog,
- And some silly things: cmatrix, bsdgames (unix only),

I also add "," to the PATH so any directory can have a local
set of executables in `,/`.

To achieve all this, code adds stuff (without overriding) to 
`.bashrc`, `.vimrc`, `.tmux.config`. 

It also creates `~/.config/dot` for all its local config files

Lastly, it esnures that ~/.vim/bundle contains the VIM package manager.

Install Instructions
====================

**IMPORTANT NOTE:** Each of the following assumes that the step before
has been executed before.

Step1: Initial Install
----------------------

Before you do anything else, then anywhere, onetime install.

	make macInstall    all # if mac 
	make ubuntuInstall all # if ubuntu

Note: this could take a few minutes.

Step2: Updates
---------------

Next, if ever u have updated this Makefile and want to push out new
configs

	make -B all

Note: this should be very fast. 

Step3: Making all those Github files
------------------------------------

Next, if you u want to create all those Github files then check out a
repo, cd into its root. Optionally, you might want to write a "my.mk"
file that sets some of the text to be written into the standrrd Github
files (e.g., your email). Anyway, after that, type

	make github LuaIgnore # for a Lua rep
	make github PyIgnore  # for a Python repo

Note: this should be very fast. Existing files will not be overwritten.

