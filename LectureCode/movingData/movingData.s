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

// MOV 
MOV X0, #0xFF       // Move the value 0xFF into register 0
MOV X1, X0          // Move the value stored in register 0 into register 1

// MOVK
// We want to put the value 0x123456789ABCDEF0 in register 1
// With ARM we cannot do this in one instruction sow we need to fill it 16 bytes at a time with MOVK
// First we move the least significant portion into the register
MOV X1, #0xDEF0             // the register now holds 0x000000000000DEF0
// using a MOVK we will move in the next 16 bits
MOVK X1, #0x9ABC, LSL 16    // the register now contains 0x000000009ABCDEF0
MOVK X1, #0x5678, LSL 32    // the register now contains 0x000056789ABCDEF0
MOVK X1, #0x1234, LSL 48    // the register now contains 0x123456789ABCDEF0
// Be sure you understand why, this is important

// MOVN
MOV X0, #0              // Move a 0 into register 0
MOVN X1, #0             // Move 0xFFFFFFFFFFFFFFFF into register 1

// ADD
MOV X0, #0          // X0 = 0;
MOV X1, #1000       // X1 = 1000;
ADD x0, X0, #100    // X0 += 100;
ADD X0, X0, X1      // X0 += X1

// ADC
// Add with cary requires that the carry flag be set to do this we add an S (Status Bit) to the command
MOV x2, #0
MOV X0, #0XFFFFFFFFFFFFFFFF     // fill register 0 with all ones
ADD X1, X0, #1                  // add one, this will overflow the register, but note the carry flag is not set
ADDS X1, X0, #1                 // now the cary flag will be set, the rest of the operation remains the samee
MOV X3, #0
ADC X2, X2, X3                  // Add nothing to X2, but also add the cary flag, X2=X2+CarryFlag;


// SUB
MOV X0, #1000       // X0=1000;
SUB X1, X0, #1      // X1 = X0 - 1;
SUB X1, X1, X1      // X1-=X1; should be 0 


// SBC
// Subtract with carry requires we use the Status bit flag, and it will subtract a 1 if a borrow is needed (carry flag set)
MOV X0, #2          // X0=2;
MOV X1, #1          // x1=1;
MOV X2, #0 
SUBS X0, X0, #1     // X0--;  there is a 1 in X0 now and the Carry flag is set, because there was no borrow needed
SBC X1, X1, X2     // Subtract X2 from X1 and put the result in X1, but allso decrement if the carry flag is clear
SUBS X0, X0, #1     // X0--;  there is a 0 in X0 now and the Carry flag is set, because there was no borrow needed
SBC X1, X1, X2     // Subtract X2 from X1 and put the result in X1, but allso decrement if the carry flag is clear
SUBS X0, X0, #1     // X0--;  there is a -1 (0xFFFFFFFFFFFFFFFF) in X0 now and the Carry flag is cleared, because there was a borrow needed
SBC X1, X1, X2     // Subtract X2 from X1 and put the result in X1, but allso decrement if the carry flag is clear












// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






