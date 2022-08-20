logicShift: logicShift.o 
	ld -o logicShift logicShift.o ../../lib/cs12Lib/cs12Lib.o

logicShift.o: logicShift.s
	as -g -o logicShift.o logicShift.s

clean:
	rm -rf logicShift
	rm -rf logicShift.o

