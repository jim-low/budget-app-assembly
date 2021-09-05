.code
ParseMainMenu proc
    jmp StartParseMainMenu

SelectRecordTransaction:
    call RecordTransaction
    jmp ProgramStart

SelectDisplayTotalIncomePercentage:
    call DisplayTotalIncomePercentage
    mov ah, 01h
    int 21h
    jmp ProgramStart

SelectDisplayTotalExpensesPercentage:
    call DisplayTotalExpensesPercentage
    mov ah, 01h
    int 21h
    jmp ProgramStart

SelectMainMenuExit:
    jmp EndProgram

StartParseMainMenu:
    cmp choice, "1"
    je SelectRecordTransaction

    cmp choice, "2"
    je SelectDisplayTotalIncomePercentage

    cmp choice, "3"
    je SelectDisplayTotalExpensesPercentage

    cmp choice, "4"
    je SelectMainMenuExit

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
    jmp ProgramStart

SelectExpensesTransaction:
    call ExpensesTransaction
    jmp ProgramStart

SelectTransactionExit:
    jmp ProgramStart

StartParseRecordTransaction:
    cmp choice, "1"
    je SelectIncomeTransaction

    cmp choice, "2"
    je SelectExpensesTransaction

    cmp choice, "3"
    je SelectTransactionExit

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

    PRESS_ANY_KEY
    jmp ProgramStart

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

    PRESS_ANY_KEY
    jmp ProgramStart

StartParseExpensesTransaction:
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
    ret

SelectGroceries:
    lea si, promptGroceries
    lea di, groceriesBuffer
    lea bx, groceriesAmount
    mov cx, 1
    call PromptConvertInsert

    lea si, currentBalance
    lea di, groceriesAmount
    mov bx, 0
    call UpdateBalance

    PRESS_ANY_KEY
    jmp ProgramStart

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

    PRESS_ANY_KEY
    jmp ProgramStart

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

    PRESS_ANY_KEY
    jmp ProgramStart

ParseExpensesTransaction endp

