.data  // start of the data segment

// create a helloworld variable and size variable
helloWorld: 
	.asciz "Hello World of Assembly!\n"
helloSize = .-helloWorld
buffer: .fill 128,1,0xa  // 128 byte buffer

.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:

/*
Register map
x9  counter
x10 temp value to hold number of bytes to skip for this argv
x11 value #8 to represent 8 bytes
x12 
x13 address that is stored in the stack (by reference)
x14 argc
*/


// POP argc
mov fp, sp
ldr x14, [fp]        //argc
bl printX14 // DEBUG

mov x9, #1         // Counter
mov x11, #8       // 8 bytes

argv:              // for each argv
mul x10, x9, x11   // offset by 8 byte times the counter
ldr x13, [fp, x10]  // Load the address stored in the stack

/*
Register map
x2 Counter
x3 temp char variable for moving to buffer
x4 pointer to our buffer
*/
mov x2, #0              // counter
ldr x4, =buffer         // pointer to the buffer 
loop:                   // for each ArgV
ldrb w3, [x13, x2]      // Load the byte pointed to by x13 offset by x2 into w3 (for each character in the string)
strb w3, [x4, x2]       // Store the byte we just loaded, into the buffer x14 offset by x2
add x2, x2, #1          // increment the counter
cmp w3, 0x0             // see if we found our null termination from the OS
b.ne loop               // if not go to the next character in the string, otherwise fall through

// add 0xa line feed
mov x3, 0xa             // move the value 0xa into the X3 register
strb w3, [x4, x2]       // store into the last character position in the string 0xa so we get a line feed

// print out the string
mov x0, #0              // stdout
ldr x1, =buffer         // print what is in buffer
add x2, x2, #1          // print X2 + 1 characters (need to account for the additional character 0xa)
mov x8, #64             // the write call for linux
svc 0                   // call the system call

add x9, x9, #1          // increment our outer loop counter
cmp x14, x9             // have we reached argc parameters yet ?
b.ge argv               // if not get the next argv, otherwise fall through

// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






