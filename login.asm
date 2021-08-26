  .model small
  .stack 100
  .data
		; Your data definition
		LOGIN_BANNER DB 0DH,0AH,'           _______________________________ '
					 DB 0DH,0AH,'          (                               )'
					 DB 0DH,0AH,'          (          - LOGIN -            )'
					 DB 0DH,0AH,'          (_______________________________)$'
		STR1 DB 0DH,0AH,0DH,0AH,'                  USERNAME : $'
		STR2 DB 0DH,0AH,'                  PASSWORD : $'
		USERNAME DB 'budget$'
		PASSWORD DB 'Cheese12'
		LONG EQU ($-PASSWORD) ;EQU=only tells the assembler to substitute a value for a symbol
		InputName DB 10, ?, 12 DUP ('$')		  
		InputPSW  DB 10 DUP ('$')
		FAILED DB 0DH,0AH,0DH,0AH,'                 ! FAILED TO LOG IN ! ',0DH,0AH,'$'
		SUCCESS DB 0DH,0AH,0DH,0AH,'                - SUCCESSFULLY LOG IN - $'   
		EXCCEDED DB 0DH,0AH,0DH,0AH,'  - FAILURE OVER 5, PLEASE CONTACT ADMIN FOR FURTHER HELP -$'
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
	
	START:
		CMP COUNT, 5
		JE EXCEED
		
	INPUT:
		;DISPLAY STR1
		MOV AH, 09H
		LEA DX, STR1
		INT 21H
		
		;GET USERNAME
		LEA DX, InputName
		MOV AH, 0AH
		INT 21H
		
		MOV BX, 0
	CHECK_NAME:
		MOV AL, [InputName+2+BX]
		CMP AL, 0DH
		JE PSW
		CMP AL, [USERNAME+BX]
		JNE FAIL
		INC BX
		JMP CHECK_NAME
		
	EXCEED:
		MOV AH, 09H
		LEA DX, EXCCEDED
		INT 21H
		JMP EXIT
		
		;DISPLAY ENTER PSW
	PSW:
		MOV AH,09H
		LEA DX,STR2
		INT 21H
		
		MOV SI, 00
		;DISPLAY *
	CHANGE:
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
		JMP CHANGE
		
	BACKSPACE:
		CMP SI, 0
		JE CHANGE
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
		JMP CHANGE
	
	SET:
		MOV BX,00
		MOV CX,LONG ;PASSWORD DER LENGTH
	
	CHECK_PSW:
		MOV AL, [InputPSW+BX]
		CMP AL, [PASSWORD+BX]
		JNE FAIL
		INC BX
		LOOP CHECK_PSW
		MOV AH, 09H
		LEA DX, SUCCESS
		INT 21H
		JMP EXIT
	
	FAIL:
		MOV AH, 09H
		LEA DX, FAILED
		INT 21H
		INC COUNT 
		JMP START
	
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
   