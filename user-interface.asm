.data
     banner db 10, 13, "                 ___         _          _       _"
            db 10, 13, "                | _ )_  _ __| |__ _ ___| |_    /_\  _ __ _ __"
            db 10, 13, "                | _ \ || / _` / _` / -_)  _|  / _ \| '_ \ '_ \"
            db 10, 13, "                |___/\_,_\__,_\__, \___|\__| /_/ \_\ .__/ .__/"
            db 10, 13, "                              |___/                |_|  |_|"
            db "$"

    mainMenu db 10, 13, "                  =============== main menu =============="
              db 10, 13, "                    1. Record Transaction"
              db 10, 13, "                    2. Display Total Income Percentage"
              db 10, 13, "                    3. Display Total Expenses Percentage"
              db 10, 13, "                    4. Exit"
              db 10, 13, "                  ========================================"
              db "$"

    expensesMenu db 10, 13, "                      ========== expenses ========="
                  db 10, 13, "                        1. Groceries"
                  db 10, 13, "                        2. Vehicle"
                  db 10, 13, "                        3. Accomodation"
                  db 10, 13, "                        4. Bills"
                  db 10, 13, "                        5. Insurance"
                  db 10, 13, "                      ============================="
                  db "$"

    signupBanner db 10, 13, "          ___          _    _               _                      _"
                  db 10, 13, "         | _ \___ __ _(_)__| |_ ___ _ _    /_\  __ __ ___ _  _ _ _| |_"
                  db 10, 13, "         |   / -_) _` | (_-<  _/ -_) '_|  / _ \/ _/ _/ _ \ || | ' \  _|"
                  db 10, 13, "         |_|_\___\__, |_/__/\__\___|_|   /_/ \_\__\__\___/\_,_|_||_\__|"
                  db 10, 13, "                 |___/"
                  db "$"

    signupSuccessfulMsg db 10, 13, "                        -- Successfully Signed Up! --$"

    loginBanner db 10, 13, "                          _              _"
                db 10, 13, "                         | |   ___  __ _(_)_ _"
                db 10, 13, "                         | |__/ _ \/ _` | | ' \"
                db 10, 13, "                         |____\___/\__, |_|_||_|"
                db 10, 13, "                                   |___/"
                db "$"

    userDecoration db " +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+$"
    usernameFormat db "Username: $"
    balanceFormat db "Balance: RM$"

    include datetime.inc

.code
ShowMainMenu proc
    call showDate
    call showTime
    call ShowUserInfo

    NEW_LINE

    lea si, banner
    mov dl, stringFlag
    call display

    NEW_LINE

    lea si, mainMenu
    mov dl, stringFlag
    call display
    ret
ShowMainMenu endp

ShowSignup proc
    lea si, signupBanner
    mov dl, stringFlag
    call display
    ret
ShowSignup endp

ShowSuccessfulSignup proc
    change_color 02h , signupSuccessfulMsg
    ret
ShowSuccessfulSignup endp

showLogin proc
    lea si, loginBanner
    mov dl, stringFlag
    call display
    ret
showLogin endp

ShowUserInfo proc
    mov dh, 4
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, userDecoration
    mov dl, stringFlag
    call display

    NEW_LINE

    mov dh, 5
    mov dl, 30
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, usernameFormat
    mov dl, stringFlag
    call display

    lea si, username
    mov dl, stringFlag
    call display

    NEW_LINE

    mov dh, 6
    mov dl, 30
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, balanceFormat
    mov dl, stringFlag
    call display

    lea si, balance
    mov dl, digitsFlag
    call display

    NEW_LINE

    lea si, userDecoration
    mov dl, stringFlag
    call display
    ret

ShowUserInfo endp

ListExpenses proc
    lea si, expensesMenu
    mov dl, stringFlag
    call display
    ret
ListExpenses endp

