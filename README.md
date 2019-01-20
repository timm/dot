# Easy Install for all my Unix Config Files

_Problem:_ Jumping between containers, want a quick set up in each new environment.

_Solution:_ 

- Get everything sorted into `bashrc` then make it autoinstall
- Built for Codeanywhere  but should work in most Ububtuu 16.0+ envionments


## Installation

    cd dot
    . bashrc

After that, it should just all work, everytime you log in.

## Internals

- Bash config attached to `dot/bashrc`
     - Offers many services including the _Extras_ shown below.
- Vim config files linked to `dot/vimrc`
     - Also, Vim package manager enabled.
- Tmux config files linked to `dot/tmux.conf`

## Extras

Installs:

- Get the latest version of "vim" with `vim0`.
- Get the cool "cat" replacement with `bat0`.

System management:

- Pretty display of current directory contents `ll`.
- Free up disk space with `clean`.

Git tools:

- Save your git passwords (for 1 hour) with `gc` (saves typing when committing code).
- Easy update current git repo with `get`,
- Easy commit of  current git repo with `put`,
- Easy commits for all your git repos with `puts`.
  (use the `GITS` variable in `bashrc`  to define where those repos are).
