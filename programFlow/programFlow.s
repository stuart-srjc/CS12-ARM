.data  // start of the data segment

// create a flowworld variable and size variable
flow: 
	.asciz "Enter a number between 0x0 and 0xffffffffffffffff\n"
flowSize = .-flow

Higher: 
	.asciz "Your number is higher\n"
hSize = .-Higher

Lower: 
	.asciz "Your number is lower\n"
lSize = .-Lower

Equal: 
	.asciz "Your number is equal\n"
eSize = .-Equal

newLine: 
	.quad 0xA

.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:

// Print, essentialy this code does this in c
// cout << flowWorld;
mov x0, #0          // stdout
ldr x1, =flow       // store the address of flow into x1
ldr x2, =flowSize   // store the size of the flowwWorld string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

// the unconditional branch - goto
// put a number in X1
MOV X1, #0XFF
// now lets creat a label and branch to it
B skip
// inside lets add a call to printX0
BL printX0
skip:
// note that the second print did not occur, because we branched over it

// Condition Codes
/* We will be using condition codes quite a bit in future programming to perform conditional branches
Lets take a look at some of the conditional codes
EQ - Equal
NE - Not Equal
HI - Higher > (unsigned)
HS - Higher or Same >= (unsigned)
LO - Lower < (unsigned)
LS - Lower or Same <= (unsigned)
GT - Greater > (signed)
GE - Greater or Equal >= (signed)
LT - Less < (signed)
LE - Less or Equal <= (signed)

Essentially we have several forms of Greater, Less or Equal listed here
lets review a few
*/
// using the getHexNumber function lets allow the user to input a register
// in the format 0x1234567890abdef
// the result is store in x0

bl getHexNumber

// now that we have a number from the user lets do a compare and jump based on it
bl printX0
bl printX1

cmp x0, x1          
b.hi higher        // if x0 < x1 higher()
b.lo lower         // if x0 > x1 lower()
                   // else equal()

equal: // fall through condition
mov x0, #0          // stdout
ldr x1, =Equal      // store the address of flow into x1
ldr x2, =eSize      // store the size of the flowwWorld string into x2
mov x8, #64         // store 64 to x8, this is the linux write call
svc 0               // Linux service call
b done

higher:
mov x0, #0          // stdout
ldr x1, =Higher     // store the address of flow into x1
ldr x2, =hSize      // store the size of the flowwWorld string into x2
mov x8, #64         // store 64 to x8, this is the linux write call
svc 0               // Linux service call
b done

lower:
mov x0, #0          // stdout
ldr x1, =Lower      // store the address of flow into x1
ldr x2, =lSize      // store the size of the flowwWorld string into x2
mov x8, #64         // store 64 to x8, this is the linux write call
svc 0               // Linux service call
b done

done:

/* What control structure did we just use?
// in Pseudocode 

 If greater Then greater()
 Else If lower Then lower()
 Else Then equal()

or 
Case:
    x<y 
        greater()
        break

    x>y
        lower()
        break

    default:
        equal()
        break
*/

// If/Then/Else
// The example is illustrated above

// For
// for (x0; x0<10; x0++) 
MOV X0, #0      // start at 0
forLoop:        // this is the loop itself
                // code goes here
BL printX0
                // code ends here
ADD X0, X0, #1  // x0++
CMP x0, 10      // do until the 10th iteration
B.LO forLoop   // branch to the loop label

// While
// while(x0)
// note that in c this is the same as
// while(x0 != 0)
// this is what we will code below

// ask the user for input, we only do this once for now
// the program will continue to input values until it gets a 0
// Print, essentialy this code does this in c
// cout << flowWorld;
mov x0, #0          // stdout
ldr x1, =flow       // store the address of flow into x1
ldr x2, =flowSize   // store the size of the flowwWorld string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

bl getHexNumber // we need to get a value to start the loop with
whileLoop:      // start of the loop
CMP X0, #0      // if x0 is 0 were done 
B.EQ endWhileLoop
                // code starts here
BL printX0
                // code ends here
bl getHexNumber // get next value
b whileLoop     // if the user input anything but 0 jump to the top of the loop again
endWhileLoop:

// Branch With Link
// This is like a function call we will get more into function calls in the future but for now lets write a function that prints a new line
// We will add an unconditional branch surrounding this code so that it is not run unless we call it
// to support this the following was added in the data section
// newLine
b skipNewLine
endl:
mov x0, #0          // stdout
ldr x1, =newLine     // store the address of our newLine character
mov x2, #1           // just print the one character
mov x8, #64         // store 64 to x8, this is the linux write call
svc 0               // Linux service call
ret                 // return to the line after the one that called this function

skipNewLine:

// now we can call the code using a branch with the link
// note that code called with BL needs a corresponding ret 
BL endl 

// you may have noticed that we have been using BL to call functions in the library provided for the class
// we will learn much more about this in the future modules.

// Logical Operators
// The Logical Operators listed below coorespond to the Bitwise operations in C
// AND{S}    Xd, Xs, Operand2
// And is the same as the & operator in C
// X0 = 0xF & 0xAB;  
MOV X0, #0xAB       
AND X0, X0, #0xF
BL printX0          // this should produce 0x0B
BL endl

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
BL endl

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
BL endl

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
BL printX0          // this should produce 0x0B
BL endl

/*
0X0F = 0000 1111
0xAB = 1010 1011
BIC  = 0000 0100 = 0x04
*/






// Shifting
// LSL   X1, X2, #1    // Logical shift left
// Shift the bits left, replace any bits on the right side with 0
// Note that in binary #0xAAAAAAAAAAAAAAAA is:
// 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 1010 
// this makes it easy to see what is happening when we shift
MOV X0, #0xAAAAAAAAAAAAAAAA
BL printX0          // for comparing the output
LSL X0, X0, #4
BL printX0          // this should produce 0xAAAAAAAAAAAAAA0
BL endl

// LSR   X1, X2, #1    // Logical shift right
MOV X0, #0xAAAAAAAAAAAAAAAA
BL printX0          // for comparing the output
LSR X0, X0, #4
BL printX0          // this should produce 0x0AAAAAAAAAAAAAA
BL endl

// ASR   X1, X2, #1    // Arithmetic shift right
MOV X0, #0xAAAAAAAAAAAAAAAA
BL printX0          // for comparing the output
ASR X0, X0, #4
BL printX0          // this should produce 0xFAAAAAAAAAAAAAA
BL endl


// ROR   X1, X2, #1    // Rotate right 
MOV X0, #0xAAAAAAAAAAAAAAAA
BL printX0          // for comparing the output
ROR X0, X0, #4
BL printX0          // this should produce 0xAAAAAAAAAAAAAAA
BL endl




// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






