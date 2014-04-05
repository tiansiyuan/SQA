/* http://spinroot.com/spin/Doc/Exercises.pdf ex.5b */

/* Petri net from a paper by Berthelot & Terrat, 1982 */

#define Place	byte	/* assume < 256 tokens per place */

Place P1, P2, P4, P5, RC, CC, RD, CD;
Place p1, p2, p4, p5, rc, cc, rd, cd;

#define inp1(x)		(x>0) -> x=x-1
#define inp2(x,y)	(x>0&&y>0) -> x = x-1; y=y-1
#define out1(x)		x=x+1
#define out2(x,y)	x=x+1; y=y+1

init			/* file ex.5b */
{	P1 = 1; p1 = 1;	/* initial marking */
	do
	:: atomic { inp1(P1)	-> out2(rc,P2)	}	/* DC */
	:: atomic { inp2(P2,CC)	-> out1(P4)	}	/* CA */
	:: atomic { inp1(P4)	-> out2(P5,rd)	}	/* DD */
	:: atomic { inp2(P5,CD)	-> out1(P1)	}	/* FD */
	:: atomic { inp2(P1,RC)	-> out2(P4,cc)	}	/* AC */
	:: atomic { inp2(P4,RD) -> out2(P1,cd)	}	/* AD */
	:: atomic { inp2(P5,RD)	-> out1(P1)	}	/* DA */

	:: atomic { inp1(p1)	-> out2(RC,p2)	}	/* dc */
	:: atomic { inp2(p2,cc)	-> out1(p4)	}	/* ca */
	:: atomic { inp1(p4)	-> out2(p5,RD)	}	/* dd */
	:: atomic { inp2(p5,cd)	-> out1(p1)	}	/* fd */
	:: atomic { inp2(p1,rc)	-> out2(p4,CC)	}	/* ac */
	:: atomic { inp2(p4,rd) -> out2(p1,CD)	}	/* ad */
	:: atomic { inp2(p5,rd)	-> out1(p1)	}	/* da */
	od
}
