.data
     banner db 10, 13, "                 ___         _          _       _"
            db 10, 13, "                | _ )_  _ __| |__ _ ___| |_    /_\  _ __ _ __"
            db 10, 13, "                | _ \ || / _` / _` / -_)  _|  / _ \| '_ \ '_ \"
            db 10, 13, "                |___/\_,_\__,_\__, \___|\__| /_/ \_\ .__/ .__/"
            db 10, 13, "                              |___/                |_|  |_|"
            db "$"

    main_menu db 10, 13, "                  =============== MAIN MENU =============="
              db 10, 13, "                   1. Record Transaction"
              db 10, 13, "                   2. Display Overall Budget Usage"
              db 10, 13, "                   3. Display Total Income Percentage"
              db 10, 13, "                   4. Display Total Expenses Percentage"
              db 10, 13, "                   5. Exit"
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

    signup_banner db 10, 13, "          ___          _    _               _                      _"
                  db 10, 13, "         | _ \___ __ _(_)__| |_ ___ _ _    /_\  __ __ ___ _  _ _ _| |_"
                  db 10, 13, "         |   / -_) _` | (_-<  _/ -_) '_|  / _ \/ _/ _/ _ \ || | ' \  _|"
                  db 10, 13, "         |_|_\___\__, |_/__/\__\___|_|   /_/ \_\__\__\___/\_,_|_||_\__|"
                  db 10, 13, "                 |___/"
                  db "$"

    signup_successful_msg db 10, 13, "                        -- Successfully Signed Up! --$"

    user_decoration db " +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+$"
    username_format db "Username: $"
    balance_format db "Balance: RM$"

    include DATETIME.INC

.code
show_main_menu proc
    call show_date
    call show_time

    lea si, username
    lea di, balance
    call show_user_info

    NEW_LINE

    lea si, banner
    mov dl, STRING_FLAG
    call display

    NEW_LINE

    lea si, main_menu
    mov dl, STRING_FLAG
    call display

    ret
show_main_menu endp

show_signup proc
    lea si, signup_banner
    mov dl, STRING_FLAG
    call display
    ret
show_signup endp

show_successful_signup proc
    CHANGE_COLOR 02h , signup_successful_msg
    ret
show_successful_signup endp

show_user_info proc ; si = username, di = balance
    mov dh, 4
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, user_decoration
    mov dl, STRING_FLAG
    call display

    NEW_LINE

    mov dh, 5
    mov dl, 30
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, username_format
    mov dl, STRING_FLAG
    call display

    lea si, username
    mov dl, STRING_FLAG
    call display

    NEW_LINE

    mov dh, 6
    mov dl, 30
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, balance_format
    mov dl, STRING_FLAG
    call display

    lea si, balance
    mov dl, DIGITS_FLAG
    call display

    NEW_LINE

    lea si, user_decoration
    mov dl, STRING_FLAG
    call display
    ret

show_user_info endp

list_expenses proc
    lea si, expenses_menu
    mov dl, STRING_FLAG
    call display

    ret
list_expenses endp

