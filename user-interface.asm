.data
    banner db 10, 13, "                 _            _          _"
           db 10, 13, "                | |__ _  _ __| |__ _ ___| |_   __ _ _ __ _ __"
           db 10, 13, "                | '_ \ || / _` / _` / -_)  _| / _` | '_ \ '_ \"
           db 10, 13, "                |_.__/\_,_\__,_\__, \___|\__| \__,_| .__/ .__/"
           db 10, 13, "                               |___/               |_|  |_|"
           db "$"

    main_menu db 10, 13, "                  =============== MAIN MENU =============="
              db 10, 13, "                   1. Record Transaction"
              db 10, 13, "                   2. Display Overall Budget Usage"
              db 10, 13, "                   3. Display Total Income Percentage"
              db 10, 13, "                   4. Display Total Expenses Percentage"
              db 10, 13, "                  ========================================"
              db "$"

    expenses_menu db 10, 13, "                      ========== Expenses ========="
                  db 10, 13, "                       1. Groceries"
                  db 10, 13, "                       2. Vehicle"
                  db 10, 13, "                       3. Accomodation"
                  db 10, 13, "                       4. Bills"
                  db 10, 13, "                       5. Insurance"
                  db 10, 13, "                      ============================="
                  db "$"

    signup_banner db 10, 13, "   ____            _     _                 _                             _"
                  db 10, 13, "  |  _ \ ___  __ _(_)___| |_ ___ _ __     / \   ___ ___ ___  _   _ _ __ | |_"
                  db 10, 13, "  | |_) / _ \/ _` | / __| __/ _ \ '__|   / _ \ / __/ __/ _ \| | | | '_ \| __|"
                  db 10, 13, "  |  _ <  __/ (_| | \__ \ ||  __/ |     / ___ \ (_| (_| (_) | |_| | | | | |_"
                  db 10, 13, "  |_| \_\___|\__, |_|___/\__\___|_|    /_/   \_\___\___\___/ \__,_|_| |_|\__|"
                  db 10, 13, "             |___/"
                  db "$"

    signup_successful_msg db 10, 13, "                        -- Successfully Signed Up! --$"

    include DATETIME.INC

.code
show_main_menu proc
    lea dx, banner
    mov ah, 09h
    int 21h

    NEW_LINE

    lea dx, main_menu
    mov ah, 09h
    int 21h

    ret
show_main_menu endp

show_signup proc
    lea dx, signup_banner
    mov ah, 09h
    int 21h
    ret
show_signup endp

show_successful_signup proc
    CHANGE_COLOR 02h , signup_successful_msg
    ret
show_successful_signup endp

list_expenses proc
    lea dx, expenses_menu
    mov ah, 09h
    int 21h

    ret
list_expenses endp

