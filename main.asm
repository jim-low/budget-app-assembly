.model small
.stack 100
.data
    choicePrompt db "                             Enter your choice: $"
    choice db ?

    totalExpensesPercentageMsg db "Your total expenses percentage is 69420% lmao, you broke af$"
    totalIncomePercentageMsg db "Your total income percentage is 0% lmao$"

    initialBalancePrompt db "Please Enter Your Current Balance: $"
    initialBalanceBuffer db 18, ?, 20 dup ("$")

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

    call SignUp
    call Login

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

DisplayTotalIncomePercentage:
    lea si, totalIncomePercentageMsg
    mov dl, stringFlag
    call Display
    ret

DisplayTotalExpensesPercentage:
    lea si, totalExpensesPercentageMsg
    mov dl, stringFlag
    call Display
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

