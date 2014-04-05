/* http://spinroot.com/spin/Doc/Exercises.pdf ex.1b */

#define N	2

init {
	chan dummy = [N] of { byte };
	do
	:: dummy!85
	:: dummy!170
	od
}
