debug: debug.o 
	ld -o debug debug.o

debug.o: debug.s
	as -g -o debug.o debug.s

clean:
	rm -rf debug
	rm -rf debug.o

