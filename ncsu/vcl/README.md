<img align=right src="http://gentlebytes.com/images/home/product-appledoc.png" width=300>

# Timm's NCSU VCL set up

NCSU's VCL facility is nice, but it has some interesting quirks. For example:

- Everytime you log back into an image to `$HOME`, its a fresh copy of that image;
- So for persistent file storage, VCL users have a seperate file storage space over in (e.g.) `/afs/unity.ncsu.edu/users/t/tjmenzie`. 

This makes installations... interesting. The following code adds lots of cool tool, then writes the
config files to (e.g.) `/afs/unity.ncsu.edu/users/t/tjmenzie/.config`.


## What this gives you

### A Better Work Environment (with Tmux)

Tmux lets you have multiple resizable text panes inside multiple windows.
If the net conenction goes down, `tmux` saves
the session and you can start up, just where you were, using `tmux attach`.

For an exaple of this environment in action, here are two windows. The first shows:

- top left: some `vim` text editting with a little file treel
- bottom right: the `Julia` interpreter running
- top right: the `htop` system monitor
- middle-right: a shell for bash commands
- bottom-right: the midnight commander file manager

<center><a href="work.png"><img src="work.png" width=900></a></center>

The second window shows for text games in four panes:

<center><a href="play.png"><img src="play.png" width=900></a></center>


<table>
<tr>
<td valign=top>
<h3><a id="user-content-a-better-shell" class="anchor" aria-hidden="true" href="#a-better-shell"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>And a Better Shell</h3>

<p>Tools that know how to read their config files from persistent disk memory:
e.g. <code>tmux</code>,
<code>vim</code>


<p>Command line prompts that show:
current <code>git</code> branch;
just the top 3 directories;
hostname.

<p>Simpler <code>git</code> control
<ul>
<li>get = <code>git pull</code></li>
<li>put = <code>git commit -am saving; git push; git status</code></li>
</ul>
<p>Syntax highlighting added to the <code>less</code> pager.

</td>
<td valign=top>
<h3><a id="user-content-a-better-vim" class="anchor" aria-hidden="true" href="#a-better-vim"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>And a Better VIM</h3>
<p><code>Vim8</code>, of course, with
config files written to persistent part of disk memory.
<p>My Vim includes
syntax highlighting,
incremental search (with highlighting),
a better status line,
better colors enabled,
pane seperator colors muted.
<p>My Vim also includes
the Vundle package manager installed, which in turn lets me install:
<ul>
<li><code>nerdtree</code></li>
<li>various color schemes</li>
<li>and other cool stuff</li>
</ul>
</td>
<td valign=top>
<h3><a id="user-content-lottsa-pre--stuff-installed" class="anchor" aria-hidden="true" href="#lottsa-pre--stuff-installed"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Also, pre-installed...</h3>
<p>Documentation tools:
<code>apsell</code>, <code>pandoc</code>, <code>pycco</code>.

<p>Editting tools:
<code>vim8</code> with <code>Nerdtree</code> and other cool tools.
<p>File management tools:
<code>mc</code>, <code>tree</code>, <code>wget</code>.

<p>Fun:
<code>bsdgames</code>, <code>cmatric</code>, <code>asciiquarium</code>.

<p>Languages:
<code>clisp</code>, <code>gawk</code>, <code>gnu-smalltalk</code>, <code>javascript</code>, <code>haskell</code>, <code>lua</code>, <code>luajit</code>, <code>python</code>, <code>python3</code>, <code>swi-prolog</code>.

<p>Plotting:
<code>gnuplot</code>.

<p>Programming utilities:
<code>pip</code>,
<code>ctag</code>.

<p>Session management tools:
<code>tmux</code>.

<p>System monitoring:
<code>htop</code>, <code>ncdu</code>, <code>pfyd</code>.

</td>
</tr></table>

## How to Use

Run the install instructions, below. Only do that once

Then, each time you log in, in the log directory, run...

```sh
. $HOME/timmnix
```

## Installation (Only Do Once)

In this install, all config files are written to EOS space
(since, in VCL, everything in the login directories are reset every login).

### Step1: Set up git

```sh
# replace UPPER case words with your details
# e.g. git config --global user.name "Tim Menzies"
# e.g. git config --global user.email "timm@ieee.org"

git config --global user.name "FIRST_NAME LAST_NAME"
git config --global user.email "MY_NAME@EXAMPLE.COM"
git config --global push.default simple
```

### Step2: Cd into your eos file space. 

```sh
# replace U/USERNAME with 1st letter of username, then username
# e.g. cd /afs/unity.ncsu.edu/users/t/tjmenzie

cd /afs/unity.ncsu.edu/users/U/USERNAME
```

### Step3: For the conf directory:

- First make that director
- Then download timmnix.sh
- Then run `timmnix.sh`

```sh
mkdir .config
cd .config
wget -O timmnix.sh https://raw.githubusercontent.com/timm/dot/master/ncsu/vcl/timmnix.sh
bash timmnix.sh
```

If you see something like the following errors, just ignore them:

- E: Unable to change to /afs/unity.ncsu.edu/users/t/tjmenzie/.config/ - chdir (13: Permission denied)
- DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020.

### Step4: Then relaunch bash to get everything 

- Log out then login again
- Or do `. $HOME/.bashrc`

### Step5: Test

1. Run the command `tmux`. Ignore any errors you see.
2. Press control-space. Then press shift-S. You should then see something like the above screenshots.
3. Try grabbing a pane boundary with the mouse.
   Check that you can resize something.
4. Leave tmux  by pressing `control-space`. Then
   press `d`. This should take you back to the shell.
5. Return to your old `tmux` session. Run `tmux attach`. Check you can see you resized pane.

