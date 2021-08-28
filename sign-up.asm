.data
;-------------------------------------user name-------------------------------------------------------------
    inputMsg db "please enter and create your user name :  $"
    errorMsg db "incorect userinput (capital letters and numbers only) $"
    username db 30,?,32 dup("$")
    usernameHasNumber db 0
    usernameHasCapitalLetter db 0
    validUsername db 1
    usernameConfirmationMsg db "your user name is comfirmed >>> $"
;-------------------------------------user name-------------------------------------------------------------
;-------------------------------------Password--------------------------------------------------------------
    inputPsMsg db "please enter your desired password [length = 10] : $"
    confirmPsMsg db "please comfirm your password : $"
    finalPsMsg db "thank you for your password comfirmation : $"
    inputPs db 10,?,10 dup("$")
    errorPsMsg db  10,13,"your password is not in the correct form"
               db  10,13,"possible error:"
               db  10,13,"              1) not in 10 characters form"
               db  10,13,"              2) password must contain (uppercase,lowercase,number characters)"
               db  10,13,"              3) only characters metioned in 2) is acceptable$"
    nums db 0
    lowerLetters db 0
    upperLetters db 0
;-------------------------------------password-------------------------------------------------------------

.code
signup proc
    call ShowSignup

;------------------user name-------------------------------------------------------------------------------
;-----enter user name message
UserMsg:
    NEW_LINE

    lea di, username
    lea si, inputMsg
    mov singleInput, 0
    call Prompt

    NEW_LINE

;-----check for strings and numbers
    mov bx,0

ValidateUsername:
    mov dl,username[bx+2]
    cmp dl,0dh
    je FinalUserInput
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
    jmp UserMsg;

FinalUserInput:
    NEW_LINE

    lea si, usernameConfirmationMsg
    mov dl, stringFlag
    call display

    lea si, username + 2
    mov dl, stringFlag
    call display

    jmp Password

;------------------user name---------------------------------------------------------------------------
;------------------password----------------------------------------------------------------------------
Password:
    NEW_LINE

    lea si, inputPsMsg
    mov dl, stringFlag
    call display


;-get input
    mov cx,15
    mov si,0

GetInputPs:
    mov ah,07h
    int 21h
    mov inputPs[si],al
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
    cmp inputPs[si],48
    jb ErrorPs

    cmp inputPs[si],57
    jbe AddNum

ChkLetters:
    cmp inputPs[si],'a'
    jb ErrorPs

    cmp inputPs[si],'z'
    jbe NextPs

    cmp inputPs[si],'a'
    jb ErrorPs

    cmp inputPs[si],'z'
    jbe NextPs
    ja ErrorPs

AddNum:
    inc nums
    jmp NextPs

LowLetters:
    inc lowerLetters
    jmp NextPs

UpLetters:
    inc upperLetters
    jmp NextPs

CheckNumAndLetters:
    cmp nums,0
    jne Password
    cmp lowerLetters,0
    jne Password
    cmp upperLetters,0
    jne Password
    jmp FinalMsg

NextPs:
    inc si
    jmp ChkStrLength


ErrorPs:
    NEW_LINE

    CHANGE_COLOR 04h, errorPsMsg

    NEW_LINE
    jmp Password

FinalMsg:
    NEW_LINE

    lea si, finalPsMsg
    mov dl, stringFlag
    call display


    lea si, inputPs
    mov dl, stringFlag
    call display

    jmp exit

signup endp

