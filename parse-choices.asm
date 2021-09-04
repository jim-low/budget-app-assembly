; things to parse
; 1. main menu
; 2. transaction selection
; 3. expenses choices

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
    lea si, promptIncome
    lea di, incomeBuffer
    mov singleInput, 0
    call Prompt

    lea si, incomeBuffer + 2
    lea di, incomeAmount
    call ConvertToNum

    mov ax, incomeTotal
    add ax, incomeAmount
    mov incomeTotal, ax

    mov ax, incomeAmount
    add newBalance, ax

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
    jmp StartParseExpensesTransaction

SelectBills:
    lea si, promptBills
    lea di, billsBuffer
    mov singleInput, 0
    call Prompt

    lea si, billsBuffer + 2
    lea di, billsAmount
    call ConvertToNum

    mov ax, billsAmount
    mov dx, 0
    mov dl, choice
    sub dl, '0'
    dec dl
    mov bx, dx
    call InsertIntoExpensesArray
    jmp ProgramStart

SelectInsurance:
    lea si, promptInsurance
    lea di, insuranceBuffer
    mov singleInput, 0
    call Prompt

    lea si, insuranceBuffer + 2
    lea di, insuranceAmount
    call ConvertToNum

    mov ax, insuranceAmount
    mov dx, 0
    mov dl, choice
    sub dl, '0'
    dec dl
    mov bx, dx
    call InsertIntoExpensesArray
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
    mov singleInput, 0
    call Prompt

    lea si, groceriesBuffer + 2
    lea di, groceriesAmount
    call ConvertToNum

    call CalculateGroceriesSST

    mov ax, groceriesAmount
    mov dx, 0
    mov dl, choice
    sub dl, '0'
    dec dl
    mov bx, dx
    call InsertIntoExpensesArray
    jmp ProgramStart

SelectVehicle:
    lea si, promptVehicle
    lea di, insuranceBuffer
    mov singleInput, 0
    call Prompt

    lea si, insuranceBuffer + 2
    lea di, insuranceAmount
    call ConvertToNum

    mov ax, insuranceAmount
    mov dx, 0
    mov dl, choice
    sub dl, '0'
    dec dl
    mov bx, dx
    call InsertIntoExpensesArray
    jmp ProgramStart

SelectAccomodation:
    lea si, promptAccomodation
    lea di, accomodationBuffer
    mov singleInput, 0
    call Prompt

    lea si, accomodationBuffer + 2
    lea di, accomodationAmount
    call ConvertToNum

    mov ax, accomodationAmount
    mov dx, 0
    mov dl, choice
    sub dl, '0'
    dec dl
    mov bx, dx
    call InsertIntoExpensesArray
    jmp ProgramStart

ParseExpensesTransaction endp

