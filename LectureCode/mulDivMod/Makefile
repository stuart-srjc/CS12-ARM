mulDivMod: mulDivMod.o 
	ld -o mulDivMod mulDivMod.o ../../lib/cs12Lib/cs12Lib.o

mulDivMod.o: mulDivMod.s
	as -g -o mulDivMod.o mulDivMod.s

clean:
	rm -rf mulDivMod
	rm -rf mulDivMod.o

