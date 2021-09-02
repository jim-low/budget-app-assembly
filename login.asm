.data
    usernameLoginPrompt db 0dh, 0ah, 0dh, 0ah, '                  username : $'
    passwordLoginPrompt db 0dh, 0ah, '                  password : $'

    loginUsername db 30, ?, 32 dup ('$')
    loginPassword db 30 dup ('$')
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

    ;display enter psw
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
    je PasswordSuccessButIHaveNot
    cmp al, [password+bx]
    jne Fail
    inc bx
    jmp CheckPsw

PasswordSuccessButIHaveNot:
    CHANGE_COLOR 02h, success
    NEW_LINE
    jmp EndProgram

Fail:
    CHANGE_COLOR 04h, failed
    inc count
    jmp LoginStart
    ret

login endp

