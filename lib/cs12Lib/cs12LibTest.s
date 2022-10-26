.data

greet: .ascii "\nTesting String: Input a string!\n"
greetSize = .-greet

input: .ascii "12345678901234567890123456789012345678901234567890\n"
inputSize = .-input

rand: .ascii "\nTesting Random Number!\n"
randSize = .-rand
randMax: .word 100

reg: .ascii "\nTesting printXx functions!\n"
regSize = .-reg

div: .ascii "\nTesting division!\n"
divSize = .-div

.text
// Pointers declared here
randMaxAddr: .word randMax  
randNumAddr: .word randMax  


.global _start

_start:

/*
//test print register
ldr x1, =reg
ldr x2, =regSize
bl printString
mov x0, #0xabc
lsl x0, x0, #16
mov x1, #0xabc1
mov x2, #0xabc2
*/
mov x0, #1
mov x1, #1
mov x2, #1
mov x3, #1
mov x4, #1
mov x5, #1
mov x6, #1
mov x7, #1
mov x8, #1
mov x9, #1
mov x10, #1
mov x11, #1
mov x12, #1
mov x13, #1
mov x14, #1
mov x15, #1

bl printX0
bl printX1
bl printX2
bl printX3
bl printX4
bl printX5
bl printX6
bl printX7
bl printX8
bl printX9
bl printX10
bl printX11
bl printX12
bl printX13
bl printX14
bl printX15 
/*
//test RandomNumber
ldr x1, =rand
ldr x2, =randSize
bl printString

ldr x1, randMaxAddr
mov x0, #1000
bl getRandomNumber
bl printX0

mov x0, #100
bl getRandomNumber
bl printX0

//test getString
//test printString
ldr x1, =greet
ldr x2, =greetSize
bl printString

ldr x1, =input
ldr x2, =inputSize
bl getString

ldr x1, =input
mov x2, x0
bl printString

*/

//test getNumber
ldr x1, =greet
ldr x2, =greetSize
bl printString

//ldr x1, =input
//ldr x2, =inputSize
bl getHexNumber
bl printX0
// not yet implemented

//ldr x1, =input
//mov x2, x0
//bl printString


//test exit with an error code
//bl exit

//need to modulus this, and figure out how to print...


//ldr x1, =greet
//ldr x2, =greetSize
//bl printString

mov x0, #10
bl getRandomNumber
bl printX0

mov x0, #255
bl getRandomNumber
bl printX0

mov x11, #11
bl printX11
bl printX11

//bl exit 
bl exitNormal


