; The process to count an array
; Author: Haicheng Zhao
; Submit Date: 4/12/2024

; In this program: 
; R1 used to load elements in array
; R2 behaves the length of array
; R3 behaves the counter of loop (i)
; R4 temporaryly store one-time value
; R5 store negsum
; R6 store pzcount
; R7 store oddcount
; R8 store overflow


; Start
; Load and initialize
        LOAD	R2,size[R0]	; Load size of array
	LEA	R5,0[R0]	; int negsum = 0
	LEA	R6,0[R0]	; int pzcount = 0
	LEA	R7,0[R0]	; int oddcount = 0
	LEA	R8,0[R0]	; int overflow = 0 (false)

; Loop to calculate negsum
; for (int i = 0; i < size; ++i)
	LEA	R3,0[R0]	; int i = 0
LOOP	CMPLT	R4,R3,R2	; Check i < size, load the value to a temporary register R4
	JUMPF	R4,LOOPEND[R0]	; If the condition is false, jump to LOOPEND0

; if (array[i] < 0)
IF	LOAD	R1,array[R3]	; Load array[i] to R1
	CMPLT	R4,R1,R0	; Check array[i] < 0, load the value to a temporary register R4
	JUMPF	R4,ELSE[R0]	; If the condition is false, jump to ELSE

; negsum += array[i]
	ADD	R5,R5,R1	; R5 += R1

; if (negsum >= 0)
IF1	CMPLT	R4,R5,R0	; Check negsum < 0, load the value to a temporary register R4
	JUMPT	R4,IFEND1[R0]	; If the condition is true, jump to IFEND1

; overflow = true
	LEA	R8,1[R0]	; Set overflow to 1

IFEND1
	JUMP	ELSEEND[R0]	; Jump to ELSEEND to skip the else block
IFEND

; else
ELSE

; ++pzcount
	LEA	R4,1[R0]	; Set temporary value to 1
	ADD	R6,R6,R4	; R6 add 1

; if (array[i] % 2 != 0)
IF2	LEA	R4,2[R0]	; Set temporary value to 2
	DIV	R0,R1,R4	; Divide R1 by R4(2), abandon the 商, and save the 余数 in R15
	CMPEQ	R4,R15,R0	; Check array[i] % 2 == 0, load the value to a temporary register R4
	JUMPT	R4,IFEND2[R0]	; If the condition is true, jump to IFEND2

; ++oddcount
	LEA	R4,1[R0]	; Set temporary value to 1
	ADD	R7,R7,R4	; R7 add 1
IFEND2

ELSEEND

	LEA	R4,1[R0]	; Load 1 to a temporary register R4
	ADD	R3,R3,R4	; ++i
	JUMP	LOOP[R0]	; Jump back to the beginning of loop
LOOPEND
	STORE	R5,negsum[R0]	; Store R5 value to negsum
	STORE	R6,pzcount[R0]	; Store R6 value to pzcount
	STORE	R7,oddcount[R0]	; Store R7 value to oddcount
	STORE	R8,overflow[R0]	; Store R5 value to overflow

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