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


// Mulitply
// MUL
// MUL    Xd, Xn, Xm
// lets multiply 3 times 4
MOV X0, #3      // x0=3
MOV X1, #4      // x1=4
MUL X0, X0, X1  // x0=x0*x1
bl printX0      // should be 12 or 0xc

// that looks pretty simple so far, but now lets multipy somthing bigger
MOV X0, 0x1000000000000000      // X0 = 0x10000000000000000
MOV X1, 0x10      // X1 = 0x10
MUL X0, X0, X1  // x0=x0*x1
bl printX0      // should be 0x1000000000000000

// But wait, it is not instead it shows the value 0x0
// What happened?
// the register had an overflow, and we only see the bottom 64bits of the multiply
// it takes 128bits to store the maximum multiplication of 2 64 bit integers
// so we will need a few more multiplication instructiions if we want to multiply numbers greater than 32bits each.
// Note: the 32 bit version of this does not help bacause the destination register is also 32bits wide, and we need 64 bits to store 32bit multiplication.

// Multiply High
// we can combine MUL wiht SMULH to get the top 64bits of the multiplication 
// SMULH and UMULH  
// SMULH    Xd, Xn, Xm
// UMULH    Xd, Xn, Xm

MOV X0, 0x1000000000000000      // X0 = 0x10000000000000000
MOV X1, 0x10      // X1 = 0x10
SMULH X0, X0, X1  // x0=x0*x1
bl printX0      // should be 0x1, the missing 1 from our above calculation

// note that if you take the 0x1 from our SMULH Multiplication and append the 0x0000000000000000
// from the MUL you will get 0x10000000000000000 that is too big to fit in one register but we
// have the whole value to work with

// we used the signed version of MULH there is an unsinged version as well, lets take a look at both of them using a value 0xF000000000000000 and multiplying that by 0x10


MOV X0, 0xF000000000000000      // X0 = 0x10000000000000000
MOV X1, 0x10      // X1 = 0x10
SMULH X0, X0, X1  // x0=x0*x1
bl printX0      // we will take a look at the value after the next operations 

MOV X0, 0xF000000000000000      // X0 = 0x10000000000000000
MOV X1, 0x10      // X1 = 0x10
UMULH X0, X0, X1  // x0=x0*x1
bl printX0      

/* 
The values are 
0xFFFFFFFFFFFFFFFF
0x000000000000000F

The difference is that one is signed math and one is unsigned math
in signed math we need to ensure we fill all the values to the left with the complement of 0 or 1
in unsigned math we ensure we fill the values to the left with 0
It is important to understand why this is, so if you do not please review 2ʻs complement 
then ask if that is not sufficient
*/


// Multiply Long
// Takes 2 32 bit registers, multiplies the values and retuns them in a 64bit register 
// SMULL and UMULL 
// SMULH    Xd, Wn, Wm
// UMULH    Xd, Wn, Wm


// Let us start with the Unsigned version
MOV W0, 0xF0000000      // W0 = 0xF00000000
MOV W1, 0x10      // W1 = 0x10
UMULL X0, W0, W1  // x0=w0*w1
bl printX0      // should be 0xF00000000, 64bit representation of the multilication


// Let us follow with the signed version
MOV W0, 0xF0000000      // W0 = 0xF00000000
MOV W1, 0x10      // W1 = 0x10
SMULL X0, W0, W1  // x0=w0*w1
bl printX0      // should be 0xFFFFFFFF00000000, 64bit representation of the signed multilication



// Division 
// SDIV and UDIV 
// SDIV Xd, Xn, Xm
// UDIV Xd, Xn, Xm
// lets divide 0xFFFFFFFFFFFFFFFC by 0xF
MOV X0, 0XFFFFFFFFFFFFFFFC  // x0=0xfffffffffffffffc
MOV X1, 0XF                 // x1=0xf
UDIV X0, X0, X1             // x0=x0/x1
BL printX0                  // should be 0x1111111111111110


// let us do the same with the Signed version
// lets divide 0xFFFFFFFFFFFFFFFC by 0xF
MOV X0, 0XFFFFFFFFFFFFFFFC  // x0=0xfffffffffffffffc
MOV X1, 0XF                 // x1=0xf
SDIV X0, X0, X1             // x0=x0/x1
BL printX0                  // should be 0x0
// why ?
// in signed operations 0xFFFFFFFFFFFFFFFc is -4
// -4/F = 0

// One more strange thing to note is that divide by zero is not detected 
// and results in a 0
MOV X0, #1
MOV X1, #0
UDIV X0, X0, X1     //should trigger a divide by 0 error
BL printX0          // results in a 0 instead
// User beware



// Modulus
/*
There is no modulus calcuation in the instruction set so we need to get clever
First we do the division, then we multiply it back out and subtract that from the original
7 mod 2 would be done like this
7/2 = 3
3*2=6
7-6 = 1

To make this simpler there is a command that does multiply subtract
*/
// MSUB
// MSUB Xd, Xn, Xm, Xa     Xd=Xa-(Xn*Xm)
// lets use this to replicate the 7%2 problem
MOV X0, #7          // x0=7
MOV X1, #2          // X1=2
UDIV X2, X0, X1     // X2=X0/X1
MSUB X0, X2, X1, X0 // X0=x0-(x2*x1) 
BL printX0          // 1

// This construct is a bit tough to get used to so be sure to note this down, or at least
//where to find this !




// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call

