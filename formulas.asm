.data
    promptChoice db 0dh, 0ah, "enter your choice(1 - groceries, 2 - bills): $"
    promptGroceries db 0dh, 0ah, "enter your groceries expenses: $"
	promptVehicle db 0dh, 0ah, "enter your vehicle expenses: $"
	promptAccomodation db 0dh, 0ah, "enter your accomodation expenses: $"
	promptBills db 0dh, 0ah, "enter your bills expenses: $"
    promptInsurance db 0dh, 0ah, "enter your insurance expenses: $"
	promptIncome db 0dh, 0ah, "enter your income: $"
	incomeBuffer dw 18, ?, 20 dup ("$")
	currentIncome dw 0
    warning db "dosbox does not support 32 bits and above$"
    choice db ?
    five dw 5
    ten dw 10
    hundred dw 100
    expensesArray dw 0, 0, 0, 0, 0
    groceriesSST dw ?
    groceriesBuffer dw 18, ?, 20 dup ("$")
    groceriesTail dw 0
    groceriesExpenses dw 0
	vehicleBuffer dw 18, ?, 20 dup ("$")
    vehicleTail dw 1
    vehicleExpenses dw 0
	accomodationBuffer dw 18, ?, 20 dup ("$")
    accomodationTail dw 2
    accomodationExpenses dw 0
    billsBuffer dw 18, ?, 20 dup ("$")
    billsTail dw 1
    billsExpenses dw 0
	insuranceBuffer dw 18, ?, 20 dup ("$")
    insuranceTail dw 4
    insuranceExpenses dw 0
    sumOfAllExpenses dw 0
    newBalance dw 0
    currentBalance dw 0
    overallBudgetUsage dw ?

.code

promptForIncome:
    lea di, incomeBuffer
    lea si, promptIncome
    mov singleInput, 0
    call Prompt

    NEW_LINE

    lea si, incomeBuffer
    lea di, currentIncome
    call ConvertToNum

Start:
    lea di, choice
    lea si, promptChoice
    mov singleInput, 1
    call Prompt

    cmp choice, 1
    je promptGroceriesExpenses
    cmp choice, 2
    je promptBillsExpenses

;budgetusage = sum of all expenses in that area
;(all expenses in one array)(done, use this)
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

    lea si, expensesArray  ;load the address of the array into si, si is now pointing to the array
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

    ;newbalance = currentbalance - expenses (done)
SumAllExpenses:
    mov cx, 5
    mov ax, 0
    lea si, expensesArray

SumUp:
    mov ax, [si]
    add sumOfAllExpenses, ax
    add si, 2
    loop SumUp

CalculateNewBalance:
    mov ax, currentBalance
    sub ax, sumOfAllExpenses
    mov newBalance, ax

    ;overallbudgetusage = sum of all expenses * 100 / previousbalance (forever wip)
    mov dx, 0
    mov ax, sumOfAllExpenses
    cmp ax, 655
    ja warningMsg
    mul hundred
    div currentBalance
    mov overallBudgetUsage, ax

    ;jmp end_program  ;no end_program here, so comment it first

warningMsg:
    CHANGE_COLOR 04h, warning

ConvertToNum proc
    mov bx, 2
    mov ax, 0
Convert:
    mov dl, [si]
    cmp dl, 0dh
    je EndConversion

    mov dx, 0
    mov ax, [di]
    mul ten
    add si, bx  ;[si+bx]
    add dx, [si]
    mov dh, 0
    sub dx, 30h
    add ax, dx
    mov [di], ax
    inc si
    mov bx, 0
    jmp Convert

EndConversion:
    ret
ConvertToNum endp

CalculateGroceriesSST proc
    mov ax, groceriesExpenses
    mul five
    div hundred
    mov groceriesSST, ax
    mov ax, groceriesExpenses
    add ax, groceriesSST
    mov groceriesExpenses, ax

    ret
CalculateGroceriesSST endp

InsertIntoExpensesArray proc
InsertIntoExpensesArr:
    add [si+bx], ax
    mov bx, 0
    jmp EndInsertion

EndInsertion:
    ret
InsertIntoExpensesArray endp

