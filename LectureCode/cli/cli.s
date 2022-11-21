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
x11 value #16 to represent 16 bytes
x12 
x13 address that is stored in the stack (by reference)
x14 argc
*/


// POP argc
mov fp, sp
ldr x14, [fp]        //argc

mov x9, #1         // Counter
mov x11, #8       // 16 bytes

argv:              // for each argv
mul x10, x9, x11   // offset by 16 byte times the counter
ldr x13, [fp, x10]  // Load the address stored in the stack

/*
Register map
x2 Counter
x3 temp char variable for moving to buffer
x4 pointer to our buffer
*/
mov x2, #0
ldr x4, =buffer
loop:
ldrb w3, [x13, x2]
strb w3, [x4, x2]
add x2, x2, #1
cmp w3, 0x0
b.ne loop

// add 0xa line feed
mov x3, 0xa
strb w3, [x4, x2]

// print out the string
mov x0, #0
ldr x1, =buffer
add x2, x2, #1
//mov x2, #128 x2 has the size of the string
mov x8, #64
svc 0

add x9, x9, #1
cmp x14, x9
b.ge argv

// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






