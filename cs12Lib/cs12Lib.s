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
.global printX0
.global printX1
.global printX2
.global printX3
.global printX4
.global printX5
.global printX6
.global printX7
.global printX8
.global printX9
.global printX10
.global printX11
.global printX12
.global printX13
.global printX14
.global printX15
.global printX16
.global printX17
.global printX18
.global printX19
.global printX20
.global printX21
.global printX22
.global printX23
.global printX24
.global printX25
.global printX26
.global printX27
.global printX28
.global printX29
.global printX30

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//push General Purpose Registers
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.macro pushGP
push x0
push x1
push x2
push x3
push x4
push x5
push x6
push x7
push x8
push x9
push x10
push x11
push x12
push x13
push x14
push x15
push x16
push x17
push x18
push x19
push x20
push x21
push x22
push x23
push x24
push x25
push x26
push x27
push x28
push x29
.endm

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//pop General Purpose Registers
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.macro popGP
pop x29
pop x28
pop x27
pop x26
pop x25
pop x24
pop x23
pop x22
pop x21
pop x20
pop x19
pop x18
pop x17
pop x16
pop x15
pop x14
pop x13
pop x12
pop x11
pop x10
pop x9
pop x8
pop x7
pop x6
pop x5
pop x4
pop x3
pop x2
pop x1
pop x0
.endm



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//print Register 0
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printXx:
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
printX0:
printReg x0
//~~~
printX1:
printReg x1
//~~~
printX2:
printReg x2
//~~~
printX3:
printReg x3
//~~~
printX4:
printReg x4
//~~~
printX5:
printReg x5
//~~~
printX6:
printReg x6
//~~~
printX7:
printReg x7
//~~~
printX8:
printReg x8
//~~~
printX9:
printReg x9
//~~~
printX10:
printReg x10
//~~~
printX11:
printReg x11
//~~~
printX12:
printReg x12
//~~~
printX13:
printReg x13
//~~~
printX14:
printReg x14
//~~~
printX15:
printReg x15
//~~~
printX16:
printReg x16
//~~~
printX17:
printReg x17
//~~~
printX18:
printReg x18
//~~~
printX19:
printReg x19
//~~~
printX20:
printReg x20
//~~~
printX21:
printReg x21
//~~~
printX22:
printReg x22
//~~~
printX23:
printReg x23
//~~~
printX24:
printReg x24
//~~~
printX25:
printReg x25
//~~~
printX26:
printReg x26
//~~~
printX27:
printReg x27
//~~~
printX28:
printReg x28
//~~~
printX29:
printReg x29
//~~~
printX30:
printReg x30


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//print Register pointed to by R0
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printRegister:
//prologue
pushGP
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
popGP
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

