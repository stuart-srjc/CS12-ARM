template: template.o 
	ld -o template template.o ../cs12Lib/cs12Lib.o

template.o: template.s
	as -g -o template.o template.s

clean:
	rm -rf template
	rm -rf template.o

