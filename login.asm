.data
    usernameLoginPrompt db 0dh, 0ah, 0dh, 0ah, "                  Username : $"
    passwordLoginPrompt db 0dh, 0ah, "                  Password : $"

    loginUsername db 30, ?, 32 dup ("$")
    loginPassword db 30 dup ("$")
    failed db 0dh, 0ah, 0dh, 0ah, "                 ! Failed To Log In ! ", 0dh, 0ah, "$"
    success db 0dh, 0ah, 0dh, 0ah, "                - Successfully Log In - $"
    exceeded db 0dh, 0ah, 0dh, 0ah, "  - You have exceeded the maximum amount of tries. -$"
    count db 0

.code
login proc
    call ShowLogin

LoginStart:
    cmp count, 3
    je Exceed

Input:
    lea di, loginUsername
    lea si, usernameLoginPrompt
    mov singleInput, 0
    call Prompt

    NEW_LINE

    mov bx, 0
CheckUsername:
    mov al, [loginUsername+2+bx]
    cmp al, 0dh
    je Psw
    cmp al, [username+2+bx]
    je PassUsername
    jmp Fail

PassUsername:
    inc bx
    jmp CheckUsername

Exceed:
    CHANGE_COLOR 04h, exceeded

Psw:
    lea si, passwordLoginPrompt
    lea di, loginPassword
    call PromptPassword

    lea si, password
    mov encryptFlag, 0
    call Cryptogramify

    mov bx, 0
CheckPsw:
    mov al, [loginPassword+bx]
    cmp al, 0dh
    je LoginSuccess
    cmp al, [password+bx]
    jne Fail
    inc bx
    jmp CheckPsw

LoginSuccess:
    CHANGE_COLOR 02h, success
    NEW_LINE
    ret

Fail:
    CHANGE_COLOR 04h, failed
    inc count
    jmp LoginStart
    ret

login endp

