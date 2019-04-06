
Install Instructions
====================

**IMPORTANT NOTE:**
Each of the following assumes that the step before has
been executed before.

Step1: Initial Install
----------------------

Before you do anything else, then anywhere, onetime install.

	make macInstall    all # if mac 
	make ubuntuInstall all # if ubuntu

Note: this could take a few minutes.

Step2: Updates
---------------

Next, if ever u have updated this Makefile and want to push out new configs

	make -B all

Note: this should be very fast. 

Step3: Making all those Github files
------------------------------------

Next, if you u want to create all those Github files then
check out a repo, cd into its root. Optionally, you  
might want to write a "my.mk" file that sets some of
the text to be written into the standrrd Github files
(e.g., your email). Anyway, after that, type 

	make github LuaIgnore # for a Lua rep
	make github PyIgnore  # for a Python repo

Note: this should be very fast. Existing files
will not be overwritten.

