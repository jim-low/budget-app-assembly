.data
    promptGroceries db 0dh, 0ah, "Enter Your Groceries Expenses: $"
    promptVehicle db 0dh, 0ah, "Enter Your Vehicle Expenses: $"
    promptAccomodation db 0dh, 0ah, "Enter Your Accomodation Expenses: $"
    promptBills db 0dh, 0ah, "Enter Your Bills Expenses: $"
    promptInsurance db 0dh, 0ah, "Enter Your Insurance Expenses: $"
    incomePrompt db 0dh, 0ah, "Enter Your Income For The Month: $"

    incomeBuffer dw 18, ?, 20 dup ("$")
    groceriesBuffer dw 18, ?, 20 dup ("$")
    vehicleBuffer dw 18, ?, 20 dup ("$")
    accomodationBuffer dw 18, ?, 20 dup ("$")
    insuranceBuffer dw 18, ?, 20 dup ("$")
    billsBuffer dw 18, ?, 20 dup ("$")

    groceriesTail dw 0
    vehicleTail dw 1
    accomodationTail dw 2
    billsTail dw 3
    insuranceTail dw 4

    expensesArray dw 0, 0, 0, 0, 0

    groceriesExpenses dw 0
    vehicleExpenses dw 0
    accomodationExpenses dw 0
    billsExpenses dw 0
    insuranceExpenses dw 0
    income dw 0

    warning db "Dosbox Does Not Support 32 Bits And Above$"
    five dw 5
    ten dw 10
    hundred dw 100
    groceriesSST dw ?
    sumOfAllExpenses dw 0
    newBalance dw 0
    currentBalance dw 0
    overallBudgetUsage dw ?

.code
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

    mov dx, 0
    mov ax, sumOfAllExpenses
    cmp ax, 655
    ja warningMsg
    mul hundred
    div currentBalance
    mov overallBudgetUsage, ax

warningMsg:
    CHANGE_COLOR 04h, warning

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

