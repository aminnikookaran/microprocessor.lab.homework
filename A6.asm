	org 	0000h

    dseg    	at      30h
    BDispBuf0: 	ds      1
    BDispBuf1: 	ds      1
    BDispBuf2: 	ds      1
    BDispBuf3: 	ds      1
    BDispBuf4: 	ds      1
    BDispBuf5: 	ds      1
	BMux:		DS		1
	BDataBuf:	DS		1
	WAdresBufL:	DS		1
	WAdresBufH:	DS		1

	SEVSEL		EQU	0FFC8h
	SEVDATA		EQU	0FFC9h

CSEG    AT      0000H
	LJMP	MAIN

CSEG	AT	000BH
	MOV	TH0,#0EEH
	MOV	TL0,#0FFH
	SETB	ET0
	MOV	TMOD,#01H
	MOV	TCON,#16H
	SETB	EA

	INC	BMux
	MOV	A,#01H
	CJNE	A,BMUX,LOOP2

	MOV	dptr,#SEVSEL
	MOV	A,#11111101B
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf1
	MOVX	@dptr,A
	RETI

LOOP2:	INC	A
	CJNE	A,BMUX,LOOP3
	MOV	dptr,#SEVSEL
	MOV	A,#11111011B
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf2
	MOVX	@dptr,A
	RETI

LOOP3:	INC	A
	CJNE	A,BMUX,LOOP4
	MOV	dptr,#SEVSEL
	MOV	A,#11110111B
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf3
	MOVX	@dptr,A
	RETI

LOOP4:	INC	A
	CJNE	A,BMUX,LOOP5
	MOV	dptr,#SEVSEL
	MOV	A,#11101111B
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf4
	MOVX	@dptr,A
	RETI

LOOP5:	INC	A
	CJNE	A,BMUX,LOOP6
	MOV	dptr,#SEVSEL
	MOV	A,#11011111B
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf5
	MOVX	@dptr,A
	RETI

LOOP6:	MOV	dptr,#SEVSEL
	MOV	A,#11111110B
	MOVX	@dptr,A

	MOV	dptr,#SEVDATA
	MOV	A,BDispBuf0
	MOVX	@dptr,A
	MOV	BMux,#0H
	RETI

MAIN:	MOV	BDataBuf,#10H
	MOV	WAdresBufL,#32H
	MOV	WAdresBufH,#54H

	MOV	A,BDataBuf
	ANL	A,#0FH
	CALL	DECODE
	MOV     BDispBuf0,A

	MOV	A,BDataBuf
	SWAP	A
	ANL	A,#0FH
	CALL	DECODE
	MOV     BDispBuf1,A

	MOV	A,WAdresBufL
	ANL	A,#0FH
	CALL	DECODE
	MOV     BDispBuf2,A

	MOV	A,WAdresBufL
	SWAP	A
	ANL	A,#0FH
	CALL	DECODE
	MOV     BDispBuf3,A

	MOV	A,WAdresBufH
	ANL	A,#0FH
	CALL	DECODE
	MOV     BDispBuf4,A

	MOV	A,WAdresBufH
	SWAP	A
	ANL	A,#0FH
	CALL	DECODE
	MOV     BDispBuf5,A

	MOV	TH0,#0EEH
	MOV	TL0,#0FFH
	SETB	ET0
	MOV	TMOD,#01H
	MOV	TCON,#16H
	MOV	BMUX,#00H
	SETB	EA

LOOP:	SJMP	LOOP

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