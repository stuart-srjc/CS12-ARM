// GDB Command descriptions

/*
GDB Commands
b main - Puts a breakpoint at the beginning of the program
b - Puts a breakpoint at the current line
b N - Puts a breakpoint at line N
b +N - Puts a breakpoint N lines down from the current line
b fn - Puts a breakpoint at the beginning of function "fn"
d N - Deletes breakpoint number N
info break - list breakpoints
r - Runs the program until a breakpoint or error
c - Continues running the program until the next breakpoint or error
f - Runs until the current function is finished
s - Runs the next line of the program
s N - Runs the next N lines of the program
n - Like s, but it does not step into functions
u N - Runs until you get N lines in front of the current line
p var - Prints the current value of the variable "var"
bt - Prints a stack trace
u - Goes up a level in the stack
d - Goes down a level in the stack
q - Quits gdb

Source:
https://www.tutorialspoint.com/gnu_debugger/gdb_commands.htm
accessed 7/15/2022
*/

/*
x command
Displays the memory contents at a given address using the specified format.

Syntax
x [Address expression]
x /[Format] [Address expression]
x /[Length][Format] [Address expression]
x
Parameters
Address expression
Specifies the memory address which contents will be displayed. This can be the address itself or any C/C++ expression evaluating to address. The expression can include registers (e.g. $eip) and pseudoregisters (e.g. $pc). If the address expression is not specified, the command will continue displaying memory contents from the address where the previous instance of this command has finished.
Format
If specified, allows overriding the output format used by the command. Valid format specifiers are:
o - octal
x - hexadecimal
d - decimal
u - unsigned decimal
t - binary
f - floating point
a - address
c - char
s - string
i - instruction
The following size modifiers are supported:

b - byte
h - halfword (16-bit value)
w - word (32-bit value)
g - giant word (64-bit value)
Length
Specifies the number of elements that will be displayed by this command.

Source:
https://visualgdb.com/gdbreference/commands/x
accessed 7/16/2022
*/


// Code begins here, follow along with the comments

.data  // start of the data segment

// create a debugworld variable and size variable
debugString: 
	.asciz "Debugger Assignment\n"
debugSize = .-debugString

// Some data values to view
byteArray:    
    .byte   0x1, 0x2, 0x3, 0x4, 0x5  // Array or doublewords


.text  // start o the text segment (Code)

.global _start // Linux Standard _start, similar to main in C/C++ 
_start:

// Print, essentialy this code does this in c
// cout << debugString;
ldr x1, =debugString  // store the address of debugString into x1
ldr x2, =debugSize   // store the size of the debugwWorld string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

mov x0, 0 // set x0 to 0 to watch it change
// Walk through the array byte by byte 
// Set a break point for the line below this, note the value of x0
// b 60 (This is an example the actual line number may be different)
// run
// info register x0
ldr x0, =byteArray
// The value should have shown 0 for x0 now lets go to the next line and see it change
// next
// info register x0
// you should see something lik 0x41010d
// What is this?  it is the address that is pointed to by the label byteArray
// we want to get the value stored in the first byte of the array
// lets first look at the value in x1
// info register x1
// next 
ldrsb x1, [x0]
// now the register should read 0x1 the first byte in our array
// do not worry about the code as much as the action of the debugger
// as we step through the code we can watch the values of the registers
// try running this
// info registers
// *
// Take a screen shot here that shows the values of the registers and the work you have done to this point, you will turn this in to get credit for this assignment.
// *
// This shows all the registers, now try 
//info registers x0 x1 x2 pc
// this is a great way to see what values are in the registers at a given time
// try running 
// s 2
// this will run the next 2 lines it is like typing skip twice
ldrsb x2, [x0,1]!
ldrsb x3, [x0,1]!
// info registers x1 x2 x3
// you should see the first 3 values of our array
// lets take a quick peek at printing memory values (Labels)
// let us look at the value in byteArray
// x/w &byteArray 
// you should see something similar to 0x41010d
// This is the hexidecimal value of the memory address pointed to by the byteArray label
// to see the values we use the same command but we request the first byte
// x/b &byteArray
// then to see all 4 values in our array 
// x/4b &byteArray
// this should show you 0x1 to 0x4
// finally lets look at the string value ponted to by the debugString label
// x/s &debugString
// you should see "Debugger Assignment\n"
// *
// Take a screen shot here that shows the values of the registers and the work you have done to this point, you will turn this in to get credit for this assignment.
// *
// to quit the debugger simply type
// quit
// if it asks Quit Anyway, you can answer with  y

// Turn in the 2 screen shots requested above
// it is suggested that you play around a bit and understand how to use the debugger, it will be very valuable while programming in a low level language like assembly!

// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call




