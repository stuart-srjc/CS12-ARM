#include<stdio.h>
extern int mulby4(int);
extern void printXtimes(int, int);
extern int getRandNum(int);
extern int getMax(int, int, int, int, int, int);


int main()
{
    int returnValue;
    int loop;

    printf("\n\nHello World of Assembly, c speaking\n\n");
    printf("Testing: mulby4 with 3\n");
    printf("mulby4(3);\n");
    returnValue = mulby4(3);
    printf("mulby4(3); returns a %d\n", returnValue);
    
    printf("\nTesting: printXtimes with 3,4\n");
    printXtimes(3,4);
    printf("\n");

    printf("\nTesting: getRandNum with 16 10 times\n");
    
    for (loop = 0; loop < 10; loop++)
        printf("Loop %d: %d\n", loop, getRandNum(16));


    printf("\nTesting: getMax\n");

    printf("%d\n", getMax(1,2,3,4,5,6));
    printf("%d\n", getMax(1,12,3,4,5,6));
    printf("%d\n", getMax(1,2,3,18,5,6));
    printf("%d\n", getMax(24,2,2,4,5,6));
    printf("%d\n", getMax(1,2,3,4, 30,6));
    printf("%d\n", getMax(1,2,3,4,5,36));
    printf("%d\n", getMax(1,2,42,4,5,6));
    printf("%d\n", getMax(1,2,3,48,5,6));
    

}
/*
The output should look like the code below

Hello World of Assembly, c speaking

Testing: mulby4 with 3
mulby4(3);
mulby4(3); returns a 12

Testing: printXtimes with 3,4
0x0000000000000003
0x0000000000000003
0x0000000000000003
0x0000000000000003


Testing: getRandNum with 16 10 times
Loop 0: 6
Loop 1: 6
Loop 2: 8
Loop 3: 0
Loop 4: 14
Loop 5: 4
Loop 6: 10
Loop 7: 2
Loop 8: 10
Loop 9: 5

Testing: getMax
6
12
18
24
30
36
42
48

Please remember I may test with different values, so be sure to experiment a bit
*/
