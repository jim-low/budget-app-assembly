.data
    SINGLE_INPUT db ?

CLEAR macro ; to clear console screen
    mov ax, 0003h
    int 10h
endm

; stackoverflow perhaps?
; 0 = Black
; 1 = Blue
; 2 = Green
; 3 = Aqua
; 4 = Red
; 5 = Purple
; 6 = Yellow
; 7 = White
; 8 = Gray,
; 9 = Light Blue.
CHANGE_COLOR macro color_code
    mov ah, 09h
    mov cx, 1000h
    mov al, 20h
    mov bl, color_code
    int 10h
endm

.code
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
    mov [di + bx], al
    ret

prompt endp

