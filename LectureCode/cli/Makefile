cli: cli.o 
	ld -o cli cli.o ../../lib/cs12Lib/cs12Lib.o

cli.o: cli.s
	as -g -o cli.o cli.s

clean:
	rm -rf cli
	rm -rf cli.o

