#include<stdio.h>
extern int sum(int, int);
extern int printVals(int, int, int, int, int, int, int, int, int, int, int);


int main()
{
    int returnValue;
    int loop;

    printf("\n\nHello World of Assembly, c speaking\n\n");
    printf("Testing: sum with 122 and 133\n");
    printf("sum(122, 133);\n");
    returnValue = sum(122, 133);
    printf("sum(122, 133); returns a %d\n", returnValue);
    
    printf("\nTesting: printVals\n");
    printVals(1,2,3,4,5,6,7,8,9,10,11); 

}
