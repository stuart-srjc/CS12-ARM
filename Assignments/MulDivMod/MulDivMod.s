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
// multiply 8 times 10 and print out the result

// Your code goes here





// that looks pretty simple so far, but now lets multipy somthing bigger
// Multiply 0x2000000000 time 0x10000000 

// Your code goes here





// But wait, it is not instead it shows the value 0x0
// What happened?
// You should be able to answer what happened ?, otherwise please review the lecture/notes


// Multiply High
// we can combine MUL wiht SMULH to get the top 64bits of the multiplication 
// SMULH and UMULH  
// SMULH    Xd, Xn, Xm
// UMULH    Xd, Xn, Xm

// Lets do the same multiplication as above with SMULH

// Your codes goe here

// we used the signed version of MULH there is an unsinged version as well, lets take a look at both of them using a value 0x8000000000000000 and multiplying that by 0x10
// 

// Your code goes here




// SMULH

// Your code goes here





// UMULH

/* 
The values are 
0xFFFFFFFFFFFFFFF8
0x0000000000000008

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


// Multiply the values 0x80000000 * 0x10
// Let us start with the unsigned version

// Your code goes here
// UMULL





// Let us follow with the signed version

// Your code goes here
// UMULL






// Division 
// SDIV and UDIV 
// SDIV Xd, Xn, Xm
// UDIV Xd, Xn, Xm
// lets divide 0x8000000000000000 by 0x5

// your code goes here






// let us do the same with the Signed version
// lets divide 0x8000000000000000 by 0x5

// your code goes here





// why do these numbers differ?

// One more strange thing to note is that divide by zero is not detected 
// and results in a 0
// User beware

// divide a number by zero and print the result

// your code goes here







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

// Using UDIV and MSUB divide 22 by 7 then print out the Modulus

// Your code goes here





// This construct is a bit tough to get used to so be sure to note this down, or at least
//where to find this !



// Turn in a screen shot of the output of a run of your work
// Turn in the .s file 

/*
The output should look like the below listing:

0x0000000000000050
0x0000000000000000
0x0000000000000002
0xFFFFFFFFFFFFFFF8
0x0000000000000008
0x0000000800000000
0xFFFFFFF800000000
0x1999999999999999
0xE666666666666667
0x0000000000000000
0x0000000000000001

*/


// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






