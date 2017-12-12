TITLE ASM1 (EXE)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
  DW 12 DUP ('AB')
  DW 13 DUP ('CD')

SET_CURSOR macro X,Y
  MOV AH, 02H   ;function code to request for set cursor
  MOV BH, 00    ;page number 0, i.e. current screen
  MOV DL, X    ;set row
  mov DH, Y    ;set column
  INT 10H
endm

MARK_BOARD macro X
  INC SI
  MOV AL, [SI]
  SUB AL, 48
  MOV CX, 4
  MUL CX
  LEA DI, X
  ADD DI, AL
  INC DI
  INC DI
  MOV AL, 'x'
  STOSB
endm

MARK_BOARD2 macro X
  MOV AL, [SI]
  SUB AL, 48
  MOV CX, 4
  MUL CX
  LEA DI, X
  ADD DI, AL
  MOV AL, 'x'
  STOSB
endm

STACKSEG ENDS
;---------------------------------------------

; UPPER RIGHT VERTEX ¿
; LOWER RIGHT VERTEX Ù 
; UPPER LEFT VERTEX Ú
; LOWER LEFT VERTEX À

; VERTICAL LINE ³
; HORIZONTAL LINE Ä
; UPPER EDGE T Â
; LOWER EDGE T Á

; INTERNAL DIVIDER Å
; RIGHT EDGE LINE ´
; LEFT EDGE LINE Ã 


;WHITE RECTANGLE Û
;NULL		 í
; DEG		 ø

; NUMBER PART SI LIST
; 1 = 4
; 2 = 8
; ...



DATASEG SEGMENT PARA 'Data'

  COLUMNS DB 0AH, 0DH, "    1   2   3   4   5   6   7$"

  UPPERBORDER DB 0AH, 0DH, "  ÚÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄ¿$" 		;UPPER EDGE BORDER
  
  LOWERBORDER DB 0AH, 0DH, "  ÀÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÙ$"		;LOWER EDGE BORDER
	
  INTERNALBORDER DB 0AH, 0DH, "  ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´$"	; INTERNAL BORDER

  GUESSBOARD DB  "  YOUR GUESSBOARD$"
  YOURBOARD DB  "  YOUR BOARD$"

  COORDINATE1 DB 4,?,255 DUP('$')
   ;COORDINATE1 DB 3 DUP(' '), "$"

  P1_GUESSBOARD_ROW_A DB 0AH, 0DH, "A ³   ³   ³   ³   ³   ³   ³   ³$"
  P1_GUESSBOARD_ROW_B DB 0AH, 0DH, "B ³   ³   ³   ³   ³   ³   ³   ³$"
  P1_GUESSBOARD_ROW_C DB 0AH, 0DH, "C ³   ³   ³   ³   ³   ³   ³   ³$"
  P1_GUESSBOARD_ROW_D DB 0AH, 0DH, "D ³   ³   ³   ³   ³   ³   ³   ³$"
  P1_GUESSBOARD_ROW_E DB 0AH, 0DH, "E ³   ³   ³   ³   ³   ³   ³   ³$"
  P1_GUESSBOARD_ROW_F DB 0AH, 0DH, "F ³   ³   ³   ³   ³   ³   ³   ³$"
  P1_GUESSBOARD_ROW_G DB 0AH, 0DH, "G ³   ³   ³   ³   ³   ³   ³   ³$"

  P1_REALBOARD_ROW_A DB  "A ³ o ³ o ³   ³   ³   ³   ³   ³$"
  P1_REALBOARD_ROW_B DB  "B ³   ³   ³   ³   ³   ³   ³   ³$"
  P1_REALBOARD_ROW_C DB  "C ³ o ³   ³ o ³ o ³ o ³ o ³   ³$"
  P1_REALBOARD_ROW_D DB  "D ³ o ³   ³   ³   ³   ³   ³ o ³$"
  P1_REALBOARD_ROW_E DB  "E ³ o ³   ³   ³   ³   ³   ³ o ³$"
  P1_REALBOARD_ROW_F DB  "F ³ o ³   ³   ³   ³   ³   ³ o ³$"
  P1_REALBOARD_ROW_G DB  "G ³ o ³   ³   ³   ³   ³   ³   ³$"

  ATTACKPROMPT DB 0AH, 0DH, "Where should we attack, Captain? $"

