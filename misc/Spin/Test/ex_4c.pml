/* http://spinroot.com/spin/Doc/Exercises.pdf ex.4c */

/* faulty mutual exclusion algorithm */

byte cnt;	/* 'in' became a keyword in spin version 6 */
byte x, y, z;
active [2] proctype user()	/* file ex.4c */
{	byte me = _pid+1;			/* me is 1 or 2 */
L1:	x = me;
L2:	if
	:: (y != 0 && y != me) -> goto L1	/* try again */
	:: (y == 0 || y == me)
	fi;
L3:	z = me;
L4:	if
	:: (x != me)  -> goto L1		/* try again */
	:: (x == me)
	fi;
L5:	y = me;
L6:	if
	:: (z != me) -> goto L1			/* try again */
	:: (z == me)
	fi;
L7:						/* success */
	cnt = cnt+1;
	assert(cnt == 1);
	cnt = cnt - 1;
	goto L1
}
