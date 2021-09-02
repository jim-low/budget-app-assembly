.data
    usernameLoginPrompt db 0dh, 0ah, 0dh, 0ah, '                  username : $'
    passwordLoginPrompt db 0dh, 0ah, '                  password : $'

    pswLen equ ($-password) ;equ=only tells the assembler to substitute a value for a symbol
    loginUsername db 10, ?, 12 dup ('$')
    loginPassword db 10 dup ('$')
    failed db 0dh, 0ah, 0dh, 0ah, '                 ! failed to log in ! ', 0dh, 0ah, '$'
    success db 0dh, 0ah, 0dh, 0ah, '                - successfully log in - $'
    exceeded db 0dh, 0ah, 0dh, 0ah, '  - failure over 5, please contact admin for further help -$'
    count db 0

.code
login proc
    call ShowLogin

LoginStart:
    cmp count, 5
    je Exceed

Input:
    ;display usernameLoginPrompt
    lea di, loginUsername
    lea si, usernameLoginPrompt
    mov singleInput, 0
    call Prompt

    mov bx, 0
CheckUsername:
    mov al, [loginUsername+2+bx]
    cmp al, 0dh
    je Psw
    cmp al, [username+bx]
    call Fail
    inc bx
    jmp CheckUsername

Exceed:
    CHANGE_COLOR 04h, exceeded

    ;display enter psw
Psw:
    lea si, passwordLoginPrompt
    mov dl, stringFlag
    call Display

    mov si, 00
    ;display *
Change:
    mov ah, 07h ;char input without echo, break are check
    int 21h
    cmp al, 0dh ;0dh = cr
    je SetLoop ; set password der length so can replace to *
    cmp al, 08h
    je Backspace
    mov [loginPassword+si],al
    mov dl, '*' ;entry : dl= char to write我要写的, return al= last char output我要存的
    mov ah, 02h ;write char to standard output
    int 21h
    inc si
    jmp Change

Backspace:
    cmp si, 0
    je Change
    dec si
    mov [loginPassword+si], 0
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
    mov al, [loginPassword+bx]
    cmp al, [password+bx]
    call Fail
    inc bx
    loop CheckPsw
    CHANGE_COLOR 02h, success

Fail:
    CHANGE_COLOR 04h, failed
    inc count
    jmp LoginStart
    ret

login endp

