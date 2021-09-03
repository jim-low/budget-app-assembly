; things to parse
; 1. main menu
; 2. transaction selection
; 3. expenses choices

.code
ParseMainMenu proc
    jmp StartParseMainMenu

SelectRecordTransaction:
    call RecordTransaction
    ret

SelectDisplayTotalIncomePercentage:
    call DisplayTotalIncomePercentage
    ret

SelectDisplayTotalExpensesPercentage:
    call DisplayTotalExpensesPercentage
    ret

SelectMainMenuExit:
    call EndProgram

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

