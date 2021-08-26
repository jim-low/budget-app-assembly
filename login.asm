<<<<<<< Updated upstream
.data
    ; put your variables here

.code
    ; all the best - Jim

=======
  .model small
  .stack 100
  .data
		; Your data definition
		LOGIN_BANNER DB 0DH,0AH,'           _______________________________ '
					 DB 0DH,0AH,'          (                               )'
					 DB 0DH,0AH,'          (          - LOGIN -            )'
					 DB 0DH,0AH,'          (_______________________________)'
					 DB 0DH,0AH,'                  USERNAME : $'
		STR2 DB 0DH,0AH,'                  PASSWORD : $'
		USERNAME DB 'budget'
		PASSWORD DB 'Cheese12'
		LONG EQU ($-PASSWORD) ;EQU=only tells the assembler to substitute a value for a symbol
		InputName DB 10, ?, 12 DUP ('$')		  
		InputPSW  DB 10 DUP ('$')
		Invalid DB 0DH,0AH,0DH,0AH,'                 ! FAILED TO LOG IN ! $'
		SUCCESS DB 0DH,0AH,0DH,0AH,'                - SUCCESSFULLY LOG IN - $'             
		NL   DB 0DH,0AH,"$"
		SINGLE_INPUT DB ?
		COUNT DB 0
		
	CLEAR macro ; to clear console screen
		mov ax, 0003h
		int 10h
	endm


   .code
   main proc
		; Your program here
		MOV AX, @DATA
		MOV DS, AX 
		
		;DISPLAY LOGIN BANNER
		MOV AH, 09H
		LEA DX, LOGIN_BANNER
		INT 21H
		
	;START:
	;	CMP COUNT, 5
	;	JE Input
	;	JMP EXIT

		;GET USER INPUT
	Input:
		LEA DX, InputName
		MOV AH, 0AH
		INT 21H
		
		MOV AX, 0
		MOV BX, 0
		ADD InputName, 2
		
;	CHECK_CARRIAGE:
;		MOV AL, InputName[BX]
;		CMP AL, 0DH ;0DH = CARRIAGE RETURN
;		JE REPLACE_CARRIAGE
		
	CHECK_NAME:
		MOV AL, InputName[BX]
		CMP AL, USERNAME[BX]
		CMP AL, 0DH
		JNE FAIL
		JE PSW
		INC BX
		;JMP CHECK_CARRIAGE
		LOOP CHECK_NAME
		
;	REPLACE_CARRIAGE:
;		MOV AL, '$'
;		MOV InputName[SI], AL
;		JMP CHECK_NAME
		
		;DISPLAY ENTER PSW
	PSW:
		;NEXTLINE
		MOV AH, 09H	
		LEA DX, NL		
		INT 21H
		
		MOV AH,09H
		LEA DX,STR2
		INT 21H
		
		MOV SI, 00
		;DISPLAY *
	L2:
		MOV AH, 07H ;CHAR INPUT WITHOUT ECHO, BREAK ARE CHECK 
		INT 21H
		CMP AL, 0DH ;0DH = CR
		JE SET ; SET PASSWORD DER LENGTH SO CAN REPLACE TO *
		CMP AL, 08H
		JE BACKSPACE
		MOV [InputPSW+SI],AL
		MOV DL, '*' ;ENTRY : DL= CHAR TO WRITE我要写的, RETURN AL= LAST CHAR OUTPUT我要存的
		MOV AH, 02H ;WRITE CHAR TO STANDARD OUTPUT 
		INT 21H
		INC SI
		JMP L2
		
	BACKSPACE:
		CMP SI, 0
		JE L2
		DEC SI
		MOV [InputPSW+SI], 0
		MOV DL, 08H 
		MOV AH, 02H
		INT 21H
		MOV DL, ' ' 
		MOV AH, 02H
		INT 21H
		MOV DL, 08H 
		MOV AH, 02H
		INT 21H
		JMP L2
	
	SET:
		MOV BX,00
		MOV CX,LONG ;PASSWORD DER LENGTH
	
	CHECK_PSW:
		MOV AL, [InputPSW+BX]
		CMP AL, [PASSWORD+BX]
		JNE FAIL
		INC BX
		LOOP CHECK_PSW
		LEA DX, SUCCESS
		MOV AH, 09H
		INT 21H
		JMP EXIT
	
	FAIL:
		MOV AH, 09H
		LEA DX, Invalid
		INT 21H
		INC COUNT 
		;JMP START
		JMP EXIT
	
	EXIT:
		MOV AX, 4C00H
		INT 21H
		
   main endp
   
   prompt proc ; di = dest, si = msg, SINGLE_INPUT = count
    lea dx, [si]
    mov ah, 09h
    int 21h

    cmp SINGLE_INPUT, 1
    je SingleInput
    jmp MultiInput

MultiInput:
    lea dx, [di]
    mov ah, 0ah
    int 21h
    ret

SingleInput:
    mov ah, 01h
    int 21h
    mov [di], al
    ret
	
	prompt endp
   end main
   
>>>>>>> Stashed changes
