; The process to count an array
; Author: Haicheng Zhao
; Submit Date: 4/12/2024


; Java code: 

; public class Assemble {
;     public static void main(String[] args) {
;         int[] X = { 3, -6, 27, 101, 50, 0, -20, -21, 19, 6, 4, -10 };
;         int size = 12;
;         int negsum = 0;
;         int pzcount = 0;
;         int oddcount = 0;
;         boolean overflow = false;
; 
;         // Process the array
;         for (int i = 0; i < size; ++i) {
;             if (X[i] < 0) {
;                 negsum += X[i];
;                 if (negsum >= 0) {
;                     overflow = true;
;                 }
;             } else {
;                 ++pzcount;
;                 if ((X[i] & 1) != 0) {
;                     ++oddcount;
;                 }
;             }
;         }
; 
;         System.out.println(negsum);
;         System.out.println(pzcount);
;         System.out.println(oddcount);
;         System.out.println(overflow);
;     }
; }


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
        LOAD	R2,size[R0]	; R2 = size
	LEA	R5,0[R0]	; negsum = constant 0
	LEA	R6,0[R0]	; pzcount = constant 0
	LEA	R7,0[R0]	; oddcount = constant 0
	LEA	R8,0[R0]	; overflow = constant 0 (false)

; Loop to process array X
	LEA	R3,0[R0]	; i = constant 0
LOOP	CMPLT	R4,R3,R2	; R4 = (i < size)
	JUMPF	R4,LOOPEND[R0]	; Goto LOOPEND if not (i < size)

; Process negsum and overflow
IF	LOAD	R1,X[R3]	; R1 = X[i]
	CMPLT	R4,R1,R0	; R4 = (X[i] < 0)
	JUMPF	R4,ELSE[R0]	; Goto ELSE if not (X[i] < 0)
	ADD	R5,R5,R1	; negsum = negsum + X[i]

IF1	CMPLT	R4,R5,R0	; R4 = (negsum < 0)
	JUMPT	R4,IFEND1[R0]	; Goto IFEND1 if (negsum < 0)

	LEA	R8,1[R0]	; overflow = constant 1
IFEND1	JUMP	ELSEEND[R0]	; Goto ELSEEND to skip the else block
IFEND

ELSE	LEA	R4,1[R0]	; R4 = constant 1
	ADD	R6,R6,R4	; pzcount = pzcount + 1

IF2	AND	R4,R1,R4	; R4 = (X[i] & 1)
	JUMPF	R4,IFEND2[R0]	; Goto IFEND2 if not (X[i] is odd)

	LEA	R4,1[R0]	; R4 = constant 1
	ADD	R7,R7,R4	; oddcount = oddcount + 1
IFEND2
ELSEEND

	LEA	R4,1[R0]	; R4 = constant 1
	ADD	R3,R3,R4	; i = i + 1
	JUMP	LOOP[R0]	; Goto the beginning of loop
LOOPEND

	STORE	R5,negsum[R0]	; Save R5 into negsum
	STORE	R6,pzcount[R0]	; Save R6 into pzcount
	STORE	R7,oddcount[R0]	; Save R7 into oddcount
	STORE	R8,overflow[R0]	; Save R8 into overflow

; Exit the program
DONE	TRAP	R0,R0,R0	; Terminate


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