# SPIN - Verification Software - Version 6.2 - May 2012
#
# Copyright  (c) 1989-2006 Lucent Technologies, Bell Labs
# Extensions (c) 2006-2012 NASA/JPL California Institute of Technology
# All Rights Reserved. For educational purposes only.
# No guarantee whatsoever is expressed or implied by
# the distribution of this code.
#
# Written by:    Gerard J. Holzmann
# Documentation: http://spinroot.com/
# Bug-reports:   bugs@spinroot.com 
# or:            http://spinroot.com/forum/

# see also ./make_pc for a simpler script, not requiring make

CC=gcc
CFLAGS=-O2 -DNXT	# on some systems add: -I/usr/include

# CFLAGS=-g -O2 -DNXT

# CC=gcc -m32 	# 32bit compilation on a 64bit system
# for a more picky compilation use gcc-4 and:
# CFLAGS=-std=c99 -Wstrict-prototypes -pedantic -fno-strength-reduce -fno-builtin -W -Wshadow -Wpointer-arith -Wcast-qual -Winline -Wall -g -DNXT -DPC

# on OS2:		spin -Picc -E/Pd+ -E/Q+
# for Visual C++:	spin -PCL  -E/E

#	on PC:		add -DPC to CFLAGS above
#	on Solaris:	add -DSOLARIS
#	on MAC:		add -DMAC
#	on HP-UX:	add -Aa
#			and add $(CFLAGS) to the spin.o line: $(CC) $(CFLAGS) -c y.tab.c
#	on __FreeBSD__: omit -D_POSIX_SOURCE
#	also recognized: __FreeBSD__ and __OpenBSD__ and __NetBSD__

YACC=yacc		# on Solaris: /usr/ccs/bin/yacc
YFLAGS=-v -d 		# creates y.output and y.tab.h

SPIN_OS= spinlex.o sym.o vars.o main.o ps_msc.o \
	mesg.o flow.o sched.o run.o pangen1.o pangen2.o \
	pangen3.o pangen4.o pangen5.o guided.o dstep.o \
	structs.o pc_zpp.o pangen6.o pangen7.o reprosrc.o

TL_OS=	tl_parse.o tl_lex.o tl_main.o tl_trans.o tl_buchi.o \
	tl_mem.o tl_rewrt.o tl_cache.o

spin:	$(SPIN_OS) $(TL_OS) spin.o
	$(CC) $(CFLAGS) -o spin spin.o $(SPIN_OS) $(TL_OS)

spin.o:	spin.y
	$(YACC) $(YFLAGS) spin.y
	$(CC) -c y?tab.c
	rm -f y?tab.c
	mv y?tab.o spin.o

$(SPIN_OS): spin.h spin.o

$(TL_OS): tl.h spin.o

main.o pangen2.o ps_msc.o: version.h
pangen1.o: pangen1.h pangen3.h pangen6.h
pangen2.o: pangen2.h pangen4.h pangen5.h pangen7.h

clean:
	rm -f spin *.o y?tab.[ch] y.output y.debug
	rm -f pan.[chmotb] a.out core *stackdump
