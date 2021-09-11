.data
    promptGroceries db "                       Enter Your Groceries Expenses: RM$"
    promptVehicle db "                       Enter Your Vehicle Expenses: RM$"
    promptAccomodation db "                       Enter Your Accomodation Expenses: RM$"
    promptBills db "                       Enter Your Bills Expenses: RM$"
    promptInsurance db "                       Enter Your Insurance Expenses: RM$"
    promptIncome db "                    Enter Your Income For The Month: RM$"

    showSSTSubTotal db 10, 13, "                       Your SST value: RM$"
    showGroceriesACTUALTotal db 10, 13, "                       Your Groceries Total (Rounded Value): RM$"

    incomeBuffer dw 18, ?, 20 dup ("$")
    groceriesBuffer dw 18, ?, 20 dup ("$")
    vehicleBuffer dw 18, ?, 20 dup ("$")
    accomodationBuffer dw 18, ?, 20 dup ("$")
    insuranceBuffer dw 18, ?, 20 dup ("$")
    billsBuffer dw 18, ?, 20 dup ("$")
    initialBalanceBuffer db 18, ?, 20 dup ("$")

    percentage dw ?

    groceriesTail dw 0
    vehicleTail dw 1
    accomodationTail dw 2
    billsTail dw 3
    insuranceTail dw 4

    expensesArray dw 0, 0, 0, 0, 0
    incomeTotal dw 0

    groceriesAmount dw 0
    vehicleAmount dw 0
    accomodationAmount dw 0
    billsAmount dw 0
    insuranceAmount dw 0
    incomeAmount dw 0

    five dw 5
    ten dw 10
    ten2 db 10
    hundred dw 100
    remainder db ?
    quotient db ?
    groceriesSST dw ?
    roundupSST dw ?
    sumOfAllExpenses dw 0
    initialBalance dw 0
    currentBalance dw 0
    previousBalance dw 0
    overallBudgetUsage dw ?

    operand db -1, 0, 1, 2, 3

.code
PromptConvertInsert proc
    ;di = buffer, si = prompt, bx = specific expense amount, cx = 1(has SST) or 0(no SST)
    mov singleInput, 0
    call Prompt

    add di, 2
    mov si, di
    mov di, bx
    call ConvertToNum
    cmp cx, 1
    jne Continue
    call CalculateGroceriesSST

Continue:
    mov ax, [di]

    mov dl, choice
    sub dl, 30h

    mov bx, 0
    mov bl, dl
    dec bl

    add dl, operand[bx]
    mov bx, dx

    call InsertIntoExpensesArray
    ret

PromptConvertInsert endp

CompareAmountAndCalculatePercentage proc ; si = total (income/expenses)
    mov percentage, 0
    mov dx, 0
    mov ax, [si]
    cmp ax, previousBalance  ;ax < bx
    jb MultiplyFirst ;total < previousBalance
    div previousBalance           ;(total / previousBalance)* 100
    mul hundred
    jmp EndOfCalculating

MultiplyFirst:  ;(total * 100) / previousBalance
    mul hundred
    div previousBalance

EndOfCalculating:
    mov percentage, ax
    ret
CompareAmountAndCalculatePercentage endp

UpdateBalance proc
    ;bx = 0(income)/1(expenses), si = currentBalance, di = specific expense / incomeAccount
    mov ax, [si]
    mov previousBalance, ax
    cmp bx, 1
    je UpdateIncome
    sub ax, [di]
    jmp EndOfUpdate

UpdateIncome:
    add ax, [di]

EndOfUpdate:
    mov [si], ax
    ret
UpdateBalance endp

CalculateGroceriesSST proc
    mov ax, groceriesAmount
    mul five
    div hundred
    mov groceriesSST, ax
    mov roundupSST, ax
    mov ax, dx
    div ten2
    mov remainder, ah
    mov quotient, al
    cmp quotient, 5
    jb EndOfCalculation
    inc roundupSST

EndOfCalculation:
    mov ax, groceriesAmount
    add ax, roundupSST
    mov groceriesAmount, ax
    ret
    CalculateGroceriesSST endp

InsertIntoExpensesArray proc ; ax = actual amount, bx = array offset
    add expensesArray[bx], ax
    ret
InsertIntoExpensesArray endp

