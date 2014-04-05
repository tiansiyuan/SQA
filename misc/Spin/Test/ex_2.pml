/* http://spinroot.com/spin/Doc/Exercises.pdf ex.2 */

/* a protocol from a paper by Bartlett, Scantlebury, and Wilkinson, 1969 */

#define MAX	4

proctype A(chan inp, out)		/* 'in' is a keyword in spin version 6.0 */
{	byte mt; /* message data */
	bit  vr;
S1:	mt = (mt+1)%MAX;
	out!mt,1;
	goto S2;
S2:	inp?vr;
	if
	:: (vr == 1) -> goto S1
	:: (vr == 0) -> goto S3
	:: printf("MSC: AERROR1\n") -> goto S5
	fi;
S3:	out!mt,1;
	goto S4;
S4:	inp?vr;
	if
	:: goto S1
	:: printf("MSC: AERROR2\n"); goto S5
	fi;
S5:	out!mt,0;
	goto S4
}
proctype B(chan inp, out)
{	byte mr, lmr;
	bit ar;
	goto S2; /* initial state */
S1:	assert(mr == (lmr+1)%MAX);
	lmr = mr;
	out!1;
	goto S2;
S2:	inp?mr,ar;
	if
	:: (ar == 1) -> goto S1
	:: (ar == 0) -> goto S3
	:: printf("MSC: ERROR1\n"); goto S5
	fi;
S3:	out!1;
	goto S2;
S4:	inp?mr,ar;
	if
	:: goto S1
	:: printf("MSC: ERROR2\n"); goto S5
	fi;
S5:	out!0;
	goto S4
}
init {
	chan a2b = [2] of { bit };
	chan b2a = [2] of { byte, bit };
	atomic {
		run A(a2b, b2a);
		run B(b2a, a2b)
	}
}
