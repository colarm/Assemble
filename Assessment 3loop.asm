; The process to count an array
; Author: Haicheng Zhao
; Submit Date: 4/12/2024

; In this program: 
; R1 used to load elements in array
; R2 behaves the length of array
; R3 behaves the counter of loop
; R4 temporaryly store one-time value
; R5 temporaryly store sums and counts


; Start
; Load and initialize
        LOAD	R2,size[R0]	; Load size of array

; Loop to calculate negsum
	LEA	R5,0[R0]	; int negsum = 0
	LEA	R3,0[R0]	; int i = 0
LOOP0	CMPLT	R4,R3,R2	; Check i < size, load the value to a temporary register R4
	JUMPF	R4,LOOPEND0[R0]	; If the condition is false, jump to LOOPEND0

	LOAD	R1,array[R3]	; Load array[i] to R1
	CMPLT	R4,R1,R0	; Check array[i] < 0, load the value to a temporary register R4
	JUMPF	R4,SKIP0[R0]	; If the condition is false, jump to SKIP0
	ADD	R5,R5,R1	; negsum += array[i]
SKIP0

	LEA	R4,1[R0]	; Load 1 to a temporary register R4
	ADD	R3,R3,R4	; ++i
	JUMP	LOOP0[R0]	; Jump back to the beginning of loop
LOOPEND0
	STORE	R5,negsum[R0]	; Store the value to variable

; Loop to calculate pzcount
	LEA	R5,0[R0]	; int pzcount = 0
	LEA	R3,0[R0]	; int i = 0
LOOP1	CMPLT	R4,R3,R2	; Check i < size, load the value to a temporary register R4
	JUMPF	R4,LOOPEND1[R0]	; If the condition is false, jump to LOOPEND1

	LOAD	R1,array[R3]	; Load array[i] to R1
	CMPLT	R4,R1,R0	; Check array[i] < 0, load the value to a temporary register R4
	JUMPT	R4,SKIP1[R0]	; If the condition is true, jump to SKIP1
	LEA	R4,1[R0]	; Load 1 to a temporary register R4
	ADD	R5,R5,R4	; ++pzcount
SKIP1

	LEA	R4,1[R0]	; Load 1 to a temporary register R4
	ADD	R3,R3,R4	; ++i
	JUMP	LOOP1[R0]	; Jump back to the beginning of loop
LOOPEND1
	STORE	R5,pzcount[R0]	; Store the value to variable

; Loop to calculate oddcount
	LEA	R5,0[R0]	; int oddcount = 0
	LEA	R3,0[R0]	; int i = 0
LOOP2	CMPLT	R4,R3,R2	; Check i < size, load the value to a temporary register R4
	JUMPF	R4,LOOPEND2[R0]	; If the condition is false, jump to LOOPEND2

	LOAD	R1,array[R3]	; Load array[i] to R1
	LEA	R4,2[R0]	; Load 2 to a temporary register R4
	DIV	R0,R1,R4	; Calculate array[i] % 2, the value is in R15
	CMPEQ	R4,R15,R0	; Check array[i] % 2 == 0, load the value to a temporary register R4
	JUMPT	R4,SKIP2[R0]	; If the condition is true, jump to SKIP2
	LEA	R4,1[R0]	; Load 1 to a temporary register R4
	ADD	R5,R5,R4	; ++oddcount
SKIP2

	LEA	R4,1[R0]	; Load 1 to a temporary register R4
	ADD	R3,R3,R4	; ++i
	JUMP	LOOP2[R0]	; Jump back to the beginning of loop
LOOPEND2
	STORE	R5,oddcount[R0]	; Store the value to variable

	
; Exit the program
DONE	TRAP	R0,R0,R0


; Data Section
array	DATA	3	; 12 elements of array
	DATA	-6
	DATA	27
	DATA	101
	DATA	50
	DATA	0
	DATA	-20
	DATA	-21
	DATA	19
	DATA	6
	DATA	4
	DATA	-10
size	DATA	12	; The length of array

negsum	DATA	0	
pzcount	DATA	0
oddcount	DATA	0
overflow	DATA	0