syscalls: syscalls.o 
	ld -o syscalls syscalls.o ../../lib/cs12Lib/cs12Lib.o

syscalls.o: syscalls.s
	as -g -o syscalls.o syscalls.s

clean:
	rm -rf syscalls
	rm -rf syscalls.o
	rm -rf outfile.txt

