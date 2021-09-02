.model small
.stack 100
.data
    departMsg db "Thank you for the headache-inducing assignment and the painful torture of learning the Assembly Language"
              db 13, 10, "We are not grateful and forever resentful. :D$"
    choiceErrorMsg db "clearly the list is only from 1 to 6, but you still went over it you donkey$"
    choicePrompt db "                             Enter your choice: $"
    choice db ?
    TotalExpensesPercentageMsg db "Your total expenses percentage is 69420% lmao, you broke af$"
    TotalIncomePercentageMsg db "Your total income percentage is 0% lmao$"

    include utils.inc
    include sign-up.asm
    include login.asm
    include formulas.asm
    include user-i~1.asm

.code
main proc
    mov ax, @data
    mov ds, ax

    call SignUp
    call Login

Start:
    CLEAR
    call ShowMainMenu

    NEW_LINE

    lea si, choicePrompt
    lea di, choice
    mov singleInput, 1
    call Prompt

    CLEAR

    call MainMenuParse

    jmp EndProgram

ChoiceError:
    CHANGE_COLOR 04h, choiceErrorMsg
    jmp Start

EndProgram:
    lea si, departMsg
    mov dl, stringFlag
    call Display

    mov ah, 4ch
    int 21h

main endp

MainMenuParse proc
    cmp choice, "0"
    jle ChoiceError

    cmp choice, "5"
    jge ChoiceError

    cmp choice, "1"
    je PerformRecordTransaction

    cmp choice, "2"
    je TotalIncomePercentage

    cmp choice, "3"
    je TotalExpensesPercentage

    jmp EndProgram

PerformRecordTransaction:
    call ShowTransactionMenu

    NEW_LINE

    lea si, choicePrompt
    lea di, choice
    mov singleInput, 1
    call Prompt
    jmp ParseTransactionChoice

PerformExpenseTransaction:


PerformIncomeTransaction:

ParseTransactionChoice:
    cmp choice, "1"

    ret

TotalExpensesPercentage:
    lea si, TotalExpensesPercentageMsg
    mov dl, stringFlag
    call Display
    NEW_LINE
    ret

TotalIncomePercentage:
    lea si, TotalIncomePercentageMsg
    mov dl, stringFlag
    call Display
    NEW_LINE
    ret

MainMenuParse endp

end main

