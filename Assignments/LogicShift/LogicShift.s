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



// Logical Operators
// The Logical Operators listed below coorespond to the Bitwise operations in C
// AND{S}    Xd, Xs, Operand2
// And is the same as the & operator in C
// X0 = 0xF & 0xAB;  

// And the values 0xAA  and 0x7
// Print out the result

// your code goes here



// EOR{S}    Xd, Xs, Operand2
// This is the Exclusive or, ^ in C 
// X0 = 0XF ^ 0Xab;

// EOR the values 0xAA  and 0x7
// Print out the result

// your code goes here



// ORR{S}    Xd, Xs, Operand2
// This is the or, | in C 
// X0 = 0XF | 0Xab;


// OOR the values 0xAA  and 0x7
// Print out the result

// your code goes here



// BIC{S}    Xd, Xs, Operand2 
// This is the Bit Clear
// This is very useful but can be confusting at first
/*
The idea is to clear any bits in X if Y is set to 1
The Logic Table is this
    X   Y   X bic Y
    0   0   0       In this case leave the flag    
    0   1   0       In this case clear the flag, but its already clear
    1   0   1       In this case leave the flag
    1   1   0       In this case clear the flag
*/ 

// BIC the values 0xAA  and 0x7
// Print out the result

// your code goes here



// Shifting
// LSL   X1, X2, #1    // Logical shift left
// Shift the bits left, replace any bits on the right side with 0
// Note that in binary #0xAAAAAAAAAAAAAAAA is:
// 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 
// this makes it easy to see what is happening when we shift

// LSL  the value 0xAAAAAAAAAAAAAAAA  by 7
// Print out the result

// your code goes here


// LSR   X1, X2, #1    // Logical shift right
// LSR  the value 0xAAAAAAAAAAAAAAAA  by 7
// Print out the result

// your code goes here



// ASR   X1, X2, #1    // Arithmetic shift right
// ASR  the value 0xAAAAAAAAAAAAAAAA  by 7
// Print out the result

// your code goes here



// ROR   X1, X2, #1    // Rotate right 
// ROR  the value 0xAAAAAAAAAAAAAAAA  by 7
// Print out the result

// your code goes here



/*****************************

Take a screen shot of the resulting output
Turn in the screen shot as well as the completed .s file 

******************************/

/* output should look like this

Hello World of Assembly!
0x0000000000000002
0x00000000000000AD
0x00000000000000AF
0x00000000000000A8
0x5555555555555500
0x0155555555555555
0xFF55555555555555
0x5555555555555555

*/



// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call



