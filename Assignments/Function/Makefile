
Function: Function.o 
	ld -o Function Function.o ../../lib/cs12Lib/cs12Lib.o FunctionLib.o

Function.o: Function.s FunctionLib.o
	as -g -o Function.o Function.s 

FunctionLib.o: FunctionLib.s
	as -g -o FunctionLib.o FunctionLib.s

Testc: Test.c Test.o ../../lib/cs12Lib/cs12Lib.o FunctionLib.o
	 gcc -no-pie -g -o Test Test.o ../../lib/cs12Lib/cs12Lib.o FunctionLib.o

clean:
	rm -rf Function
	rm -rf Function.o
	rm -rf FunctionLib.o
	rm -rf Function.o
	rm -rf Test
	rm -rf Test.o
