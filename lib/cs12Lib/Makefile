cs12LibTest: cs12LibTest.o cs12Lib.o
	ld -o cs12LibTest cs12LibTest.o cs12Lib.o

cs12LibTest.o: cs12LibTest.s
	as -g -o cs12LibTest.o cs12LibTest.s

cs12Lib.o: cs12Lib.s
	as -g -o cs12Lib.o cs12Lib.s


clean:
	rm -rf cs12LibTest
	rm -rf cs12LibTest.o
	rm -rf cs12Lib.o

