LogicShift: LogicShift.o 
	ld -o LogicShift LogicShift.o ../../lib/cs12Lib/cs12Lib.o

LogicShift.o: LogicShift.s
	as -g -o LogicShift.o LogicShift.s

clean:
	rm -rf LogicShift
	rm -rf LogicShift.o

