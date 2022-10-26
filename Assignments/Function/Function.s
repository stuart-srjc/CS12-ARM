.extern mulby4
.data  // start of the data segment

// create a helloworld variable and size variable
helloWorld: 
	.asciz "Hello World of Assembly!\n"
helloSize = .-helloWorld

.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:


// Print, essentialy this code does this in c
// cout << helloWorld;
ldr x1, =helloWorld  // store the address of helloWorld into x1
ldr x2, =helloSize   // store the size of the hellowWorld string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call


// test program for the functionLib

// test mulby4
MOV X0, 3               // mulby4 takes a value in X0 and returns that value *4 in X0
BL mulby4
BL printX0
// should produce a 0xc


// test printXtimes with 4, 3
MOV X0, #4                  // print a 4
MOV X1, #3                  // 3 times
BL printXtimes 
// should produce 3 0x4ʻs

// test getRandNum with 25 3 times
MOV X0, #25
BL getRandNum              // get a random number below X0 (25)
BL printX0

MOV X0, #25
BL getRandNum              // get a random number below X0 (25)
BL printX0

MOV X0, #25
BL getRandNum              // get a random number below X0 (25)
BL printX0
// should produce 3 numbers less than 0x19


// test get max 3 times
MOV X0, #1              // return the highest value from x0 to x5 in x0
MOV X1, #3
MOV X2, #5
MOV X3, #7
MOV X4, #9
MOV X5, #1
BL getMax
BL printX0

MOV X0, #18              // return the highest value from x0 to x5 in x0 
MOV X1, #1
MOV X2, #7
MOV X3, #8
MOV X4, #9
MOV X5, #3
BL getMax
BL printX0

MOV X0, #23               // return the highest value from x0 to x5 in x0 
MOV X1, #27
MOV X2, #27
MOV X3, #23
MOV X4, #11
MOV X5, #19
BL getMax
BL printX0
// should produce 
// 0x9
// 0x12
// 0x1B

// your output for this should produce
/*
0x000000000000000C
0x0000000000000004
0x0000000000000004
0x0000000000000004
0x0000000000000003
0x0000000000000019
0x0000000000000017
0x0000000000000009
0x0000000000000012
0x000000000000001B
*/
/* then run 
make testc
./test
and you should see the output listed in the test.c file
I will may be testing with different criteria so you may want to test other calls.
*/ 
 


// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






