#!/usr/bin/env make -f

Lang     = Any# or Lua or Py
Platform = Ubuntu# or Mac
What     = Github101#
Who      = Tim Menzies#
When     = 2018,2019#
Email    = timm@ieee.org#
Title    = Init methods for a repo#
Where    = github.com/timm/dot/#
dTmp     = $(HOME)/tmp#
dTests   = ../tests#
dSrc     = ../src#
dData    = $(dTests)/data#
dDoc     = ../docs#
dEtc     = $(dSrc)/my#
dDirs    = $(dTmp) $(dSrc) $(dTests) $(dData) $(dDoc) $(dEtc)#

MAKER    = $(MAKE) --no-print-directory#

default:
	echo 1

############################################################
all: dirs github

#heres luas txts mds chmods
chmods: ; @chmod +x $(Here)/*

heres: $(Here)/blank.lua 
lua:  ~/.gitignore use.lua $(Tests)/use.lua
txt:  ../.gitignore ../requirements.txt 
md :  ../CITATION.md ../CONTRIBUTING.md ../CODE_OF_CONDUCT.md ../LICENSE.md

.PHONY: dirs
dirs: 
	@$(foreach d,$(dDirs),        \
	      if [ ! -d "$d" ]; then   \
                echo mkdir $d; mkdir $d; \
                touch $d/README.md; git add $d/README.md; fi;)

############################################################
define aptget
   if [ ! `which $(1)` ]>&2; then sudo apt-get -y install $(2);fi
endef

define brew
  if [ ! `which brew` ] >&2; then\
    /usr/bin/ruby -e \
       $(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install) ; fi
  if [ ! `which $(1)` ] >&2; then brew install $(2); fi
endef

packages:
	@$(MAKER) $(Platform)Packages
	
UbuntuPackages:
	sudo apt-get update
	$(call aptget,aspell,aspell)
	$(call aptget,clisp,clisp)
	$(call aptget,cmatrix,cmatrix)
	$(call aptget,ctags,ctags)
	$(call aptget,gnuplot,gnuplot)
	$(call aptget,gst,gnu-smalltalk)
	$(call aptget,htop,htop)
	$(call aptget,luajit,luajit)
	$(call aptget,lua,lua)
	$(call aptget,lua,lua5.2)
	$(call aptget,ncdu,ncdu)
	$(call aptget,pip,python-pip)
	$(call aptget,pycco,pycco)
	$(call aptget,python,python3)
	$(call aptget,ranger,ranger)
	$(call aptget,robots,bsdgames)
	$(call aptget,reattach-to-user-namespace,reattach-to-user-namespace)
	$(call aptget,swipl,swi-prolog)
	$(call aptget,tmux,tmux)
	$(call aptget,tree,tree)
	$(call aptget,wget,wget)
	sudo apt autoclean
	sudo apt-get clean
	sudo apt autoremove
	cd $(dTmp); \
	wget https://github.com/sharkdp/bat/releases/download/v0.6.1/bat_0.6.1_amd64.deb; \
	sudo dpkg -i bat_0.6.1_amd64.deb

UnbuntuBat: dirs
	cd $(dTmp)
	wget -nc https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb
	sudo dpkg -i bat_0.9.0_amd64.deb
	rm  bat_0.9.0_amd64.deb

MacPackages: 
	@sudo easy_install pip
	@if [ ! `which pycco`  ] >&2; then sudo -H pip install pycco; fi
	@(call brew,aspell,aspell)
	@(call brew,clisp,clisp)
	@(call brew,cmatrix,cmatrix)
	@(call brew,ctags,ctags)
	@(call abrew,gnuplot,gnuplot)
	@(call brew,gst,gnu-smalltalk)
	@(call brew,htop,htop)
	@(call brew,luajit,luajit)
	@(call brew,lua,lua)
	@(call brew,lua,lua5.2)
	@(call brew,ncdu,ncdu)
	@(call brew,pycco,pycco)
	@(call brew,python,python3)
	@(call brew,ranger,ranger)
	@(call brew,reattach-to-user-namespace,reattach-to-user-namespace)
	@(call brew,swipl,swi-prolog)
	@(call brew,tmux,tmux)
	@(call brew,tree,tree)
	@(call brew,wget,wget)

~/.gitignore:
	@$(MAKER) $(Lang)ignore > $@; git add $@

LuaIgnore: ; @echo "$$MacSkip$$VimSkip$$LuaSkip" 
AnyIgnore: ; @echo "$$MacSkip$$VimSkip"          
PyIgnore:  ; @echo "$$MacSkip$$VimSkip$$PySkip"  

github: dirs ../LICENSE.md ../CITATION.md ../CONTRIBUTING.md ../requirements.txt ../CODE_OF_CONDUCT.md
	 
../LICENSE.md         : ; echo "$$LICENSE"  > $@; git add $@
../CITATION.md        : ; echo "$$CITATION" > $@; git add $@
../CONTRIBUTING.md    : ; echo "$$CONTRIB"  > $@; git add $@
../requirements.txt   : ; echo "$$REQUIRES" > $@; git add $@
../CODE_OF_CONDUCT.md : ; echo "$$CONDUCT"  > $@; git add $@

#use.lua               : ; echo "$$USE"      > $@; git add $@
#$(Tests)/use.lua      : ; echo "$$USE"      > $@; git add $@
#$(Here)/blank.lua     : ; echo "$$BLANK"    > $@; git add $@

############################################################
define REQUIRES
lua>=5.1
luajit>=5.1
pycco>=0.6
python>=3.7
endef
export REQUIRES

############################################################
define LuaSkip
### Lua ###
# Compiled Lua sources
luac.out

# luarocks build files
*.src.rock
*.zip
*.tar.gz

# Object files
*.o
*.os
*.ko
*.obj
*.elf

# Precompiled Headers
*.gch
*.pch

# Libraries
*.lib
*.a
*.la
*.lo
*.def
*.exp

# Shared objects (inc. Windows DLLs)
*.dll
*.so
*.so.*
*.dylib

# Executables
*.exe
*.out
*.app
*.i*86
*.x86_64
*.hex
endef
export LuaSkip

############################################################
define VimSkip
### Vim ###
[._]*.s[a-w][a-z]
[._]s[a-w][a-z]
*.un~
Session.vim
.netrwhist
*~
endef 
export VimSkip

############################################################
define MacSkip
### Mac  ###
# General
.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon

# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk
endef 
export MacSkip

############################################################
define PySkip
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
.python-version

# pipenv
#   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
#   However, in case of collaboration, if having platform-specific dependencies or dependencies
#   having no cross-platform support, pipenv may install dependencies that don’t work, or not
#   install all needed dependencies.
#Pipfile.lock

# celery beat schedule file
celerybeat-schedule

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/
endef
export PySkip

############################################################
define CITATION

# CITATION

Please cite this as

- $(Who), _$(Title)_, $(When)

Bibtex:

    @misc{$(What),
      author="$(Who)",
      year="$(When)",
      title="$(Title)",
      note="Download from http://$(Where)"
    }
endef
export CITATION

############################################################
define CONDUCT

# Contributor Covenant Code of Conduct

## Our Pledge

In the interest of fostering an open and welcoming environment, we
as contributors and maintainers pledge to making participation in
our project and our community a harassment-free experience for
everyone, regardless of age, body size, disability, ethnicity, sex
characteristics, gender identity and expression, level of experience,
education, socio-economic status, nationality, personal appearance,
race, religion, or sexual identity and orientation.

## Our Standards

Examples of behavior that contributes to creating a positive
environment include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome 
  sexual attention or advances
* Trolling, insulting/derogatory comments, and personal 
  or political attacks 
* Public or private harassment 
* Publishing others' private information, such as a 
  physical or electronic address, without explicit permission
* Other conduct which could reasonably be considered 
  inappropriate in a professional setting

## Our Responsibilities

Project maintainers are responsible for clarifying the standards
of acceptable behavior and are expected to take appropriate and
fair corrective action in response to any instances of unacceptable
behavior.

Project maintainers have the right and responsibility to remove,
edit, or reject comments, commits, code, wiki edits, issues, and
other contributions that are not aligned to this Code of Conduct,
or to ban temporarily or permanently any contributor for other
behaviors that they deem inappropriate, threatening, offensive, or
harmful.

## Scope

This Code of Conduct applies both within project spaces and in
public spaces when an individual is representing the project or its
community. Examples of representing a project or community include
using an official project e-mail address, posting via an official
social media account, or acting as an appointed representative at
an online or offline event. Representation of a project may be
further defined and clarified by project maintainers.

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior
may be reported by contacting the project team at $(Email).
All complaints will be reviewed and investigated and will result
in a response that is deemed necessary and appropriate to the
circumstances. The project team is obligated to maintain confidentiality
with regard to the reporter of an incident.  Further details of
specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct
in good faith may face temporary or permanent repercussions as
determined by other members of the project's leadership.

## Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage],
version 1.4, available at
https://www.contributor-covenant.org/version/1/4/code-of-conduct.html

[homepage]: https://www.contributor-covenant.org

For answers to common questions about this code of conduct, see
https://www.contributor-covenant.org/faq

endef
export CONDUCT

############################################################
define LICENSE

# LICENSE

$What  Copyright (c) $When, $Who
All rights reserved, BSD 3-Clause License

Redistribution and use in source and binary forms, with
or without modification, are permitted provided that
the following conditions are met:

- Redistributions of source code must retain the above
  copyright notice, this list of conditions and the 
  following disclaimer.
- Redistributions in binary form must reproduce the
  above copyright notice, this list of conditions and the 
  following disclaimer in the documentation and/or other 
  materials provided with the distribution.
- Neither the name of the copyright holder nor the names 
  of its contributors may be used to endorse or promote 
  products derived from this software without specific 
  prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

endef
export LICENSE

############################################################
define LuaBlank
-- vim: ft=lua ts=2 sw=2 sts=2 et : cindent : formatoptions+=cro
-- $(What) copyright (c) $(When) $(Who), $(Email)
-- All rights reserved, opensource.org/licenses/BSD-3-Clause
-- For examples of usage, see $(Tests)/xxx.lua.
--------- --------- --------- --------- --------- --------- ---------

local Object=require('use')('src/lib.lua')

--------- --------- --------- --------- --------- --------- ---------
return isMain('lib') and rogues() 
endef 
export LuaBlank

############################################################
define USE
-- vim: ft=lua ts=2 sw=2 sts=2 et : cindent : formatoptions+=cro
-- $(What) copyright (c) $(When) $(Who), $(Email)
-- All rights reserved, opensource.org/licenses/BSD-3-Clause
--------- --------- --------- --------- --------- --------- ---------

local root = '../'
local seen = {}

function use(f, show)
  if not seen[f] then 
    if show then io.stderr:write('-- ' .. f .. '\n') end
    seen[f] = dofile(root .. f)
  end 
  return seen[f]
end 

return use
endef 
export USE




