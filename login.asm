.data
    usernameLoginPrompt db "                             Username: $"
    passwordLoginPrompt db "                             Password: $"

    loginUsername db 30, ?, 32 dup ("$")
    loginPassword db 30 dup ("$")
    failed db "                              ! Failed To Log In D: !$"
    success db "                           -- Successfully Logged In! -- $"
    exceeded db "  - You have exceeded the maximum amount of tries. -$"
    count db 0

.code
login proc
    CLEAR

    lea si, password
    mov encrypt, 0
    call Cryptogramify

    call ShowLogin

LoginStart:
    cmp count, 3
    je Exceed

Input:
    NEW_LINE
    NEW_LINE
    lea di, loginUsername
    lea si, usernameLoginPrompt
    mov singleInput, 0
    call Prompt

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
    NEW_LINE
    NEW_LINE
    lea si, passwordLoginPrompt
    lea di, loginPassword
    call PromptPassword

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
    NEW_LINE
    NEW_LINE

    CHANGE_COLOR 02h, success

    NEW_LINE
    NEW_LINE

    PRESS_ANY_KEY
    ret

Fail:
    NEW_LINE
    NEW_LINE

    CHANGE_COLOR 04h, failed
    inc count
    jmp LoginStart
    ret

login endp

