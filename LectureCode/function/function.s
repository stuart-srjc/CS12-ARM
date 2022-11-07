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

// test sum 
MOV X0, #22               // mulby4 takes a value in X0 and returns that value *4 in X0
MOV X1, #33
BL sum
BL printX0


// Test printVals
// the first 8 values are passed in registers
MOV X0, #1
MOV X1, #2
MOV X2, #3
MOV X3, #4
MOV X4, #5
MOV X5, #6
MOV X6, #7
MOV X7, #8

// Now we set the values and pass them into the register in reverse order for 9, 10 and 11
MOV X8, #11     // 0x000000000000000B
MOV X9, #0      // storing 0 here is as good as anything as we do not use a 4th parameter
STP X8,X9,[SP, #-16]!

MOV X8, #9      // 0x0000000000000009
MOV X9, #10     // 0x000000000000000A
STP X8,X9,[SP, #-16]!

BL printVals

Add SP, SP, #32      // Add to the SP to unpop without having to actually perform the operations


// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






