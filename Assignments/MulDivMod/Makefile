MulDivMod: MulDivMod.o 
	ld -o MulDivMod MulDivMod.o ../../lib/cs12Lib/cs12Lib.o

MulDivMod.o: MulDivMod.s
	as -g -o MulDivMod.o MulDivMod.s

clean:
	rm -rf MulDivMod
	rm -rf MulDivMod.o

