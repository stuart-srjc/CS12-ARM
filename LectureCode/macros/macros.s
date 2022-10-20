// Macros go here

// Multiply by 4
.MACRO mulby4 register
LSL \register, \register, #2
.ENDM

.MACRO endl
mov x0, #0           // std out
ldr x1, =endline       // store the address of macro into x1
ldr x2, =endlineSize   // store the size of the macro string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0     
.ENDM


// create a new deck of cards
.MACRO newDeck deck
MOV X12, #0
LDR X15, =\deck          // point to the deck
BL printX15
//nextCard:               // original label
1:                      // because we cannot use the same label twice, unless it is numeric
STRB W12, [X15], #1     //Store the value of the counter into the deck and increment the deck by 1
BL printX12
ADD X12, X12, #1        // Increment the counter
CMP X12, #51            // 0 to 51 is our card set
//B.LE nextCard           // original branch to the label
B.LE 1b                 // branch to the next label 1 in the backward direction 
.ENDM
  
// print a cards value without a new line
.MACRO printCardValue cardNumber
// first we need to get the modulus of the cardNumber
MOV X0, \cardNumber
MOV X1, #13
UDIV X2, X0, X1         // x16=cardNumber/13
MSUB X0, X2, X1, X0     // X15=x15-(x15*x) 
BL printX0   

Not Quite right here

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
This means we can represent the value and suit of a card in 52 bits of data
0 through 51 
the most convienent data type is likely a byte per card
So to represent a deck of cards we will need 52 bytes
to determine the suit of the card we will use Div 13
to determine the value of the card we will use Mod 13
example the 4 of Spades would come after all hearts, Diamonds and Clubs
Hearts      A23456789TJQK
Diamonds    A23456789TJQK
Clubs       A23456789TJQK
Spades      A234
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

MOV X2, #5
mulby4 X2
BL printX2

endl

newDeck deck1 
newDeck deck2 

MOV X12, #13
nextCardPrint:
printCardValue X12
ADD X12, X12, #1          // Increment X2
CMP X12, #30             // Stop at 30
B.LE nextCardPrint




// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






