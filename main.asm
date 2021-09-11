.model small
.stack 100
.data
    choicePrompt db "                             Enter your choice: $"
    choice db ?

    include utils.inc
    include sign-up.asm
    include login.asm
    include formulas.asm
    include user-i~1.asm
    include parse-~1.asm

.code
main proc
    mov ax, @data
    mov ds, ax

Registration:
    call SignUp
    call Login
    cmp isSuccess, 0
    je Registration

    CLEAR
    call PromptInitialBalance

    jmp ProgramStart

RecordTransaction:
    CLEAR

    call ShowTransactionMenu

    NEW_LINE

    lea si, choicePrompt
    lea di, choice
    mov singleInput, 1
    call Prompt

    call ParseRecordTransaction

    ret

ExpensesTransaction:
    CLEAR

    call ListExpenses

    NEW_LINE

    lea si, choicePrompt
    lea di, choice
    mov singleInput, 1
    call Prompt

    call ParseExpensesTransaction

    ret

ProgramStart:
    CLEAR
    call ShowMainMenu

    NEW_LINE

    lea si, choicePrompt
    lea di, choice
    mov singleInput, 1
    call Prompt

    call ParseMainMenu

EndProgram:
    call ShowExitScreen

    mov ah, 4ch
    int 21h

main endp

PromptInitialBalance proc
    call ShowInitialBalanceScreen

    lea dx, initialBalanceBuffer
    mov ah, 0ah
    int 21h

    lea si, initialBalanceBuffer + 2
    lea di, initialBalance
    call ConvertToNum

    mov ax, initialBalance
    mov currentBalance, ax
    ret
PromptInitialBalance endp
end main

