macros: macros.o 
	ld -o macros macros.o ../../lib/cs12Lib/cs12Lib.o

macros.o: macros.s
	as -g -alm=listing -o macros.o macros.s

clean:
	rm -rf macros
	rm -rf macros.o
	rm -rf listing 

