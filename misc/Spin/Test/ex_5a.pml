/* http://spinroot.com/spin/Doc/Exercises.pdf ex.5a */

/* simple model of a Petri Net */

#define Place	byte	/* assume < 256 tokens per place */

Place p1, p2, p3;
Place p4, p5, p6;
#define inp1(x)		(x>0) -> x=x-1
#define inp2(x,y)	(x>0&&y>0) -> x = x-1; y=y-1
#define out1(x)		x=x+1
#define out2(x,y)	x=x+1; y=y+1
init
{	p1 = 1; p4 = 1;	/* initial marking */
	do
/*t1*/	:: atomic { inp1(p1)	-> out1(p2) }
/*t2*/	:: atomic { inp2(p2,p4)	-> out1(p3) }
/*t3*/	:: atomic { inp1(p3)	-> out2(p1,p4) }
/*t4*/	:: atomic { inp1(p4)	-> out1(p5) }
/*t5*/	:: atomic { inp2(p1,p5) -> out1(p6) }
/*t6*/	:: atomic { inp1(p6)	-> out2(p4,p1) }
	od
}
