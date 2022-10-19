.data  // start of the data segment

// create a helloworld variable and size variable
stack: 
	.asciz "Stack Assignment!\nEnter a value in hex and hit enter 3 times\n"
stackSize = .-stack

prompt: 
	.asciz "Enter a string and press enter (max of 20 characters please)\n"
promptSize = .-prompt

input: 
	.fill 21, 1, 0x0 // 21 bytes initialized to 0
inputSize = .-input

output: 
	.fill 21, 1, 0x0 // 21 bytes initialized to 0
outputSize = .-output

.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:

// Print, essentialy this code does this in c
// cout << helloWorld;
mov x0, #0           // std out
ldr x1, =stack  // store the address of into x1
ldr x2, =stackSize   // store the size of the string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

// 3 times
// get a value from the user
// push it to the stack

.rept 3                 // repeat this code 3 times, this is not as efficient as a loop but wanted to demo it
BL getHexNumber         // get a hex value from the user
STR X0, [SP, #-16]!      // push it onto the stack
.endr

.rept 3                 // repeat this code 3 times
LDR X0, [SP], #16       // pop from the stack
BL printX0              // print out the value
.endr

// prompt the user for a string
mov x0, #0           // std out
ldr x1, =prompt      // store the address into x1
ldr x2, =promptSize   // store the size of the string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

// get a string from the user
// cin << varName;
mov x0, #1            // 1 is STDOUT/STDIN
ldr x1, =input       // store the address of the input array into x1
ldr x2, =inputSize   // store the size of the input array string into x2
mov x8, #63          // store 63 to x8, this is the linux read call
svc 0                // Linux service call


// Echo back to the user the input value
mov x0, #1            // 1 is STDOUT/STDIN
ldr x1, =input       // store the address of the input array into x1
ldr x2, =inputSize   // store the size of the input array string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

// now lets push the characters onto the stack
MOV X2, #0              // Counter
LDR X0, =input          // point x0 to the address of the input array
nextChar:
LDRB W1, [X0], #1       // read in the first byte of the array, post index it by a byte
CMP X1, 0xA             // here we look to see if we get the LF (line feed) character (end of the string)
B.EQ endOfString        // branch to end of string if were done
STR X1, [SP, #-16]!     // push on the stack
ADD X2, X2, #1          // count the items pushed onto the stack
B nextChar              // loop to next character in the string
endOfString:

// now lets pop off the characters and print the result
// X2 holds the count of the characters pushed to the stack
MOV X3, #0              // create a counter, preserving X2 
LDR X0, =output         // point X0 to the output array
nextOutChar:
LDR X1, [SP], #16       // Pop the characters from the stack
STRB W1, [X0], #1       // write to the output array, post index 
ADD X3, X3, #1          // Increment the counter
CMP X3, X2              // have we popped all the items from the stack
B.LE nextOutChar        // loop until were done popping

MOV X1, 0xA             // we will need a new line also
STRB W1, [X0], #16      // write to the output array our new line 

// Echo back to the user the input value
mov x0, #1            // 1 is STDOUT/STDIN
ldr x1, =output       // store the address of the input array into x1

// NOTE that X2 currently holds the value of all the characters except 0xA
// and it is 0 referenced so we need to add 2 to it
ADD X2, X2, #2          // now it represents the whole output string size 
//ldr x2, =outputSize   // store the size of the input array string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call


// lets crash the stack!
loopForever:
MOV X1, #0
STR X1, [SP, #-16]!     // push on the stack
b loopForever

// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






