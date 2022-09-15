.data  // start of the data segment

// create a logic variable and size variable
logic: 
	.asciz "Logic and Shift\n"
logicSize = .-logic

.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:

// Print, essentialy this code does this in c
// cout << logic;
mov x0, #0          // stdout
ldr x1, =logic       // store the address of flow into x1
ldr x2, =logicSize   // store the size of the flowwWorld string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

// Logical Operators
// The Logical Operators listed below coorespond to the Bitwise operations in C
// AND{S}    Xd, Xs, Operand2
// And is the same as the & operator in C
// X0 = 0xF & 0xAB;  
MOV X0, #0xAB       
AND X0, X0, #0xF
BL printX0          // this should produce 0x0B

/*
0X0F = 0000 1111
0xAB = 1010 1011
AND  = 0000 1011 = 0xB
*/

// EOR{S}    Xd, Xs, Operand2
// This is the Exclusive or, ^ in C 
// X0 = 0XF ^ 0Xab;
MOV X0, #0xAB       
EOR X0, X0, #0xF
BL printX0          // this should produce 0x0B

/*
0X0F = 0000 1111
0xAB = 1010 1011
EOR  = 1010 0100 = 0xA4
*/

// ORR{S}    Xd, Xs, Operand2
// This is the or, | in C 
// X0 = 0XF | 0Xab;
MOV X0, #0xAB       
ORR X0, X0, #0xF
BL printX0          // this should produce 0x0B

/*
0X0F = 0000 1111
0xAB = 1010 1011
ORR  = 1010 1111 = 0xAF
*/

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
MOV X0, #0xAB       
BIC X0, X0, #0xF
BL printX0          // this should produce 0xA0

/*
0xAB = 1010 1011
0X0F = 0000 1111
BIC  = 1010 0000 = 0xA0
*/



// Shifting
// LSL   X1, X2, #1    // Logical shift left
// Shift the bits left, replace any bits on the right side with 0
// Note that in binary #0xAAAAAAAAAAAAAAAA is:
// 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 
// this makes it easy to see what is happening when we shift
MOV X0, #0xAAAAAAAAAAAAAAAA
LSL X0, X0, #4
BL printX0          // this should produce 0xAAAAAAAAAAAAAA0

// LSR   X1, X2, #1    // Logical shift right
MOV X0, #0xAAAAAAAAAAAAAAAA
LSR X0, X0, #4
BL printX0          // this should produce 0x0AAAAAAAAAAAAAA

// ASR   X1, X2, #1    // Arithmetic shift right
MOV X0, #0xAAAAAAAAAAAAAAAA
ASR X0, X0, #4
BL printX0          // this should produce 0xFAAAAAAAAAAAAAA


// ROR   X1, X2, #1    // Rotate right 
MOV X0, #0xAAAAAAAAAAAAAAAA
ROR X0, X0, #4
BL printX0          // this should produce 0xAAAAAAAAAAAAAAA




// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






