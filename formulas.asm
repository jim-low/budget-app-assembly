.data
    prompt_choice DB 0DH, 0AH, "Enter your choice(1 - groceries, 2 - bills): $"
    prompt_groceries DB 0DH, 0AH, "Enter your groceries expenses: $"
	prompt_bills DB 0DH, 0AH, "Enter your bills expenses: $"
	WARNING DB "DOSBOX does not support 32 bits and above$"
	CHOICE DB ?
    TEN DW 10
	HUNDRED DW 100
	expenses_array DW 0, 0, 0, 0, 0
	groceries_SST DW ?
	groceries_buffer DW 18, ?, 20 dup ("$")
	groceries_tail DW 0  ;tail is different and fixed for every expense
	groceries_expenses DW 1234
	bills_buffer DW 18, ?, 20 dup ("$")
	bills_tail DW 1      ;tail is different and fixed for every expense
	bills_expenses DW 0
	SumOfAllExpenses DW 0
	NewBalance DW 0
	CurrentBalance DW 9855
	OverallBudgetUsage DW ?
	temp DW 0
	printable_num DW 10 DUP ("$")
	NL DB 0DH, 0AH, "$"

.code
    ; all the best - Jim
	    MOV AX, @DATA
		MOV DS, AX
START:
		MOV AH, 09H
		LEA DX, prompt_choice
		INT 21H
		
		MOV AH, 01H
		INT 21H
		SUB AL, 30H
		MOV CHOICE, AL
		
		CMP CHOICE, 1
		JE PROMPT_GROCERIES_EXPENSES
		CMP CHOICE, 2
		JE PROMPT_BILLS_EXPENSES
		
;BudgetUsage = Sum Of All Expenses In That Area 
;(ALL EXPENSES IN ONE ARRAY)(DONE, use this)		
PROMPT_GROCERIES_EXPENSES:

		MOV AH, 09H
		LEA DX, prompt_groceries
		INT 21H
		
		MOV AH, 0AH
		LEA DX, groceries_buffer
		INT 21H
		
		MOV AH, 09H
		LEA DX, NL
		INT 21H
		
		LEA SI, groceries_buffer
		LEA DI, groceries_expenses   ;to store the current groceries expense, which will be added to expenses_array later
		CALL ConvertToNum
		CALL CalculateGroceriesSST
		
		LEA SI, expenses_array
		MOV AX, groceries_expenses  ;groceries_expenses = 1234
		MOV BX, groceries_tail      ;groceries_tail = 0
		CALL InsertIntoExpensesArray
		
		MOV AH, 09H
		LEA DX, NL
		INT 21H
		CALL START

PROMPT_BILLS_EXPENSES:

		MOV AH, 09H
		LEA DX, prompt_bills
		INT 21H
		
		MOV AH, 0AH
		LEA DX, bills_buffer
		INT 21H
		
		MOV AH, 09H
		LEA DX, NL
		INT 21H
		
		LEA SI, bills_buffer
		LEA DI, bills_expenses
		CALL ConvertToNum
		
		LEA SI, expenses_array  ;load the address of the array into SI, SI is now pointing to the array
		MOV AX, bills_expenses
		MOV BX, bills_tail      ;BX = 1
		CALL InsertIntoExpensesArray
		
		MOV AH, 09H
		LEA DX, NL
		INT 21H
		
		
		
		
;NewBalance = CurrentBalance - Expenses (DONE)
SUM_ALL_EXPENSES:
	MOV CX, 5
	MOV AX, 0
	LEA SI, expenses_array
SUM_UP:
	MOV AX, [SI]
	ADD SumOfAllExpenses, AX
	ADD SI, 2
	LOOP SUM_UP
	
NEW_BALANCE:
	MOV AX, CurrentBalance
	SUB AX, SumOfAllExpenses
	MOV NewBalance, AX


;OverallBudgetUsage = Sum Of All Expenses * 100 / PreviousBalance (Forever WIP)
	MOV DX, 0
	MOV AX, SumOfAllExpenses
	CMP AX, 655
	JA WARNING_MSG
	MUL HUNDRED
	DIV CurrentBalance
	MOV OverallBudgetUsage, AX
		
	LEA SI, printable_num
	LEA DI, OverallBudgetUsage    ;digit that needs to be printed
	MOV BX, 0
	CALL ConvertToChar
	MOV temp, BX
	MOV CX, temp
	LEA SI, printable_num
	ADD SI, temp
	CALL PrintMultipleDigitsNum
		
	;JMP END_PROGRAM  ;no END_PROGRAM here, so comment it first
		
WARNING_MSG:
    MOV AH, 09H
    LEA DX, WARNING
	INT 21H
		
		
		
		

;FUNCTIONS
ConvertToChar proc near

CONVERT_TO_CHAR:
        MOV CX, 0
		MOV DX, 0
		MOV DX, [DI]
        CMP DX, 0
		JE END_CHAR_CONVERSION
		MOV DX, 0
		MOV AX, [DI]
		DIV TEN
		MOV [DI], AX
		MOV AX, 0
		ADD DX, 30H
		MOV [SI], DL
		INC CX
		ADD BX, CX
		INC SI
		JMP CONVERT_TO_CHAR
		
END_CHAR_CONVERSION:
        RET
		
ConvertToChar endp

PrintMultipleDigitsNum proc near

PRINTING: 
        MOV AH, 02H
		MOV DL, [SI-1];3 2 1 0
		INT 21H
		DEC SI
		LOOP PRINTING
		RET

PrintMultipleDigitsNum endp

ConvertToNum proc near
		MOV BX, 2
		MOV AX, 0
CONVERT_TO_NUM:
        MOV Dl, [SI]
		CMP Dl, 0Dh
		JE END_CONVERSION
		
		MOV DX, 0
		MOV AX, [DI]
		MUL TEN
		ADD SI, BX  ;[SI+BX]
		ADD DX, [SI]
		MOV DH, 0
		SUB DX, 30H
		ADD AX, DX
		MOV [DI], AX
		INC SI
		MOV BX, 0
		JMP CONVERT_TO_NUM
		
END_CONVERSION:
        RET
		
ConvertToNum endp

CalculateGroceriesSST proc near

    MOV AX, groceries_expenses
	MUL FIVE
	DIV HUNDRED
	MOV groceries_SST, AX
	MOV AX, groceries_expenses
	ADD AX, groceries_SST
	MOV groceries_expenses, AX
	RET
	
CalculateGroceriesSST endp

InsertIntoExpensesArray proc near

INSERT_INTO_EXPENSES_ARR:
        ;ADD SI, BX    ;[SI+BX]
        ADD [SI+BX], AX  ;access the memory of SI => location of the 1st element => add the value of AX there
		MOV BX, 0
		JMP END_INSERTION

END_INSERTION:
        RET
		
InsertIntoExpensesArray endp


