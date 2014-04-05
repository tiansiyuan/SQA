/* http://spinroot.com/spin/Doc/Exercises.pdf ex.9b */

/* Tanenbaum 1989, sliding window protocol specification */

#define MaxSeq	3
#define MaxSeq_plus_1	4
#define inc(x)	x = (x + 1) % (MaxSeq + 1)

chan q[2] = [MaxSeq] of { byte, byte };

active [2] proctype p5()
{	byte	NextFrame, AckExp, FrameExp,
		r, s, nbuf, i;
	chan inp, out;

	d_step {
		inp = q[_pid];
		out = q[1-_pid]
	};
	xr inp;
	xs out;

	do
	:: atomic { nbuf < MaxSeq ->
		nbuf++;
		out!NextFrame , (FrameExp + MaxSeq) % (MaxSeq + 1);
		printf("MSC: nbuf: %d\n", nbuf);
		inc(NextFrame)
	}
	:: atomic { inp?r,s ->
		if
		:: r == FrameExp ->
			printf("MSC: accept %d\n", r);
			inc(FrameExp)
		:: else
			-> printf("MSC: reject\n")
		fi
	};
	d_step {
		do
		:: ((AckExp <= s) && (s <  NextFrame))
		|| ((AckExp <= s) && (NextFrame <  AckExp))
		|| ((s <  NextFrame) && (NextFrame <  AckExp)) ->
			nbuf--;
			printf("MSC: nbuf: %d\n", nbuf);
			inc(AckExp)
		:: else ->
			printf("MSC: %d %d %d\n", AckExp, s, NextFrame);
			break
		od; skip
	}
	:: timeout ->
	d_step {
		NextFrame = AckExp;
		printf("MSC: timeout\n");
		i = 1;
		do
		:: i <= nbuf ->
			out!NextFrame , (FrameExp + MaxSeq) % (MaxSeq + 1);
			inc(NextFrame);
			i++
		:: else ->
			break
		od; i = 0
	}
	od
}

