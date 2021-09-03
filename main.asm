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
    ;je TotalIncomePercentage

    cmp choice, "3"
    ;je TotalExpensesPercentage

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
    ;cmp choice, "1"
    ;je promptGroceriesExpenses
    ;cmp choice, "2"
    ;je promptVehicleExpenses
    ;cmp choice, "3"
    ;je promptAccomodationExpenses
    ;cmp choice, "4"
    ;je promptBillsExpenses
    ;cmp choice, "5"
    ;je promptInsuranceExpenses
    ;cmp choice, "6" ; to exit
    ;je promptExpenses

promptIncome:
    lea di, incomeBuffer
    lea si, incomePrompt
    mov singleInput, 0
    call Prompt

    NEW_LINE

    lea si, incomeBuffer
    lea di, income
    call ConvertToNum

promptGroceriesExpenses:
    lea di, groceriesBuffer
    lea si, promptGroceries
    mov singleInput, 0
    call Prompt

    NEW_LINE

    lea si, groceriesBuffer
    lea di, groceriesExpenses
    call ConvertToNum
    call CalculateGroceriesSST

    lea si, expensesArray
    mov ax, groceriesExpenses
    mov bx, groceriesTail
    call InsertIntoExpensesArray

    CLEAR
    call Start

promptVehicleExpenses:
    lea di, vehicleBuffer
    lea si, promptVehicle
    mov singleInput, 0
    call Prompt

    NEW_LINE

    lea si, vehicleBuffer
    lea di, vehicleExpenses
    call ConvertToNum

    lea si, expensesArray
    mov ax, vehicleExpenses
    mov bx, vehicleTail
    call InsertIntoExpensesArray

    CLEAR
    call Start

promptAccomodationExpenses:
    lea di, accomodationBuffer
    lea si, promptAccomodation
    mov singleInput, 0
    call Prompt

    NEW_LINE

    lea si, accomodationBuffer
    lea di, accomodationExpenses
    call ConvertToNum

    lea si, expensesArray
    mov ax, accomodationExpenses
    mov bx, accomodationTail
    call InsertIntoExpensesArray

    CLEAR
    call Start

promptBillsExpenses:
    lea di, billsBuffer
    lea si, promptBills
    mov singleInput, 0
    call Prompt

    CLEAR

    lea si, billsBuffer
    lea di, billsExpenses
    call ConvertToNum

    lea si, expensesArray
    mov ax, billsExpenses
    mov bx, billsTail
    call InsertIntoExpensesArray

    CLEAR
    call Start

promptInsuranceExpenses:
    lea di, insuranceBuffer
    lea si, promptInsurance
    mov singleInput, 0
    call Prompt

    NEW_LINE

    lea si, insuranceBuffer
    lea di, insuranceExpenses
    call ConvertToNum

    lea si, expensesArray
    mov ax, insuranceExpenses
    mov bx, insuranceTail
    call InsertIntoExpensesArray

    CLEAR
    call Start

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