;------------------------------------------------------------
  COLUMNS2 DB  "    1   2   3   4   5   6   7$"

  UPPERBORDER2 DB , " ÚÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄ¿$" 		;UPPER EDGE BORDER
  
  LOWERBORDER2 DB  "  ÀÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÙ$"		;LOWER EDGE BORDER
	
  INTERNALBORDER2 DB  "  ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´$"	; INTERNAL BORDER

  GUESSBOARD2 DB  "  YOUR GUESSBOARD$"
  YOURBOARD2 DB  "  YOUR BOARD$"

  P2_GUESSBOARD_ROW_A DB 0AH, 0DH, "A ³   ³   ³   ³   ³   ³   ³   ³$"
  P2_GUESSBOARD_ROW_B DB 0AH, 0DH, "B ³   ³   ³   ³   ³   ³   ³   ³$"
  P2_GUESSBOARD_ROW_C DB 0AH, 0DH, "C ³   ³   ³   ³   ³   ³   ³   ³$"
  P2_GUESSBOARD_ROW_D DB 0AH, 0DH, "D ³   ³   ³   ³   ³   ³   ³   ³$"
  P2_GUESSBOARD_ROW_E DB 0AH, 0DH, "E ³   ³   ³   ³   ³   ³   ³   ³$"
  P2_GUESSBOARD_ROW_F DB 0AH, 0DH, "F ³   ³   ³   ³   ³   ³   ³   ³$"
  P2_GUESSBOARD_ROW_G DB 0AH, 0DH, "G ³   ³   ³   ³   ³   ³   ³   ³$"

  P2_REALBOARD_ROW_A DB  "A ³   ³ o ³   ³   ³   ³   ³   ³$"
  P2_REALBOARD_ROW_B DB  "B ³   ³ o ³   ³   ³   ³   ³   ³$"
  P2_REALBOARD_ROW_C DB  "C ³   ³   ³ o ³ o ³ o ³ o ³   ³$"
  P2_REALBOARD_ROW_D DB  "D ³ o ³ o ³ o ³   ³   ³   ³   ³$"
  P2_REALBOARD_ROW_E DB  "E ³   ³   ³   ³   ³   ³   ³   ³$"
  P2_REALBOARD_ROW_F DB  "F ³   ³   ³   ³   ³   ³   ³   ³$"
  P2_REALBOARD_ROW_G DB  "G ³ o ³ o ³ o ³ o ³ o ³   ³   ³$"

  ATTACKPROMPT2 DB "Where should we attack, Captain? $"



  
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  MOV AX, DATASEG
  MOV DS, AX
  MOV ES, AX

  CALL P1TURN
  CALL P1TURN
  CALL P1TURN
  CALL P1TURN
  CALL P1TURN



  EXIT:
  MOV AH, 4CH
  INT 21H

;---------------------------------------
CLEAR_SCREEN PROC NEAR
  MOV AX, 0600H   ;full screen
 ; MOV BH, 71H     ;white background (7), blue foreground (1)
  MOV BH, 00H     ;white background (7), blue foreground (1)
  MOV CX, 0000H   ;upper left row:column (0:0)
  MOV DX, 184FH   ;lower right row:column (24:79)
  INT 10H

  RET
CLEAR_SCREEN ENDP

CLEAR_SCREEN2 PROC NEAR
  MOV AX, 0600H   ;full screen
 ; MOV BH, 71H     ;white background (7), blue foreground (1)
  MOV BH, 0FH     ;white background (7), blue foreground (1)
  MOV CX, 0000H   ;upper left row:column (0:0)
  MOV DX, 184FH   ;lower right row:column (24:79)
  INT 10H

  RET
CLEAR_SCREEN2 ENDP

;-------------------------------------------
P1TURN PROC NEAR

  CALL CLEAR_SCREEN
  SET_CURSOR 7,2
  CALL CLEAR_SCREEN2


  LEA DX, GUESSBOARD
  MOV AH, 9
  INT 21H

  LEA DX, COLUMNS
  MOV AH, 9
  INT 21H

  LEA DX, UPPERBORDER
  MOV AH, 9
  INT 21H

  LEA DX, P1_GUESSBOARD_ROW_A
  MOV AH, 9
  INT 21H

  LEA DX, INTERNALBORDER
  MOV AH, 9
  INT 21H

  LEA DX, P1_GUESSBOARD_ROW_B
  MOV AH, 9
  INT 21H

  LEA DX, INTERNALBORDER
  MOV AH, 9
  INT 21H

  LEA DX, P1_GUESSBOARD_ROW_C
  MOV AH, 9
  INT 21H

  LEA DX, INTERNALBORDER
  MOV AH, 9
  INT 21H

  LEA DX, P1_GUESSBOARD_ROW_D
  MOV AH, 9
  INT 21H

  LEA DX, INTERNALBORDER
  MOV AH, 9
  INT 21H

  LEA DX, P1_GUESSBOARD_ROW_E
  MOV AH, 9
  INT 21H

  LEA DX, INTERNALBORDER
  MOV AH, 9
  INT 21H

  LEA DX, P1_GUESSBOARD_ROW_F
  MOV AH, 9
  INT 21H

  LEA DX, INTERNALBORDER
  MOV AH, 9
  INT 21H

  LEA DX, P1_GUESSBOARD_ROW_G
  MOV AH, 9
  INT 21H


  LEA DX, LOWERBORDER
  MOV AH, 9
  INT 21H




;------------------ PLAYER 2 SIDE--------------

SET_CURSOR 49,2

  LEA DX, YOURBOARD
  MOV AH, 9
  INT 21H
  
SET_CURSOR 39,3

  LEA DX, COLUMNS2
  MOV AH, 9
  INT 21H

SET_CURSOR 39,4

  LEA DX, UPPERBORDER2
  MOV AH, 9
  INT 21H

