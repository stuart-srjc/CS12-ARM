.data
registerString: .skip 17
registerSize = .-registerString

hex: .ascii "0x"
hexSize = .-hex
tempBytes: .word 0x0


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//push Register Macro 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.macro push register
	str \register, [sp, #-16]!
.endm

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//pop Register Macro 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.macro pop register
	ldr \register, [sp], #16
.endm

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//print Register Macro 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.macro printReg	register
	//prologue
	push x0
	push x11
	push lr
	add x11, sp, #0

	mov x0, \register 
	bl printRegister

	//epilog
	sub sp, x11, #0
	pop lr 
	pop x11
	pop x0
	ret
.endm



.text 
tempPtr: .word tempBytes

.global printString 
.global getString 
.global getHexNumber 
.global exit
.global exitNormal 
.global getRandomNumber
.global divide
.global printR0
.global printR1
.global printR2
.global printR3
.global printR4
.global printR5
.global printR6
.global printR7
.global printR8
.global printR9
.global printR10
.global printR11
.global printR12
.global printR13
.global printR14
.global printR15

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//print Register 0
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printRx:
//prologue
push x0
push x11
push lr

add x11, sp, #0

bl printRegister

//epilog
sub sp, x11, #0
pop lr 
pop x11
pop x0
ret



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//print Register Macros
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printR0:
printReg x0
//~~~
printR1:
printReg x1
//~~~
printR2:
printReg x2
//~~~
printR3:
printReg x3
//~~~
printR4:
printReg x4
//~~~
printR5:
printReg x5
//~~~
printR6:
printReg x6
//~~~
printR7:
printReg x7
//~~~
printR8:
printReg x8
//~~~
printR9:
printReg x9
//~~~
printR10:
printReg x10
//~~~
printR11:
printReg x11
//~~~
printR12:
printReg x12
//~~~
printR13:
printReg x13
//~~~
printR14:
printReg x14
//~~~
printR15:
printReg x15
//~~~
printR6:
printReg x16
//~~~
printR7:
printReg x17
//~~~
printR8:
printReg x18
//~~~
printR9:
printReg x19
//~~~
printR10:
printReg x20
//~~~
printR1:
printReg x21
//~~~
printR2:
printReg x22
//~~~
printR3:
printReg x23
//~~~
printR4:
printReg x24
//~~~
printR5:
printReg x25
//~~~
printR6:
printReg x26
//~~~
printR7:
printReg x27
//~~~
printR8:
printReg x28
//~~~
printR9:
printReg x29
//~~~
printR10:
printReg x30


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//print Register pointed to by R0
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printRegister:
//prologue
push x0
push x1
push x2
push x3
push x4
push x11
push lr

add x11, sp, #0

//body
mov x4, #0
mov x3, #15
mov x5, #0xf //using and with this gives only the last nibble

ldr x1, =registerString
forEachNibble:
and x2, x5, x0
lsr x0, x0, #4
cmp x2, #9
b.hi higher
add x2, x2, #0x30
b lower
higher:
add x2, x2, #0x37
lower:

strb w2, [x1, x3]
sub x3, x3, #1
add x4, x4, #1

cmp x4, #16 //16 nibbles in a register
bls forEachNibble

// printString
push x1
push x2
ldr x1, =hex
ldr x2, =hexSize
bl printString
pop x2
pop x1

mov x2, #0xa //add the newline
mov x3, #16
strb w2, [x1, x3]
mov x2, #17 //number of characters plus newline
bl printString

//epilog
sub sp, x11, #0
pop lr
pop x11
pop x4
pop x3
pop x2
pop x1
pop x0
ret

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// get a random number from 0 to x0 and return in x0
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
getRandomNumber:
//prologue
push x1
push x2
push x3
push x7
push x11
push lr

add x11, sp, #0

//preserve the address of the buffer
// x3 will be from 0 to x3 -1, so we need to add 1
mov x3, #0
add x3, x0, #1

ldr x0, =tempBytes

//call random syscall
mov x1, #4 	//bytes
mov x2, #0 	//flags
mov x8, #0x116	//random
svc #0 		// software interupt

// move results into x0 for returning
ldr x0, =tempBytes
ldr x0, [x0]

// set the divisor
mov x1, x3
udiv x2, x1, x3
msub x0, x2, x3, x1 

//epilog
sub sp, x11, #0
pop lr
pop x11
pop x7
pop x3
pop x2
pop x1
ret

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// prints R2 characters starting at R1 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printString:
//prologue
push x11
push lr
add x11, sp, #0

//body
mov x0, #1 	// stdout
mov x8, #64	// write syscall
svc #0 		// software interupt

//epilog
sub sp, x11, #0
pop lr
pop x11
ret

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// inputs R2 characters from the keyboard placing them in R1 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
getString:
//prologue
push x11
push lr
add x11, sp, #0

//body
mov x0, #1 	// stdin
mov x8, #64 	// write syscall
svc #0 		// software interupt

//epilog
sub sp, x11, #0
pop lr
pop x11
ret

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// inputs R2 characters from the keyboard placing them in R1 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
getHexNumber:
//prologue
push x11
push lr
add x11, sp, #0

//body
mov x0, #1 	// stdin
mov x8, #64 	// write syscall
svc #0 		// software interupt

//epilog
sub sp, x11, #0
pop lr
push x11
ret

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// exit the application with the value in R0 reflecting the return value
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
exit:
mov x8, #93
svc 0

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// exit the application with a return value of 0
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
exitNormal:
mov x0, #0
bl  exit

