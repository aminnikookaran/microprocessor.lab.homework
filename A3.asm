	org 	0000h

    dseg    	at      30h
    BDispBuf0: 	ds      1
    BDispBuf1: 	ds      1
    BDispBuf2: 	ds      1
    BDispBuf3: 	ds      1
    BDispBuf4: 	ds      1
    BDispBuf5: 	ds      1
	BMux:		DS	1
	BSel:		DS	1


	SEVSEL		EQU	0FFC8h
	SEVDATA		EQU	0FFC9h

	cseg    at      0000h

	MOV	BMux,#00H
	MOV	BSeL,#11111110B

	MOV	R0, #01H
	MOV	A, R0
	CALL	DECODE
	MOV     BDispBuf0,A

	MOV	R0, #02H
	MOV	A, R0
	CALL	DECODE
	MOV     BDispBuf1,A

	MOV	R0, #03H
	MOV	A, R0
	CALL	DECODE
	MOV     BDispBuf2,A

	MOV	R0, #04H
	MOV	A, R0
	CALL	DECODE
	MOV     BDispBuf3,A

	MOV	R0, #05H
	MOV	A, R0
	CALL	DECODE
	MOV     BDispBuf4,A

	MOV	R0, #06H
	MOV	A, R0
	CALL	DECODE
	MOV     BDispBuf5,A



loop:	MOV	dptr,#SEVSEL
	MOV	A,BSeL
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf0
	MOVX	@dptr,A

	CALL	DELAY
	
	MOV	A,BSeL
	RL	A
	MOV	BSeL,A




	MOV	dptr,#SEVSEL
	MOV	A,BSeL
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf1
	MOVX	@dptr,A

	CALL	DELAY
	
	MOV	A,BSeL
	RL	A
	MOV	BSeL,A





	MOV	dptr,#SEVSEL
	MOV	A,BSeL
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf2
	MOVX	@dptr,A

	CALL	DELAY
	
	MOV	A,BSeL
	RL	A
	MOV	BSeL,A




	MOV	dptr,#SEVSEL
	MOV	A,BSeL
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf3
	MOVX	@dptr,A

	CALL	DELAY
	
	MOV	A,BSeL
	RL	A
	MOV	BSeL,A




	MOV	dptr,#SEVSEL
	MOV	A,BSeL
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf4
	MOVX	@dptr,A

	CALL	DELAY
	
	MOV	A,BSeL
	RL	A
	MOV	BSeL,A




	MOV	dptr,#SEVSEL
	MOV	A,BSeL
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf5
	MOVX	@dptr,A

	CALL	DELAY

	MOV	BSeL,#11111110B

 	sjmp	LOOP

DELAY:	mov 	R5,#1
L1:	mov	R6,#8
L2:	mov	R7,#200
L3:	NOP
	NOP
	DJNZ	R7,L3
	DJNZ	R6,L2
	DJNZ	R5,L1
	ret
DECODE:
	MOV	DPTR,#TABLE
	MOVC	A,@A+DPTR
	RET
TABLE:	DB	3FH
	DB	06H
	DB	5BH
	DB	4FH
	DB	66H
	DB	6DH
	DB	7DH
	DB	07H
	DB	7FH
	DB	6FH
	DB	77H
	DB	7CH
	DB	39H
	DB	5EH
	DB	79H
	DB	71H	
END