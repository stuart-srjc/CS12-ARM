programFlow: programFlow.o 
	ld -o programFlow programFlow.o ../cs12Lib/cs12Lib.o

programFlow.o: programFlow.s
	as -g -o programFlow.o programFlow.s

clean:
	rm -rf programFlow
	rm -rf programFlow.o

