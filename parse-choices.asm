.data
    MAIN_MENU_MAX db "5"
    TRANSACTION_MENU_MAX db "4"
    EXPENSES_MENU_MAX db "7"

.code
ParseMainMenu proc
    jmp StartParseMainMenu

SelectRecordTransaction:
    call RecordTransaction
    jmp ProgramStart

SelectDisplayTotalIncomePercentage:
    call DisplayTotalIncomePercentage
    PRESS_ANY_KEY
    jmp ProgramStart

SelectDisplayTotalExpensesPercentage:
    call DisplayTotalExpensesPercentage
    PRESS_ANY_KEY
    jmp ProgramStart

MainMenuOutOfRange:
    jmp ProgramStart

StartParseMainMenu:
    cmp choice, "0"
    jle MainMenuOutOfRange

    mov dl, MAIN_MENU_MAX
    cmp choice, dl
    jge MainMenuOutOfRange

    cmp choice, "1"
    je SelectRecordTransaction

    cmp choice, "2"
    je SelectDisplayTotalIncomePercentage

    cmp choice, "3"
    je SelectDisplayTotalExpensesPercentage

    jmp EndProgram

ParseMainMenu endp

ParseRecordTransaction proc
    jmp StartParseRecordTransaction

SelectIncomeTransaction:
    NEW_LINE
    NEW_LINE
    lea si, promptIncome
    lea di, incomeBuffer
    mov singleInput, 0
    call Prompt

    lea si, incomeBuffer + 2
    lea di, incomeAmount
    call ConvertToNum

    lea si, currentBalance
    lea di, incomeAmount
    mov bx, 1
    call UpdateBalance

    NEW_LINE
    PRESS_ANY_KEY
    jmp RecordTransaction

SelectExpensesTransaction:
    call ExpensesTransaction

RecordTransactionOutOfRange:
    jmp RecordTransaction

StartParseRecordTransaction:
    cmp choice, "0"
    jle RecordTransactionOutOfRange

    mov dl, TRANSACTION_MENU_MAX
    cmp choice, dl
    jge RecordTransactionOutOfRange

    cmp choice, "1"
    je SelectIncomeTransaction

    cmp choice, "2"
    je SelectExpensesTransaction
    ret

ParseRecordTransaction endp

ParseExpensesTransaction proc
    NEW_LINE
    NEW_LINE
    jmp StartParseExpensesTransaction

SelectBills:
    lea si, promptBills
    lea di, billsBuffer
    lea bx, billsAmount
    mov cx, 1
    call PromptConvertInsert

    lea si, currentBalance
    lea di, billsAmount
    mov bx, 0
    call UpdateBalance

    jmp RestartExpensesTransaction

SelectInsurance:
    lea si, promptInsurance
    lea di, insuranceBuffer
    lea bx, insuranceAmount
    mov cx, 1
    call PromptConvertInsert

    lea si, currentBalance
    lea di, insuranceAmount
    mov bx, 0
    call UpdateBalance

    jmp RestartExpensesTransaction

ExpensesTransactionOutOfRange:
    jmp ExpensesTransaction

StartParseExpensesTransaction:
    cmp choice, "0"
    jle ExpensesTransactionOutOfRange

    mov dl, EXPENSES_MENU_MAX
    cmp choice, dl
    jge ExpensesTransactionOutOfRange

    cmp choice, "1"
    je SelectGroceries

    cmp choice, "2"
    je SelectVehicle

    cmp choice, "3"
    je SelectAccomodation

    cmp choice, "4"
    je SelectBills

    cmp choice, "5"
    je SelectInsurance

    jmp RecordTransaction

SelectGroceries:
    lea si, promptGroceries
    lea di, groceriesBuffer
    lea bx, groceriesAmount
    mov cx, 1
    call PromptConvertInsert

    lea si, showSSTSubTotal
    lea di, groceriesSST
    call DisplayFloatingPoint

    lea si, showGroceriesACTUALTotal
    mov dl, stringFlag
    call Display

    lea si, groceriesAmount
    mov dl, digitsFlag
    call Display

    lea si, currentBalance
    lea di, groceriesAmount
    mov bx, 0
    call UpdateBalance

    jmp RestartExpensesTransaction

SelectVehicle:
    lea si, promptVehicle
    lea di, vehicleBuffer
    lea bx, vehicleAmount
    mov cx, 1
    call PromptConvertInsert

    lea si, currentBalance
    lea di, vehicleAmount
    mov bx, 0
    call UpdateBalance

    jmp RestartExpensesTransaction

SelectAccomodation:
    lea si, promptAccomodation
    lea di, accomodationBuffer
    lea bx, accomodationAmount
    mov cx, 1
    call PromptConvertInsert

    lea si, currentBalance
    lea di, accomodationAmount
    mov bx, 0
    call UpdateBalance

RestartExpensesTransaction:
    PRESS_ANY_KEY
    jmp ExpensesTransaction

ParseExpensesTransaction endp

