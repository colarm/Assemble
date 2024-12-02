; The process to count an array
; Author: Haicheng Zhao
; Submit Date: 4/12/2024

; In this program: 
; R1 used to load elements in array X
; R2 stores the length of array X
; R3 stores loop counter (i)
; R4 stores temporary value
; R5 stores negsum
; R6 stores pzcount
; R7 stores oddcount
; R8 stores overflow


; Start
; Load and initialize
        LOAD	R2,size[R0]	; Load size of array X
	LEA	R5,0[R0]	; negsum = 0
	LEA	R6,0[R0]	; pzcount = 0
	LEA	R7,0[R0]	; oddcount = 0
	LEA	R8,0[R0]	; overflow = 0 (false)

; Loop to process array X
; for (int i = 0; i < size; ++i)
	LEA	R3,0[R0]	; i = 0
LOOP	CMPLT	R4,R3,R2	; Check i < size register R4
	JUMPF	R4,LOOPEND[R0]	; Exit loop if i >= size

; Process negsum and overflow
; if (X[i] < 0)
IF	LOAD	R1,X[R3]	; Load X[i] to R1
	CMPLT	R4,R1,R0	; Check if X[i] < 0
	JUMPF	R4,ELSE[R0]	; Jump to ELSE if not negative

; negsum += X[i]
	ADD	R5,R5,R1	; negsum += X[i]

; if (negsum >= 0)
IF1	CMPLT	R4,R5,R0	; Check if negsum < 0
	JUMPT	R4,IFEND1[R0]	; Jump to IFEND1 if negsum < 0

; overflow = true
	LEA	R8,1[R0]	; Set overflow = true

IFEND1
	JUMP	ELSEEND[R0]	; Jump to ELSEEND to skip the else block
IFEND

; else
ELSE

; ++pzcount
	LEA	R4,1[R0]	; Set R4 = 1
	ADD	R6,R6,R4	; ++pzcount

; if ((X[i] & 1) != 0)
IF2	AND	R4,R1,R4	; Check if X[i] & 1 != 0
	JUMPF	R4,IFEND2[R0]	; Jump to IFEND2 if X[i] is not odd

; ++oddcount
	LEA	R4,1[R0]	; Set R4 = 1
	ADD	R7,R7,R4	; ++oddcount
IFEND2

ELSEEND

	LEA	R4,1[R0]	; Set R4 = 1
	ADD	R3,R3,R4	; ++i
	JUMP	LOOP[R0]	; Jump back to the beginning of loop
LOOPEND
	STORE	R5,negsum[R0]	; Store negsum
	STORE	R6,pzcount[R0]	; Store pzcount
	STORE	R7,oddcount[R0]	; Store oddcount
	STORE	R8,overflow[R0]	; Store overflow

; Exit the program
DONE	TRAP	R0,R0,R0


; Data Section
X	DATA	3	; 12 elements of array X
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
size	DATA	12	; The length of array X

negsum	DATA	0	
pzcount	DATA	0
oddcount	DATA	0
overflow	DATA	0