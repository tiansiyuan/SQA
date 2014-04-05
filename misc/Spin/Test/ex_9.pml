/* http://spinroot.com/spin/Doc/Exercises.pdf ex.9 */

/* Tanenbaum 1989, sliding window protocol specification */

#define MaxSeq	3
#define MaxSeq_plus_1	4
#define inc(x)	x = (x + 1) % (MaxSeq_plus_1)

chan q[2] = [MaxSeq] of { byte, byte };

active [2] proctype p5()
{	byte	NextFrame, AckExp, FrameExp,
		r, s, nbuf, i;
	chan inp, out;

	inp = q[_pid];
	out = q[1-_pid];

	xr inp;
	xs out;

	do
	:: nbuf < MaxSeq ->
		nbuf++;
		out!NextFrame , (FrameExp + MaxSeq) % (MaxSeq_plus_1);
		inc(NextFrame)
	:: inp?r,s ->
		if
		:: r == FrameExp ->
			inc(FrameExp)
		:: else
		fi;
	 	do
		:: ((AckExp <= s) && (s <  NextFrame))
		|| ((AckExp <= s) && (NextFrame <  AckExp))
		|| ((s <  NextFrame) && (NextFrame <  AckExp)) ->
			nbuf--;
			inc(AckExp)
		:: else ->
			break
		od
	:: timeout ->
		NextFrame = AckExp;
		i = 1;
		do
		:: i <= nbuf ->
			out!NextFrame , (FrameExp + MaxSeq) % (MaxSeq_plus_1);
			inc(NextFrame);
			i++
		:: else ->
			break
		od
	od
}
