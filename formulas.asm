.data
    promptGroceries db "                       Enter Your Groceries Expenses: RM$"
    promptVehicle db "                       Enter Your Vehicle Expenses: RM$"
    promptAccomodation db "                       Enter Your Accomodation Expenses: RM$"
    promptBills db "                       Enter Your Bills Expenses: RM$"
    promptInsurance db "                       Enter Your Insurance Expenses: RM$"
    promptIncome db "                    Enter Your Income For The Month: RM$"

    showSSTSubTotal db "Your SST value: RM$"
    showGroceriesACTUALTotal db "Your Groceries Total (Rounded Value): RM$"

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

    warning db "Dosbox Does Not Support 32 Bits And Above$"
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
    overallBudgetUsage dw ?

.code
SumExpensesArray proc
    mov cx, 5
    mov ax, 0
    lea si, expensesArray

SumUp:
    mov ax, [si]
    add sumOfAllExpenses, ax
    add si, 2
    loop SumUp
    ret
SumExpensesArray endp

warningMsg:
    CHANGE_COLOR 04h, warning

PromptConvertInsert proc
    ;di = buffer, si = prompt, bx = specific expense amount, cx = 1(has SST) or 0(no SST)
    mov singleInput, 0
    call Prompt

    NEW_LINE
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
    dec dl
    mov bx, dx
    call InsertIntoExpensesArray
    ret

PromptConvertInsert endp

CompareAmountAndCalculatePercentage proc ; si = total (income/expenses), di = destination
    mov dx, 0
    mov ax, [si]
    cmp ax, initialBalance  ;ax < bx
    jb MultiplyFirst ;total < initial
    div initialBalance           ;(total / initial)* 100
    mul hundred
    jmp EndOfCalculating

MultiplyFirst:  ;(total * 100) / initial
    mul hundred
    div initialBalance

EndOfCalculating:
    mov [di], ax
    ret
CompareAmountAndCalculatePercentage endp

UpdateBalance proc
    ;bx = 0(income)/1(expenses), si = currentBalance, di = specific expense / incomeAccount
    cmp bx, 1
    je UpdateIncome
    mov ax, [si]
    sub ax, [di]
    mov [si], ax
    jmp EndOfUpdate

UpdateIncome:
    mov ax, [si]
    add ax, [di]
    mov [si], ax

EndOfUpdate:
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

