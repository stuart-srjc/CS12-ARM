.data  // start of the data segment

// create a helloworld variable and size variable
helloWorld: 
	.asciz "Hello World of Assembly!\n"
helloSize = .-helloWorld

.text  // start o the text segment (Code)

// declare the globally available functions here
.globl sum 
.globl printVals 

/*
sum int, int
parameters: X0, first number to add
            X1, second number to add 
precondition: X0 and X1  have a values 
postcondition: X0, has a value in it that is the sum of the values passed as parameters 
return: X0, the sum of the passed in values
*/
sum:
ADD X0, X0, X1  // add the numbers together and return them in X0
ret


printVals:
// we are about to push to the stack to preserve LR which subtracts 16 from the stack
// best way to handle this is to use a tempory stack pointer for the rest of the function
// Then we do not care how much we push and pop
MOV X18, SP // this makes X18 our "Base Pointer" to the stack as we do not need to preserve it 
            // we can use this then just exit the function
STR LR, [SP, #-16]!     // push the LR register for nested functions

// print out all the easy stuff
BL printX0
BL printX1
BL printX2
BL printX3
BL printX4
BL printX5
BL printX6
BL printX7
// done with the easy part now have to pull from the stack
// the variables are pushed on the stack in reverse order
// so have to store and print them pulling from the stack
// we have pushed to the stack to preserve LR which subtracts 16 from the stack
// best way to handle this is to use a tempory stack pointer for the rest of the function
// Then we do not care how much we push and pop
// note we are using integers, so we want to ensure we only get 32bits so we use W vs X for the register
LDR W0, [X18]  // Because we push in reverse order we can expect our 9th parameters address here
BL printX0

LDR W0, [X18, #8]  // Because we push in reverse order we can expect our 10th parameter here
BL printX0

LDR W0, [X18, #16]  // Because we push in reverse order we can expect our 11th parameter here
BL printX0
 
lDR LR, [SP],#16        // pop the LR register 
ret
