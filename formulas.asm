.data
    promptChoice db 0dh, 0ah, "enter your choice(1 - groceries, 2 - bills): $"
    promptGroceries db 0dh, 0ah, "enter your groceries expenses: $"
    promptBills db 0dh, 0ah, "enter your bills expenses: $"
    warning db "16 bit dont go more than 65355, too bad$"
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
    newBalance dw 42069
    currentBalance dw 0
    overallBudgetUsage dw ?

.code
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

promptBillsExpenses:
    lea di, billsBuffer
    lea si, PromptBills
    mov singleInput, 0
    call Prompt

    lea si, billsBuffer
    lea di, billsExpenses
    call ConvertToNum

    lea si, expensesArray
    mov ax, billsExpenses
    mov bx, billsTail
    call InsertIntoExpensesArray

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

    ;jmp end_program  ;no end_program here, so comment it first ;very sad time

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

