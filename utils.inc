.data
    singleInput db ?
    charFlag db 0
    stringFlag db 1
    digitsFlag db 2
    encrypt db ?
    secretKey db 69
    continueMsg db 10, 13, "                          Press Any Key To Continue...$"
    NL db 10, 13, "$"

CLEAR macro ; to clear console screen
    mov ax, 0003h
    int 10h
endm

NEW_LINE macro
    lea dx, NL
    mov ah, 09h
    int 21h
endm

PRESS_ANY_KEY macro
    lea dx, continueMsg
    mov ah, 09h
    int 21h

    mov ah, 07h
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
Prompt proc ; di = dest, si = msg, singleInput = single input boolean
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
    mov [di], al
    ret

Prompt endp

PromptPassword proc ; di = password destination, si = prompt message
    lea dx, [si]
    mov ah, 09h
    int 21h

    mov bx, 0
GetPasswordChar:
    mov ah, 08h
    int 21h
    mov [di], al
    cmp al, 08h ; backspace
    je Backspace
    cmp al, 0dh
    jne InsertPasswordChar
    ret

InsertPasswordChar:
    mov dl, "*"
    mov ah, 02h
    int 21h
    inc di
    inc bx
    jmp GetPasswordChar

Backspace:
    cmp bx, 0
    jle GetPasswordChar

    mov dl, 08h
    mov ah, 02h
    int 21h

    mov dl, " "
    mov ah, 02h
    int 21h

    mov dl, 08h
    mov ah, 02h
    int 21h

    dec di
    dec bx
    jmp GetPasswordChar

PromptPassword endp

ConvertToNum proc ; si = buffer, di = destination
    mov ax, 0
    mov [di], ax
Convert:
    mov dl, [si]
    cmp dl, 0dh
    je EndConversion

    mov dx, 0
    mov ax, [di]
    mul ten
    add dx, [si]
    mov dh, 0
    sub dx, 30h
    add ax, dx
    mov [di], ax
    inc si
    jmp Convert

EndConversion:
    ret
ConvertToNum endp

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

Cryptogramify proc ; si = string to encrypt/decrypt, encrypt = boolean
    mov ax, 0
    mov al, secretKey

    cmp encrypt, 0
    je SetSecretKey
    jmp CryptogramifyPassword

SetSecretKey:
    mov bx, -1
    mul bx
    mov secretKey, al

CryptogramifyPassword:
    mov dl, [si]
    cmp dl, "$"
    je EndCryption
    add dl, secretKey
    mov [si], dl
    inc si
    jmp CryptogramifyPassword

EndCryption:
    mov secretKey, 69
    ret

Cryptogramify endp

