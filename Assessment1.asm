; The process to count an array
; Author: Haicheng Zhao
; Submit Date: 4/12/2024

; In this program: 
; R1 used to load elements in array
; R2 stores the length of the array
; R3 stores loop counter (i)
; R4 stores temporary value
; R5 stores negsum
; R6 stores pzcount
; R7 stores oddcount
; R8 stores overflow

; Start
; Load and initialize
        LOAD	R2,size[R0]	; Load size of array
	LEA	R5,0[R0]	; negsum = 0
	LEA	R6,0[R0]	; pzcount = 0
	LEA	R7,0[R0]	; oddcount = 0
	LEA	R8,0[R0]	; overflow = 0 (false)

; Loop to process the array
; for (int i = 0; i < size; ++i)
	LEA	R3,0[R0]	; i = 0
LOOP	CMPLT	R4,R3,R2	; Check i < size
	JUMPF	R4,END[R0]	; Exit loop if i >= size

	LOAD	R1,array[R3]	; Load array[i] to R1

; Process negsum and overflow
; if (array[i] < 0)
	CMPLT	R4,R1,R0	; Check if array[i] < 0
	JUMPF	R4,NONNEG[R0]	; Skip if not negative
	ADD	R5,R5,R1	; negsum += array[i]
	CMPLT	R4,R5,R0	; Check if negsum < 0
	JUMPT	R4,NONNEG[R0]	; If negsum < 0, no overflow
	LEA	R8,1[R0]	; Set overflow = true

NONNEG	; Count non-negative numbers
	CMPLT	R4,R1,R0	; Check if array[i] >= 0
	JUMPT	R4,ODD[R0]	; Skip pzcount increment if negative
	ADD	R6,R6,1		; ++pzcount

ODD	; Check odd numbers
	AND	R4,R1,1		; Check if array[i] is odd (LSB == 1)
	JUMPF	R4,SKIP[R0]	; Skip if not odd
	ADD	R7,R7,1		; ++oddcount

SKIP	LEA	R4,1[R0]	; i++
	ADD	R3,R3,R4
	JUMP	LOOP[R0]	; Continue loop

END	STORE	R5,negsum[R0]	; Store negsum
	STORE	R6,pzcount[R0]	; Store pzcount
	STORE	R7,oddcount[R0]	; Store oddcount
	STORE	R8,overflow[R0]	; Store overflow

; Exit the program
	DONE	TRAP	R0,R0,R0

; Data Section
array	DATA	3	; Array elements
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
size	DATA	12	; Length of array

negsum	DATA	0	; Final negsum
pzcount	DATA	0	; Final pzcount
oddcount	DATA	0	; Final oddcount
overflow	DATA	0	; Final overflow flag
