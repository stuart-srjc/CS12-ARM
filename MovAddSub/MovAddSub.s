.data  // start of the data segment

// create a helloworld variable and size variable
helloWorld: 
	.asciz "Hello World of Assembly!\n"
helloSize = .-helloWorld

registerString: .asciz "        "
registerSize = .-registerString

hex: .ascii "0x"
hexSize = .-hex
tempBytes: .word 0x0


.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:


// Print, essentialy this code does this in c
// cout << helloWorld;
ldr x1, =helloWorld  // store the address of helloWorld into x1
ldr x2, =helloSize   // store the size of the hellowWorld string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

// MOVK
// We want to put the value 0x123456789ABCDEF0 in register 1
// With ARM we cannot do this in one instruction sow we need to fill it 16 bytes at a time with MOVK
// First we move the least significant portion into the register
MOV X1, #0xDEF0             // the register now holds 0x000000000000DEF0
// using a MOVK we will move in the next 16 bits
MOVK X1, #0x9ABC, LSL 16    // the register now contains 0x000000009ABCDEF0
MOVK X1, #0x5678, LSL 32    // the register now contains 0x000056789ABCDEF0
MOVK X1, #0x1234, LSL 48    // the register now contains 0x123456789ABCDEF0


// I have linked a library cs12Lib to this file via the Makefile
// you are not responsible to know how the file works, but I have left the source code (not well documented at the moment) if you wish to read it
// one of the functions of this library is to allow you to print out the value of registers 1-30
// you call this in the manner seen below
BL printR1

// perform the following work as outlined in the comments below, you will turn in a screenshot of the run of this program when your done
// Using MOV/MOVK set the value of X2 to 0xFACED000000DECAF
// Then using the library call printR2 print the value to the screen



// move the 1ʻs complement of the value from X2, into X3
// then print the value to the screen


// add register X2 and X3 together into X4 and print the value to the screen
 

// subtract register X2 from X3 into X5 and print the value to the screen


// lets look at carry operations
// fill register X6 with the value 0xFFFFFFFFFFFFFFFF
// note there are several ways to do this, some in a single operation
// now lets add 1 to register X6, but use the ADDS (Status bit flag on)
// at this point X6 should be 0, and the carry flag should be set
// using ADC lets see if the carry bit was set 
// ADC into X7 the value in X6 (0) 





// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






