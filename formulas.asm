.data
    promptChoice db 0dh, 0ah, "enter your choice(1 - groceries, 2 - bills): $"
    promptGroceries db 0dh, 0ah, "enter your groceries expenses: $"
    promptBills db 0dh, 0ah, "enter your bills expenses: $"
    warning db "dosbox does not support 32 bits and above$"
    choice db ?
    five dw 5
    ten dw 10
    hundred dw 100
    expensesArray dw 0, 0, 0, 0, 0
    groceriesSST dw ?
    groceriesBuffer dw 18, ?, 20 dup ("$")
    groceriesTail dw 0  ;tail is different and fixed for every expense
    groceriesExpenses dw 1234
    billsBuffer dw 18, ?, 20 dup ("$")
    billsTail dw 1      ;tail is different and fixed for every expense
    billsExpenses dw 0
    sumOfAllExpenses dw 0
    newBalance dw 0
    currentBalance dw 9855
    overallBudgetUsage dw ?

.code
Start:
    mov ah, 09h
    lea dx, promptChoice
    int 21h

    mov ah, 01h
    int 21h
    sub al, 30h
    mov choice, al

    cmp choice, 1
    je promptGroceriesExpenses
    cmp choice, 2
    je promptBillsExpenses

;budgetusage = sum of all expenses in that area
;(all expenses in one array)(done, use this)
promptGroceriesExpenses:

    mov ah, 09h
    lea dx, promptGroceries
    int 21h

    mov ah, 0ah
    lea dx, groceriesBuffer
    int 21h

    NEW_LINE

    lea si, groceriesBuffer
    lea di, groceriesExpenses   ;to store the current groceries expense, which will be added to expenses_array later
    call ConvertToNum
    call CalculateGroceriesSST

    lea si, expensesArray
    mov ax, groceriesExpenses  ;groceries_expenses = 1234
    mov bx, groceriesTail      ;groceries_tail = 0
    call InsertIntoExpensesArray

    CLEAR
    call Start

promptBillsExpenses:
    mov ah, 09h
    lea dx, promptBills
    int 21h

    mov ah, 0ah
    lea dx, billsBuffer
    int 21h

    CLEAR

    lea si, billsBuffer
    lea di, billsExpenses
    call ConvertToNum

    lea si, expensesArray  ;load the address of the array into si, si is now pointing to the array
    mov ax, billsExpenses
    mov bx, billsTail      ;bx = 1
    call InsertIntoExpensesArray

    CLEAR

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
    mov ah, 09h
    lea dx, warning
    int 21h

ConvertToNum proc near
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

CalculateGroceriesSST proc near
    mov ax, groceriesExpenses
    mul five
    div hundred
    mov groceriesSST, ax
    mov ax, groceriesExpenses
    add ax, groceriesSST
    mov groceriesExpenses, ax

    ret
CalculateGroceriesSST endp

InsertIntoExpensesArray proc near
InsertIntoExpensesArr:
    ;add si, bx    ;[si+bx]
    add [si+bx], ax  ;access the memory of si => location of the 1st element => add the value of ax there
    mov bx, 0
    jmp EndInsertion

EndInsertion:
    ret
InsertIntoExpensesArray endp

