#include<stdio.h>
extern void catString(int, char*);
extern void catStrings(int, char*, int, char*, int, char*, int, char*, int, char*, int, char*);


void main()
{

    printf("\n\nHello World of Assembly, c speaking, again!\n\n");
    printf("Testing: catString the results here should print a ʻoneʻ\n");
    char* one={"one\n"};
    catString(4, one);
        
    printf("Testing: catString the results here should print ʻoneʻ...ʻsixʻ\n");
    char* two ={"two\n"};
    char* three ={"three\n"};
    char* four ={"four\n"};
    char* five ={"five\n"};
    char* six ={"six\n"};

    catStrings(4, one, 4, two, 6, three, 5, four, 5, five, 4, six);


}
/*
The output should look like below
*/

/*
Hello World of Assembly, c speaking, again!

Testing: catString the results here should print a ʻoneʻ
one
Testing: catString the results here should print ʻoneʻ...ʻsixʻ
one
two
three
four
five
six
*/


/*
Please remember I may test with different values, so be sure to experiment a bit
*/
