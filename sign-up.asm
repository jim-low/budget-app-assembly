.data
;-------------------------------------user name-------------------------------------------------------------
    usernameInputMsg db "please enter and create your user name :  $"
    errorMsg db "incorrect user input (capital letters and numbers only) $"
    username db 30, ?, 30 + 2 dup ("$")
    usernameHasNumber db 0
    usernameHasCapitalLetter db 0
    validUsername db 1
    usernameConfirmationMsg db "your user name is comfirmed >>> $"
    inputExceedMsg db "You have exceeded the maximum amount of tries,please try again later$"
    inputCount db 0
;-------------------------------------user name-------------------------------------------------------------

;-------------------------------------Password--------------------------------------------------------------
    inputPasswordMsg db "please enter your desired password [length = 10] : $"
    confirmPasswordMsg db "please confirm your password : $"
    finalConfirmationPasswordMsg db "thank you for your password comfirmation : $"
    password db 30, ?, 30 + 2 dup("$")
    incorrectPasswordMsg db  10,13,"your password is not in the correct form"
               db  10,13,"possible error:"
               db  10,13,"              1) not in 10 characters form"
               db  10,13,"              2) password must contain (uppercase,lowercase,number characters)"
               db  10,13,"              3) only characters metioned in 2) is acceptable$"
    passwordHasNumber db 0
    passwordHasLowerCase db 0
    passwordHasUpperCase db 0
;-------------------------------------password-------------------------------------------------------------

.code
signup proc
    call ShowSignup
    jmp FinalMsg

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
    jne ValidateNumbers
    jmp FinalUserInput

ValidateNumbers:
    cmp dl,'0'
    jl Error
    jmp CompareWithinNumbers

ValidateCapitalLetter:
    cmp dl,'a'
    jl Error
    jmp CompareWithinLetters

EndValidate:
    inc bx
    jmp ValidateUsername

CompareWithinNumbers:
    cmp dl,'9'
    jg ValidateCapitalLetter

CompareWithinLetters:
    cmp dl,'z'
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
    jmp main

FinalUserInput:
    NEW_LINE

    lea si, usernameConfirmationMsg
    mov dl, stringFlag
    call display

    lea si, username + 2
    mov dl, stringFlag
    call display

    jmp InputPassword

;------------------user name---------------------------------------------------------------------------
;------------------password----------------------------------------------------------------------------
InputPassword:
    NEW_LINE

    lea si, inputPasswordMsg
    mov dl, stringFlag
    call display


;-get input
    mov cx,15
    mov si,0

GetInputPs:
    mov ah,07h
    int 21h
    mov password[si],al
    inc si

    mov ah,02h
    mov dl,'@'
    int 21h
    loop GetInputPs
    NEW_LINE

    mov si,0
;-----------password validation
ChkStrLength:
    cmp si,15
    je CheckNumAndLetters
    jne ChkNum

ChkNum:
    cmp password[si],48
    jb ErrorPs

    cmp password[si],57
    jbe AddNum

ChkLetters:
    cmp password[si],'a'
    jb ErrorPs

    cmp password[si],'z'
    jbe NextPs

    cmp password[si],'a'
    jb ErrorPs

    cmp password[si],'z'
    jbe NextPs
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
    lea si,password+2
    mov encryptFlag,1
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

