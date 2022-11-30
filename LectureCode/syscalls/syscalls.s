.data  // start of the data segment

// create a helloworld variable and size variable
helloWorld: 
	.asciz "Hello World of Assembly!\n"
helloSize = .-helloWorld

// File Buffer to read into
fileBuffer: .skip 100*1  // skip 100 bytes
.equ bufferSize,     100 

// File Flags for Linux calls
.equ READ,      0       // Open the file Read Only
.equ WRITE,     1       // Open the file Write Only
.equ RDWR,      0666    // Open the file Read and Write
.equ CREATE,    0100    // if the file does not exist create it
.equ AT_FDCWD,  -100


// names of the files we want to work with
testme:     .asciz  "testme.txt"
input:      .asciz  "input.txt"
output:     .asciz  "output.txt"


// some text to output
outText: 
	.asciz "Here is some text for us to write to a file!\n"
outSize = .-outText
.align


.text  // start o the text segment (Code)


.global _start // Linux Standard _start, similar to main in C/C++ 
_start:


// Our first example of a system call is the one we have used all semester
// Print, essentialy this code does this in c
// cout << helloWorld;
mov x0, #0           // stdout
ldr x1, =helloWorld  // store the address of helloWorld into x1
ldr x2, =helloSize   // store the size of the hellowWorld string into x2
mov x8, #64          // store 64 to x8, this is the linux write call
svc 0                // Linux service call

// Example Read from a file

// Open a file
mov x0, AT_FDCWD        //  Use the current working directory 
ldr x1, =input          // open the input file
mov x2, READ            // for reading
mov x3, RDWR            // with read write permisions
mov X8, #56             // openat
svc 0                   // make the call

mov x9, x0              // save the file pointer into x9

// read some characters 
mov x0, x9           // read from the file
ldr x1, =fileBuffer  // store the address 
ldr x2, =bufferSize   // store the size
mov x8, #63          // read 
svc 0                // Linux service call

// write the buffer to the screen
mov x0, #0           // stdout
ldr x1, =fileBuffer  // store the address 
ldr x2, =bufferSize   // store the size 
mov x8, #64          // write
svc 0                // Linux service call

// close the file
mov x0, x9
mov x8, #57
svc 0

// Example write to a file

// Open a file
mov x0, AT_FDCWD        //  Use the current working directory 
ldr x1, =output         // open the input file
mov x2, CREATE+WRITE    // for reading
mov x3, RDWR            // with read write permisions
mov X8, #56             // openat
svc 0                   // make the call

mov x9, x0              // save the file pointer into x9

// write some characters 
mov x0, x9           // write to the file
ldr x1, =outText  // store the address 
ldr x2, =outSize   // store the size
mov x8, #64          // write 
svc 0                // Linux service call


// close the file
mov x0, x9
mov x8, #57
svc 0











// our last example we have also been using all semester long
// Exit to the OS, essentially this code does this in c
// return 0;
mov x0, #0          // return value
mov x8, #93         // Service call code
svc 0               // Linux service call






