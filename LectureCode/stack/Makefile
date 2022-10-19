stack: stack.o 
	ld -o stack stack.o ../../lib/cs12Lib/cs12Lib.o

stack.o: stack.s
	as -g -o stack.o stack.s

clean:
	rm -rf stack
	rm -rf stack.o

