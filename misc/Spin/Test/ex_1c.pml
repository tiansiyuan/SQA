/* http://spinroot.com/spin/Doc/Exercises.pdf ex.1c */

#define N	26

int a;
byte b;

init {
	do
	:: atomic { (b < N) ->
		if
		:: a = a + (1<<b)
		:: skip
		fi;
		b=b+1 }
	:: else -> break
	od
}
