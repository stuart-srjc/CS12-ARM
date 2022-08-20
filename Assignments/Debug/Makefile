Debug: Debug.o 
	ld -o Debug Debug.o

Debug.o: Debug.s
	as -g -o Debug.o Debug.s

clean:
	rm -rf Debug
	rm -rf Debug.o

