.data  // start of the data segment

// create a memoryworld variable and size variable
memory: 
	.asciz "Memoory Lecture Code\n"
memorySize = .-memory

endl:
	.asciz "\n"
endlSize = .-endl

// let us look at some assembely directives to create different types of variables
myByte:      .byte      0x12                // byte
myDouble:    .double    3.14                // double
myFloat:     .float     3.14                // float
myQuad:      .quad      0x123456789abcdef   // quad  8 bytes
myOcta:      .octa      -1                  // octa 16 bytes
myShort:     .short     0x1234              // short 2 bytes
myWord:      .word      0x12345678          // word  4 bytes
myArray:     .fill      10, 4, 0xA          // 10 words
myByteArray: .rept      5                   // 5 bytes
    .byte 0xF
.endr
myQuadArray: .rept      5                   // 5 Quadwords
    .quad 0x1234567890ABCDEF
.endr


.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:

b endPrintEndl      // bypass this code unless called explicitly
// Print Endl
// cout << endl;
// NOTE: this function has unintended side effects, we will learn about this later
// for now I would avaoid using this in your code
printEndl:
ldr x1, =endl         // store the address
ldr x2, =endlSize     // store the size 
mov x0, #0            // STDOUT
mov x8, #64           // store 64 to x8, this is the linux write call
svc 0                 // Linux service call
ret
endPrintEndl:


// Print, essentialy this code does this in c
// cout << memoryWorld;
ldr x1, =memory         // store the address of memoryWorld into x1
ldr x2, =memorySize     // store the size of the memorywWorld string into x2
mov x8, #64             // store 64 to x8, this is the linux write call
svc 0                   // Linux service call

BL printEndl


// LDR
// letʻs take a look at some of the variables we created above
LDR X0, =myByte
BL printX0
// this is the address our myByte label
// Now lets get the value 
LDR X1, [X0]
BL printX1


BL printEndl


// wait what happened ?
// We did not specify the data size we wanted to load so assembly just loads the whole register
// to get just our byte we use
LDR X0, =myByte
LDRB W1, [X0]
BL printX1

BL printEndl


// That is better 
// we now get just the byte

// LDR with offset
// Letʻs take a look at the Byte Array created with .rept
LDR X0, =myByteArray
LDRB W1, [X0]
BL printX1

// we do not want to waste a lot of code with repetition so lets run through all 5 bytes in a loop
MOV X2, #0
ByteLoop:
LDR X0, =myByteArray
LDRB W1, [X0, x2]       // we offset the byte by X2
BL printX1
ADD X2, X2, #1
CMP X2, 4               // for 0 to 4
B.NE ByteLoop


BL printEndl


// To do this for the quad we do the same thing
// only we need to move 8 bytes at a time so one way to do this would be to use another register
MOV X2, #0
LDR X0, =myQuadArray
QuadLoop:
MOV x3, #8
MUL X3, X2, X3 
LDR X1, [X0, x3]       // we offset the byte by X2 multiplied time 8, 8 bytes
BL printX1
ADD X2, X2, #1
CMP X2, 5               // for 0 to 4
B.NE QuadLoop

BL printEndl


// This is one way of offsetting, each time through the loop we offset by X2 * 8 bytes
// Assembly gives us ways of doing this with fewer instructions
// Write BaCK
MOV X2, #0
LDR X0, =myQuadArray
QuadLoop2:
                        // The X3 is gone and in fact were not using a counter in the LDR
LDR X1, [X0, #8]!       // we offset the byte by 8 bytes, the ! causes X1 to retain this address
BL printX1
                        // So that the next time through we get the next value
ADD X2, X2, #1          // were still using X2 for the for loop
CMP X2, 5               // for 0 to 4
B.NE QuadLoop2

BL printEndl

// Wait that is not quite what we want, 
// We are using Pre_indexed addressng, this is similar to ++X in C
// Because were indexing before we do the read we are reading from 1-5 vs 0-4
// That is why we see 
// 0x3837363534333033
// instead of 
// 0x3034567890ABCDEF
// this is the value that is one Quadword after our array
// So how do we get the right data? 

// Post-Indexed Addressing
// Post-Indexed Addressing returns the value first then updates the pointer
// Letʻs try the above code but using post indexed addressing

MOV X2, #0
LDR X0, =myQuadArray
QuadLoop3:
LDR X1, [X0], #8        // we offset the byte by 8 bytes, by placing the #8 outside the []
                        // we end up with post indexed addressing C++ vs ++C
BL printX1
                        // So that the next time through we get the next value
ADD X2, X2, #1          // were still using X2 for the for loop
CMP X2, 5               // for 0 to 4
B.NE QuadLoop3
// and now we see the 0-4 values, vs the values 1-5

BL printEndl

// Store Register 

MOV X2, #0
LDR X0, =myQuadArray
QuadLoop4:
STR X2, [X0], #8        // Store the value in X2 into myQuadArray, using post index array
                        // So that the next time through we get the next value
ADD X2, X2, #1          // were still using X2 for the for loop
CMP X2, 5               // for 0 to 4
B.NE QuadLoop4

// Now display the values 

MOV X2, #0
LDR X0, =myQuadArray
QuadLoop5:
LDR X1, [X0], #8        // we offset the byte by 8 bytes, by placing the #8 outside the []
                        // we end up with post indexed addressing C++ vs ++C
BL printX1
                        // So that the next time through we get the next value
ADD X2, X2, #1          // were still using X2 for the for loop
CMP X2, 5               // for 0 to 4
B.NE QuadLoop5

BL printEndl


// There are also forms of the LDR and STR that do two registers at the same time
LDR X0, =myOcta         // load the address of the octa variable
LDP X1, X2, [X0]        // load the octa variable into X1 and X2 registers
BL printX1              // print out X1
BL printX2              // print out X2

BL printEndl

LDR X0, =myOcta         // load the address of the octa variable
MOV X1, 0X1             // mov 1 into X1
MOV X2, 0X2             // mov 2 into X2

STP X1, X2, [X0]        // Store X1 and X2 into the octa variable

// now lets print this out
LDR X0, =myOcta         // load the address of the octa variable 
LDP X1, X2, [X0]        // load the octa variable into X1 and X2 registers
BL printX1              // print out X1
BL printX2              // print out X2

BL printEndl




// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






