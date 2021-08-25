.data
     banner db 10, 13, "                 ___         _          _       _"
            db 10, 13, "                | _ )_  _ __| |__ _ ___| |_    /_\  _ __ _ __"
            db 10, 13, "                | _ \ || / _` / _` / -_)  _|  / _ \| '_ \ '_ \"
            db 10, 13, "                |___/\_,_\__,_\__, \___|\__| /_/ \_\ .__/ .__/"
            db 10, 13, "                              |___/                |_|  |_|"
            db "$"

    main_menu db 10, 13, "                  =============== MAIN MENU =============="
              db 10, 13, "                    1. Record Transaction"
              db 10, 13, "                    2. Display Total Income Percentage"
              db 10, 13, "                    3. Display Total Expenses Percentage"
              db 10, 13, "                    4. Exit"
              db 10, 13, "                  ========================================"
              db "$"

    expenses_menu db 10, 13, "                      ========== Expenses ========="
                  db 10, 13, "                        1. Groceries"
                  db 10, 13, "                        2. Vehicle"
                  db 10, 13, "                        3. Accomodation"
                  db 10, 13, "                        4. Bills"
                  db 10, 13, "                        5. Insurance"
                  db 10, 13, "                      ============================="
                  db "$"

    signup_banner db 10, 13, "          ___          _    _               _                      _"
                  db 10, 13, "         | _ \___ __ _(_)__| |_ ___ _ _    /_\  __ __ ___ _  _ _ _| |_"
                  db 10, 13, "         |   / -_) _` | (_-<  _/ -_) '_|  / _ \/ _/ _/ _ \ || | ' \  _|"
                  db 10, 13, "         |_|_\___\__, |_/__/\__\___|_|   /_/ \_\__\__\___/\_,_|_||_\__|"
                  db 10, 13, "                 |___/"
                  db "$"

    signup_successful_msg db 10, 13, "                        -- Successfully Signed Up! --$"

    user_decoration db " +-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+$"
    username_format db "Username: $"
    balance_format db "Balance: RM$"

    include DATETIME.INC

.code
show_main_menu proc
    call show_date
    call show_time
    call show_user_info

    NEW_LINE

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

show_user_info proc ; si = username, di = balance
    mov dh, 4
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    lea dx, user_decoration
    mov ah, 09h
    int 21h

    NEW_LINE

    mov dh, 5
    mov dl, 32
    mov bh, 0
    mov ah, 2
    int 10h

    lea dx, username_format
    mov ah, 09h
    int 21h

    lea dx, [si]
    int 21h

    NEW_LINE

    mov dh, 6
    mov dl, 30
    mov bh, 0
    mov ah, 2
    int 10h

    lea dx, balance_format
    mov ah, 09h
    int 21h

    lea dx, [di]
    mov ah, 09h
    int 21h

    NEW_LINE

    lea dx, user_decoration
    mov ah, 09h
    int 21h
    ret

show_user_info endp

list_expenses proc
    lea dx, expenses_menu
    mov ah, 09h
    int 21h

    ret
list_expenses endp

