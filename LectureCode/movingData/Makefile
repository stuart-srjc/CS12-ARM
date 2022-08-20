movingData: movingData.o 
	ld -o movingData movingData.o ../../lib/cs12Lib/cs12Lib.o

movingData.o: movingData.s
	as -g -o movingData.o movingData.s

clean:
	rm -rf movingData
	rm -rf movingData.o

