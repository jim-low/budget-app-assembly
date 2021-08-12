.model small
.stack 100
.data
    banner db 10, 13, " _            _          _"
           db 10, 13, "| |__ _  _ __| |__ _ ___| |_   __ _ _ __ _ __"
           db 10, 13, "| '_ \ || / _` / _` / -_)  _| / _` | '_ \ '_ \"
           db 10, 13, "|_.__/\_,_\__,_\__, \___|\__| \__,_| .__/ .__/"
           db 10, 13, "               |___/               |_|  |_|"
           db "$"

    main_menu db "============== MAIN MENU =============="
       db 10, 13, "1. Record Transaction"
       db 10, 13, "2. Display Overall Budget Usage"
       db 10, 13, "3. Display Total Income Percentage"
       db 10, 13, "4. Display Total Expenses Percentage"
       db 10, 13, "======================================="
       db "$"

    expenses_list db "1. Groceries"
          db 10, 13, "2. Vehicle"
          db 10, 13, "3. Accomodation"
          db 10, 13, "4. Bills" ; can be further expanded if needed
          db 10, 13, "5. Insurance"
          db "$"
    include DATE.INC
    include TIME.INC

.code
main proc
    mov ax, @data
    mov ds, ax
    call date

main endp
end main
