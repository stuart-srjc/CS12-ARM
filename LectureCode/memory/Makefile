memory: memory.o 
	ld -o memory memory.o ../../lib/cs12Lib/cs12Lib.o

memory.o: memory.s
	as -g -o memory.o memory.s

clean:
	rm -rf memory
	rm -rf memory.o