SET_CURSOR 39,5

  LEA DX, P2_REALBOARD_ROW_A
  MOV AH, 9
  INT 21H

SET_CURSOR 39,6

  LEA DX, INTERNALBORDER2
  MOV AH, 9
  INT 21H

SET_CURSOR 39,7

  LEA DX, P2_REALBOARD_ROW_B
  MOV AH, 9
  INT 21H

SET_CURSOR 39,8

  LEA DX, INTERNALBORDER2
  MOV AH, 9
  INT 21H

SET_CURSOR 39,9

  LEA DX, P2_REALBOARD_ROW_C
  MOV AH, 9
  INT 21H

SET_CURSOR 39,10

  LEA DX, INTERNALBORDER2
  MOV AH, 9
  INT 21H

SET_CURSOR 39,11

  LEA DX, P2_REALBOARD_ROW_D
  MOV AH, 9
  INT 21H

SET_CURSOR 39,12

  LEA DX, INTERNALBORDER2
  MOV AH, 9
  INT 21H

SET_CURSOR 39,13

  LEA DX, P2_REALBOARD_ROW_E
  MOV AH, 9
  INT 21H

SET_CURSOR 39,14

  LEA DX, INTERNALBORDER2
  MOV AH, 9
  INT 21H

SET_CURSOR 39,15

  LEA DX, P2_REALBOARD_ROW_F
  MOV AH, 9
  INT 21H

SET_CURSOR 39,16

  LEA DX, INTERNALBORDER2
  MOV AH, 9
  INT 21H

SET_CURSOR 39,17

  LEA DX, P2_REALBOARD_ROW_G
  MOV AH, 9
  INT 21H

SET_CURSOR 39,18

  LEA DX, LOWERBORDER2
  MOV AH, 9
  INT 21H

ASK_INPUT:
  LEA DX, ATTACKPROMPT
  MOV AH, 9
  INT 21H

  MOV AH,3FH		;REQUEST KEYBOARD INPUT
  MOV BX,00		;FILE HANDLE FOR KEYBOARD
  MOV CX,4		;MAX CHARS IS 2, +2 FOR ENTER AND LINE FEED
  LEA DX,COORDINATE1	;INPUT AREA
  INT 21H		;YEA

 CMP COORDINATE1, 	'Q'
 JNE OK
 MOV AH, 4CH
 INT 21H

 OK:
  LEA SI, COORDINATE1
  MOV AL, [SI]
  CMP AL,'A'
  JNE CHECKB
  JMP IS_A

CHECKB:
  CMP AL,'B'
  JNE CHECKC
  JMP IS_B

CHECKC:
  CMP AL,'C'
  JNE CHECKD
  JMP IS_C

CHECKD:
  CMP AL,'D'
  JNE CHECKE
  JMP IS_D
CHECKE:
  CMP AL,'E'
  JNE CHECKF
  JMP IS_E
CHECKF:
  CMP AL,'F'
  JNE CHECKG
  JMP IS_F
CHECKG:
  CMP AL,'G'
  JNE ASK_INPUT
  JMP IS_G

IS_A:
  
  MARK_BOARD P1_GUESSBOARD_ROW_A
  MARK_BOARD2 P2_REALBOARD_ROW_A
  JMP CHANGE_TURN

IS_B:

  MARK_BOARD P1_GUESSBOARD_ROW_B
  MARK_BOARD2 P2_REALBOARD_ROW_B
  JMP CHANGE_TURN

IS_C:

  MARK_BOARD P1_GUESSBOARD_ROW_C
  MARK_BOARD2 P2_REALBOARD_ROW_C
  JMP CHANGE_TURN

IS_D:

  INC SI
  MOV AL, [SI]
  SUB AL, 48
  MOV CX, 4
  MUL CX
  LEA DI, P1_GUESSBOARD_ROW_D
  ADD DI, AL
  INC DI
  INC DI
  MOV AL, 'x'
  STOSB
  JMP CHANGE_TURN

IS_E:

  MARK_BOARD P1_GUESSBOARD_ROW_E
  MARK_BOARD2 P2_REALBOARD_ROW_E
  JMP CHANGE_TURN

IS_F:

  MARK_BOARD P1_GUESSBOARD_ROW_F
  MARK_BOARD2 P2_REALBOARD_ROW_F
  JMP CHANGE_TURN

IS_G:

  MARK_BOARD P1_GUESSBOARD_ROW_G
  MARK_BOARD2 P2_REALBOARD_ROW_G


CHANGE_TURN:


RET
P1TURN ENDP




CODESEG ENDS
END START







*  *         *	*             *	*             * *         *        *          *      *             *           * 
*    *     *    *            *   *     	      *   *       *       *            *     *	         *              *
*      *        *           *     *           *     *     *       *            *     *	         *              * 
*               *          *       *          *      *	  *       *            *     *           *              *
*               *         * * * * * *         *       *   *       *            *     *           *              *
*               *        *           *        *        *  *	   *	      *	     *            *            *
*		*       *	      *       *         * *         *        *       *              *         *
*               *      *               *      *           *           * * *          *  *  *  *       *  * * 