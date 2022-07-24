MovAddSub: MovAddSub.o 
	ld -o MovAddSub MovAddSub.o

MovAddSub.o: MovAddSub.s
	as -g -o MovAddSub.o MovAddSub.s

clean:
	rm -rf MovAddSub
	rm -rf MovAddSub.o

