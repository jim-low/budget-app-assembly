.data
    singleInput db ?
    charFlag db 0
    stringFlag db 1
    digitsFlag db 2

CLEAR macro ; to clear console screen
    mov ax, 0003h
    int 10h
endm

NEW_LINE macro
    mov dl, 0dh
    mov ah, 02h
    int 21h

    mov dl, 0ah
    mov ah, 02h
    int 21h
endm

; Color Codes (format: XY, X = background, Y = foreground)
; 0 = Black
; 1 = Blue
; 2 = Green
; 3 = Aqua
; 4 = Red
; 5 = Purple
; 6 = Yellow
; 7 = White
; 8 = Gray
; 9 = Light Blue
CHANGE_COLOR macro colorCode, msg
    mov ah, 09h
    mov cx, 1000h
    mov al, 20h
    mov bl, colorCode
    int 10h

    lea dx, msg
    mov ah, 09h
    int 21h

    mov ah, 09h
    mov bl, 07h
    int 10h
endm

.code
Prompt proc ; di = dest, si = msg, singleInput = count
    lea dx, [si]
    mov ah, 09h
    int 21h

    cmp singleInput, 1
    je ReadSingleInput
    jmp ReadMultiInput

ReadMultiInput:
    lea dx, [di]
    mov ah, 0ah
    int 21h
    ret

ReadSingleInput:
    mov ah, 01h
    int 21h
    mov [di + bx], al
    ret

Prompt endp

Display proc ; si = value, dl = flag
    cmp dl, charFlag
    je DisplayChar

    cmp dl, stringFlag
    je DisplayString

    cmp dl, digitsFlag
    mov ax, [si]
    mov cx, 0
    je PopulateStack

DisplayChar:
    mov dl, [si]
    add dl, '0'
    mov ah, 02h
    int 21h
    ret

DisplayString:
    lea dx, [si]
    mov ah, 09h
    int 21h
    ret

PopulateStack:
    mov dx, 0
    mov bx, 10
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne PopulateStack
PrintDigits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop PrintDigits
    ret

Display endp

