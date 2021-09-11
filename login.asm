.data
    usernameLoginPrompt db "                             Username: $"
    passwordLoginPrompt db "                             Password: $"

    loginUsername db 30, ?, 32 dup ("$")
    loginPassword db 30 dup ("$")
    failed db "                              !! Failed To Log In !!$"
    success db "                           -- Successfully Logged In! -- $"
    exceeded db 10,13,"   - You have exceeded the maximum amount of tries. Please register again.-$"
    count db 0
    isSuccess db 0

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
    cmp al, 0dh
    je Psw
    mov al, [loginUsername+2+bx]
    cmp al, [username+2+bx]
    je PassUsername
    jmp Fail

PassUsername:
    inc bx
    jmp CheckUsername

Exceed:
    CHANGE_COLOR 04h, exceeded
    PRESS_ANY_KEY
    mov isSuccess, 0
    mov count, 0
    ret

Psw:
    NEW_LINE
    NEW_LINE
    lea si, passwordLoginPrompt
    lea di, loginPassword
    call PromptPassword

    mov bx, 0
CheckPsw:
    mov al, [loginPassword+bx]
    cmp al, [password+bx]
    jne Fail
    cmp al, 0dh
    je LoginSuccess
    inc bx
    jmp CheckPsw

LoginSuccess:
    mov isSuccess, 1
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

login endp

