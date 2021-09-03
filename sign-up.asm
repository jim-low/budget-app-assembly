.data
;-------------------------------------user name-------------------------------------------------------------
    usernameInputMsg db "Please Enter And Create Your User Name:  $"
    errorMsg db "Incorrect User Input (Capital Letters And Numbers Only)$"
    username db 30, ?, 30 + 2 dup ("$")
    usernameHasNumber db 0
    usernameHasCapitalLetter db 0
    validUsername db 1
    usernameConfirmationMsg db "Your User Name Is Confirmed >>> $"
    inputExceedMsg db "You Have Exceeded The Maximum Amount Of Tries$"
    inputCount db 0
;-------------------------------------user name-------------------------------------------------------------

;-------------------------------------Password--------------------------------------------------------------
    inputPasswordMsg db "Please Enter Your Password [length = 10] : $"
    confirmPasswordMsg db "Please Confirm Your Password : $"
    finalConfirmationPasswordMsg db "Thank You For Your Password Confirmation$"
    password db 30 dup ("$")
    incorrectPasswordMsg db 10, 13, "Your Password Is Not In The Correct Form"
                         db 10, 13, "Possible Errors:"
                         db 10, 13, "              1) Not having a minimum of 10 characters"
                         db 10, 13, "              2) Password Must Contain (Uppercase, Lowercase, and numbers)"
                         db "$"
    passwordHasNumber db 0
    passwordHasLowerCase db 0
    passwordHasUpperCase db 0
;-------------------------------------password-------------------------------------------------------------

.code
signup proc
    call ShowSignup

;------------------user name-------------------------------------------------------------------------------
;-----enter user name message
UserMsg:
    NEW_LINE

    lea di, username
    lea si, usernameInputMsg
    mov singleInput, 0
    call Prompt

    NEW_LINE

;-----check for strings and numbers
    mov bx,0

ValidateUsername:
    mov dl,username[bx+2]
    cmp dl,0dh
    jg ValidateNumbers
    jmp FinalUserInput

ValidateNumbers:
    cmp dl,'0'
    jl Error
    jmp CompareWithinNumbers

ValidateCapitalLetter:
    cmp dl,'A'
    jl Error
    jmp CompareWithinLetters

EndValidate:
    inc bx
    jmp ValidateUsername

CompareWithinNumbers:
    cmp dl,'9'
    jg ValidateCapitalLetter

CompareWithinLetters:
    cmp dl,'Z'
    jg Error
    jmp EndValidate
;----------------------------------------

Error:
    NEW_LINE
    CHANGE_COLOR 04h, errorMsg
    inc InputCount
    cmp InputCount,3
    je signUpExceed
    jmp UserMsg;

signUpExceed:
    NEW_LINE
    lea si,inputExceedMsg
    mov dl,stringFlag
    call display
    mov inputCount,0
    mov usernameHasNumber,0
    mov usernameHasCapitalLetter,0
    mov validUsername,1
    mov passwordHasNumber,0
    mov passwordHasUpperCase,0
    mov passwordHasLowerCase,0
    jmp EndProgram ; for now

FinalUserInput:
    NEW_LINE

    lea si, usernameConfirmationMsg
    mov dl, stringFlag
    call display

    lea si, username + 2
    mov dl, stringFlag
    call display

    NEW_LINE

;------------------user name---------------------------------------------------------------------------
;------------------password----------------------------------------------------------------------------
InputPassword:
    lea si, inputPasswordMsg
    lea di, password
    call PromptPassword

    mov si, 0
;-----------password validation
ChkStrLength:
    cmp si,10
    je CheckNumAndLetters
    jmp ChkNum

ChkNum:
    cmp password[si],48
    jb ErrorPs

    cmp password[si],57
    jbe AddNum

ChkLetters:
    cmp password[si],'A'
    jb ErrorPs

    cmp password[si],'Z'
    jbe UpLetters

    cmp password[si],'a'
    jb ErrorPs

    cmp password[si],'z'
    jbe LowLetters
    ja ErrorPs

AddNum:
    inc passwordHasNumber
    jmp NextPs

LowLetters:
    inc passwordHasLowerCase
    jmp NextPs

UpLetters:
    inc passwordHasUpperCase
    jmp NextPs

CheckNumAndLetters:
    cmp passwordHasNumber, 0
    jne FinalMsg

    cmp passwordHasLowerCase, 0
    jne FinalMsg

    cmp passwordHasUpperCase, 0
    jne FinalMsg

    jmp InputPassword

NextPs:
    inc si
    jmp ChkStrLength

ErrorPs:
    NEW_LINE

    CHANGE_COLOR 04h, incorrectPasswordMsg

    NEW_LINE

    jmp InputPassword

FinalMsg:
    lea si, password
    mov encrypt, 1
    call cryptogramify

    NEW_LINE

    lea si, finalConfirmationPasswordMsg
    mov dl, stringFlag
    call display

    lea si, password
    mov dl, stringFlag
    call display
    ret

signup endp

