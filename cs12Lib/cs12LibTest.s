.data

greet: .ascii "\nTesting String: Input a string!\n"
greetSize = .-greet

input: .ascii "12345678901234567890123456789012345678901234567890\n"
inputSize = .-input

rand: .ascii "\nTesting Random Number!\n"
randSize = .-rand
randMax: .word 100

reg: .ascii "\nTesting printRx functions!\n"
regSize = .-reg

div: .ascii "\nTesting division!\n"
divSize = .-div

.text
// Pointers declared here
randMaxAddr: .word randMax  
randNumAddr: .word randMax  


.global _start

_start:

//test print register
ldr x1, =reg
ldr x2, =regSize
bl printString
mov x0, #0xabc
lsl x0, x0, #16
mov x1, #0xabc1
mov x2, #0xabc2
bl printR0
bl printR1
bl printR2
bl printR3
bl printR4
bl printR5
bl printR6
bl printR7
bl printR8
bl printR9
bl printR10
bl printR11
bl printR12
bl printR13
bl printR14
bl printR15 

//test RandomNumber
ldr x1, =rand
ldr x2, =randSize
bl printString

ldr x1, randMaxAddr
mov x0, #1000
bl getRandomNumber
bl printR0

mov x0, #100
bl getRandomNumber
bl printR0

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

//test getNumber
ldr x1, =greet
ldr x2, =greetSize
bl printString

//ldr x1, =input
//ldr x2, =inputSize
//bl getHexNumber
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



//bl exit 
bl exitNormal


