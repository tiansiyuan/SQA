In this package:

	- ispin.tcl	tcl/tk file with new ispin interface
	- install.sh	small shell script to install the above
	- ltl_examples/	a couple of Spin models using the new features

and in a separate tar file: Spin sources for version 6.0.B

Either run the install.sh script, or checkout what it does and
adapt as necessary on your system.
You can call ispin, once installed, as, for instance:
	 ispin ltl_examples/leader.pml

The new features in Spin Version 6.0 are as follows:

- Improved scope rules:
	so far, there were only two levels of scope for variable
	declarations: global or proctype local.
	6.0 supports the more traditional block scope as well:
	a variable declared inside an inline definition or inside
	a block has scope that is limited to that inline or block.
	You can revert to the old scope rules by using spin -O 
	(i.e., not zero 0 but the capital oh letter O).

- Multiple never claims:
	In 6.0 you can name never claims, by adding a name in
	between the keyword 'never' and the opening curly brace of
	the never claim body.
	This allows you to specify multiple never claims in a single
	Spin model. The model checker will still only use one never
	claim to perform the verification, but you can choose on the
	command line of pan which claim you want to use: pan -N name

- Computation of a synchronous product of claims:
	If multiple never claims are defined, you can use spin to
	generate a single claim which encodes the synchronous product
	of all never claims defined, using the new option -e:
	 spin -e spec.pml

- Inline ltl properties:
	Instead of specifying an explicit never claim, you can now
	specify LTL properties directly inline. Any number of named
	properties can be provided, and you can again choose which
	one should be checked, using the -N command line argument to pan.
	Example LTL property: ltl p1 "[]<>p" -- see the examples/
	Inline LTL properties state positive properties to prove, i.e.,
	they are not negated. (When spin generates the corresponding
	never claim, it will perform the negation automatically, so that
	it can find counter-examples to the positive property.)

- Dot support:
	A new option for the executable pan supports the generation of
	the state tables in the format accepted by the dot tool from
	graphviz: pan -D (the ascii format is still available as pan -d).

- Standardized output:
	All filename / linenumber references are now in a single standard
	format, given as filename:linenumber, which allows postprocessing
	tools, like iSpin, to easily hotlink such references to the source.

For help or bug-reports on the beta version 6.0.B: mail gerard@spinroot.com

May 10, 2012
