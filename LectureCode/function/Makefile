
function: function.o 
	ld -o function function.o ../../lib/cs12Lib/cs12Lib.o functionLib.o

function.o: function.s functionLib.o
	as -g -o function.o function.s 

functionLib.o: functionLib.s
	as -g -o functionLib.o functionLib.s

testc: test.c test.o ../../lib/cs12Lib/cs12Lib.o functionLib.o
	 gcc -no-pie -g -o test test.o ../../lib/cs12Lib/cs12Lib.o functionLib.o

clean:
	rm -rf function
	rm -rf function.o
	rm -rf functionLib.o
	rm -rf function.o
	rm -rf test
	rm -rf test.o
