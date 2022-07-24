movingData: movingData.o 
	ld -o movingData movingData.o

movingData.o: movingData.s
	as -g -o movingData.o movingData.s

clean:
	rm -rf movingData
	rm -rf movingData.o

