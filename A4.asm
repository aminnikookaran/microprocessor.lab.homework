	org 	0000h

    dseg    	at      30h
    BCNT: 		ds      1
    WNUMBER0: 	ds      1
    WNUMBER1: 	ds      1
    WGAN0: 		ds      1
    WGAN1: 		ds      1
    WTEMP0:	 	ds      1
    WTEMP1:	 	ds      1
    BTEMP0: 	ds      1
    BTEMP1: 	ds      1
	BTEMP2:		DS		1
	BTEMP3:		DS		1
	BTEMP4:		DS		1
    BDispBuf0: 	ds      1
    BDispBuf1: 	ds      1
    BDispBuf2: 	ds      1
    BDispBuf3: 	ds      1
    BDispBuf4: 	ds      1
    BDispBuf5: 	ds      1
	BMux:		DS		1
	BSel:		DS		1

	SEVSEL		EQU	0FFC8h
	SEVDATA		EQU	0FFC9h

	cseg    at      0000h

	MOV	WNUMBER0,#0FFH
	MOV	WNUMBER1,#0FFH

	MOV	WGAN0,#10H
	MOV	WGAN1,#27H
	MOV	BCNT,#00H
	CALL	DIVIDE
	MOV	BTEMP4,BCNT

	MOV	WGAN0,#0E8H
	MOV	WGAN1,#03H
	MOV	BCNT,#00H
	CALL	DIVIDE
	MOV	BTEMP3,BCNT

	MOV	WGAN0,#64H
	MOV	WGAN1,#00H
	MOV	BCNT,#00H
	CALL	DIVIDE
	MOV	BTEMP2,BCNT

	MOV	WGAN0,#0AH
	MOV	WGAN1,#00H
	MOV	BCNT,#00H
	CALL	DIVIDE
	MOV	BTEMP1,BCNT

	MOV	BTEMP0,WNUMBER0

	MOV	BMux,#00H
	MOV	BSeL,#11111110B

	MOV	A,BTEMP0
	CALL	DECODE
	MOV     BDispBuf0,A

	MOV	A,BTEMP1
	CALL	DECODE
	MOV     BDispBuf1,A

	MOV	A,BTEMP2
	CALL	DECODE
	MOV     BDispBuf2,A

	MOV	A,BTEMP3
	CALL	DECODE
	MOV     BDispBuf3,A

	MOV	A,BTEMP4
	CALL	DECODE
	MOV     BDispBuf4,A

	MOV	A,#00H
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

DIVIDE:	CLR	C
	MOV	A,WNUMBER0
	SUBB	A,WGAN0
	MOV	A,WNUMBER1
	SUBB	A,WGAN1
	JC	DIVEND
	MOV	A,WNUMBER0
	SUBB	A,WGAN0
	MOV	WNUMBER0,A
	MOV	A,WNUMBER1
	SUBB	A,WGAN1
	MOV	WNUMBER1,A
	INC	BCNT
	SJMP	DIVIDE
DIVEND:	RET
	
END