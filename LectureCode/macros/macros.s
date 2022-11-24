// Macros go here

// Multiply by 4
.MACRO mulby4 register
LSL \register, \register, #2
.ENDM

/*
push
push a register to the stack
parameters:  register, the register to be pushed onto the stack
precondition: none
postcondition: passed in registers value is added to the stack and the stack pointer is pointing to it
return:    n/a
*/
.macro push register
	str \register, [sp, #-16]!  // store the value in the memory location pointed to by sp and decrement by 16
.endm

/*
pop
pop a register from the stack
parameters:  register, the register to be popped from the stack
precondition: the value has been pushed into the stack
postcondition: the passed in registers value copied from the stack and the stack pointer is pointing the next value on the stack
return:    n/a
*/
.macro pop register
	ldr \register, [sp], #16  // load the value in the memory location pointed to by sp and increment by 16
.endm

/*
endl, print an endline preserve all registers used
parameters: none
precondition: none 
postcondition: an endline character has been output to stdout
return: none
*/
.MACRO endl
push X0                 // preserve the registers we are going to use
push X1
push X2
push X8

mov x0, #0             // std out
ldr x1, =endline       // store the address of macro into x1
ldr x2, =endlineSize   // store the size of the macro string into x2
mov x8, #64            // store 64 to x8, this is the linux write call
svc 0     

pop X8                  // restore the registers
pop X2
pop X1
pop X0
.ENDM

/*
newDeck deck
parameters: deck, the address of the array of cards
precondition: the deck array must exist, and can have any value in each byte
postcondition: the deck array is initialized from 0 to 51
return: none
*/
// create a new deck of cards
.MACRO newDeck deck
push X12                // preserve the register we will be using
push X15

MOV X12, #0
LDR X15, =\deck         // point to the deck
//BL printX15
//nextCard:             // original label
1:                      // because we cannot use the same label twice, unless it is numeric
STRB W12, [X15], #1     //Store the value of the counter into the deck and increment the deck by 1
//BL printX12
ADD X12, X12, #1        // Increment the counter
CMP X12, #51            // 0 to 51 is our card set
//B.LE nextCard         // original branch to the label
B.LE 1b                 // branch to the next label 1 in the backward direction 

pop X15                 // restore the registers
pop X12
.ENDM
  

/*
printCardValue, display a cards value A23456789TJQK to stdout without a newline
parameters: cardNumber
precondition: the cardNumber must be a value between 0 and 51
              there must exist an array with the values "A23456789TJQK" named values 
postcondition: the single character representing the value of the card will be output to stdout
return: none
*/
// print a cards value without a new line
.MACRO printCardValue cardNumber
push X0                 // we will learn more about this later, 
push X1                 // basically save all the registers were about to use
push X2
push X8
push X15
push X16
push X17 

// first we need to get the modulus of the cardNumber
MOV X15, \cardNumber        // X15 is the value passed into the function
MOV X16, #13                // x16 is set to 13
                            // this gets a bit hard to follow here
UDIV X17, X15, X16          // x17=cardNumber/13
MSUB X15, X17, X16, X15     // X15=x15-(X17*X16) 
                            // Subtract from the dividend the product of the quotient times the divisor 
                            // This becomes the modulus or remainder of the division
                            // so for cardNumber 32  divide 32/13 = 2
                            // then 32 - 2 * 13 = 6
                            // 32 % 13 = 6

                        // now print out the value in the array pointed to by the modulus
MOV X0, #0              // std out
LDR X1, =values         // store the address of the values array into X2
ADD X1, X1, X15         // offset by X15 bytes into the array  A23456789TJQK  sor if its a 11 then J 
MOV X2,  #1             // store the size of the macro string into x2
MOV X8, #64             // store 64 to x8, this is the linux write call
SVC 0    

pop X17                 // replace the values in the registers we used so they have the values
pop X16                 // that they had before we started
pop X15
pop X8
pop X2
pop X1
pop X0
.ENDM


.data  // start of the data segment

// create a macroworld variable and size variable
macro: 
	.asciz "Hello World of Assembly!\n"
macroSize = .-macro

endline: 
	.asciz "\n"
endlineSize = .-endline

/*
There are 52 cards in a standard playing deck (discarding the jokers)
4 suits with 13 cards each
Hearts, Diamonds, Clubs and Spades
This means we can represent the value and suit of a card in one byte of data
0 through 51 
the data types we will use to define the cards will be
A byte to represent the deck of cards itself
2 Arrays to present the data to the user
Using the byte we will use the numbers between 0 and 51 to represent the deck
to determine the suit of the card we will use Div 13
to determine the value of the card we will use Mod 13
example the 4 of Spades would come after all hearts, Diamonds and Clubs
Hearts      A23456789TJQK
Diamonds    A23456789TJQK
Clubs       A23456789TJQK
Spades      A23456789TJQK
it is the 43rd card in the deck
43 divided by 13 = 3
43 Mod 13 = 4
if we represent the cards as shown below
*/

suits: .ascii "HDCS"            // The deck has 4 suites Hearts, Diamonds, Clubs and Spades
values: .ascii "A23456789TJQK"  // The deck has 13 cards A=1 for this assignment T=10 Jack, Queen and King 
/*
and use 0 reference suits[3] is S for Spades
for values we subtract 1, 4-1=3 then reference values[3]
A deck of cards will be represented by 52 bytes as shown below
*/
deck1:  .skip 52
deck2:  .skip 52
deck3:  .skip 52
/*
Lets write a Macro to create a new deck of cards, which comes in order of values and suits
*/


.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:

// Print, essentialy this code does this in c
// cout << macroWorld;
mov x0, #0           // std out
ldr x1, =macro       // store the address of macro into x1
ldr x2, =macroSize   // store the size of the macro string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call


// test mulby4 with X2 set to 5
MOV X2, #5
mulby4 X2
BL printX2
endl
BL printX2 // note that the endl did not change the value here 

newDeck deck1 
endl 

newDeck deck2 
endl

MOV X12, #0
nextCardPrint:
printCardValue X12
ADD X12, X12, #1          // Increment X2
CMP X12, #51             // Stop at 51
B.LE nextCardPrint
endl



// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






