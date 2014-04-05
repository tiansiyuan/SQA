#!/bin/sh

# installation script for iSpin
# execute in the directory that has the ispin.tcl file 

# on Cygwin: use the TclTk installation 8.4 from Cygwin
# itself -- do not use activestatetcl 8.5 (yet)

BIN=/usr/bin

if [ -d $BIN ]
then
	if [ -f ispin.tcl ]
	then
		cp ispin.tcl $BIN/ispin
		chmod 755 $BIN/ispin
		echo "installed ispin.tcl as $BIN/ispin"
	else
		echo "error: cannot find ispin.tcl"
		exit 1
	fi
else
	echo "error: cannot find installation directory $i"
	exit 1
fi

exit 0
