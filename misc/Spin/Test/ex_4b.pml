/* http://spinroot.com/spin/Doc/Exercises.pdf ex.4b */

/* Peterson's algorithm, 1981 */

#define true	1
#define false	0

bool flag[2];
bool turn;

active [2] proctype user()
{	flag[_pid] = true;
	turn = _pid;
	(flag[1-_pid] == false || turn == 1-_pid);
crit:	skip;	/* critical section */
	flag[_pid] = false
}
