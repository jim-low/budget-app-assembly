; things to parse
; 1. main menu
; 2. transaction selection
; 3. expenses choices

.code
ParseMainMenu proc
    jmp StartParseMainMenu

SelectRecordTransaction:
    call RecordTransaction

StartParseMainMenu:
    cmp choice, "1"
    je SelectRecordTransaction

ParseMainMenu endp

