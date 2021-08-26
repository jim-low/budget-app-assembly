.data
    loginBanner db 0dh, 0ah, '           _______________________________ '
     db 0dh, 0ah, '          (                               )'
     db 0dh, 0ah, '          (          - login -            )'
     db 0dh, 0ah, '          (_______________________________)$'
    usernameLoginPrompt db 0dh, 0ah, 0dh, 0ah, '                  username : $'
    passwordLoginPrompt db 0dh, 0ah, '                  password : $'

    pswLen equ ($-password) ;equ=only tells the assembler to substitute a value for a symbol
    inputName db 10, ?, 12 dup ('$')
    inputPsw db 10 dup ('$')
    failed db 0dh, 0ah, 0dh, 0ah, '                 ! failed to log in ! ', 0dh, 0ah, '$'
    success db 0dh, 0ah, 0dh, 0ah, '                - successfully log in - $'
    exceeded db 0dh, 0ah, 0dh, 0ah, '  - failure over 5, please contact admin for further help -$'
    count db 0

.code
login proc
    ;display login banner
    mov ah, 09h
    lea dx, loginBanner
    int 21h

Start:
    cmp count, 5
    je Exceed

Input:
    ;display usernameLoginPrompt
    mov ah, 09h
    lea dx, usernameLoginPrompt
    int 21h

    ;get username
    lea dx, inputName
    mov ah, 0ah
    int 21h

    mov bx, 0
CheckName:
    mov al, [inputName+2+bx]
    cmp al, 0dh
    je Psw
    cmp al, [username+bx]
    jne Fail
    inc bx
    jmp CheckName

Exceed:
    mov ah, 09h
    lea dx, exceeded
    int 21h
    jmp Exit

    ;display enter psw
Psw:
    mov ah, 09h
    lea dx, passwordLoginPrompt
    int 21h

    mov si, 00
    ;display *
Change:
    mov ah, 07h ;char input without echo, break are check
    int 21h
    cmp al, 0dh ;0dh = cr
    je SetLoop ; set password der length so can replace to *
    cmp al, 08h
    je Backspace
    mov [inputPsw+si],al
    mov dl, '*' ;entry : dl= char to write我要写的, return al= last char output我要存的
    mov ah, 02h ;write char to standard output
    int 21h
    inc si
    jmp Change

Backspace:
    cmp si, 0
    je Change
    dec si
    mov [inputPsw+si], 0
    mov dl, 08h
    mov ah, 02h
    int 21h
    mov dl, ' '
    mov ah, 02h
    int 21h
    mov dl, 08h
    mov ah, 02h
    int 21h
    jmp Change

SetLoop:
    mov bx, 00
    mov cx, pswLen ;password der length

CheckPsw:
    mov al, [inputPsw+bx]
    cmp al, [password+bx]
    jne Fail
    inc bx
    loop CheckPsw
    mov ah, 09h
    lea dx, success
    int 21h
    jmp Exit

Fail:
    mov ah, 09h
    lea dx, failed
    int 21h
    inc count
    jmp Start

Exit:
    mov ah, 4ch
    int 21h

login endp

