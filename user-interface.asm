.data
     banner db 10, 13, "                 ___         _          _       _"
            db 10, 13, "                | _ )_  _ __| |__ _ ___| |_    /_\  _ __ _ __"
            db 10, 13, "                | _ \ || / _` / _` / -_)  _|  / _ \| '_ \ '_ \"
            db 10, 13, "                |___/\_,_\__,_\__, \___|\__| /_/ \_\ .__/ .__/"
            db 10, 13, "                              |___/                |_|  |_|"
            db "$"

    mainMenu db 10, 13, "                  =============== Main Menu =============="
             db 10, 13, "                    1. Record Transaction"
             db 10, 13, "                    2. Display Total Income Percentage"
             db 10, 13, "                    3. Display Total Expenses Percentage"
             db 10, 13, "                    4. Exit"
             db 10, 13, "                  ========================================"
             db "$"

    transactionBanner db 10, 13, "                 _____                          _   _          "
                      db 10, 13, "                |_   _| _ __ _ _ _  ___ __ _ __| |_(_)___ _ _  "
                      db 10, 13, "                  | || '_/ _` | ' \(_-</ _` / _|  _| / _ \ ' \ "
                      db 10, 13, "                  |_||_| \__,_|_||_/__/\__,_\__|\__|_\___/_||_|"
                      db "$"


    transactionSelectionMenu db 10, 13, "                  =============== Transactions =============="
                             db 10, 13, "                       1. Income Transaction"
                             db 10, 13, "                       2. Expenses Transaction"
                             db 10, 13, "                       3. Back"
                             db 10, 13, "                  ==========================================="
                             db "$"


    expensesBanner db 10, 13, "                   _____                                     "
                   db 10, 13, "                  | ____|_  ___ __   ___ _ __  ___  ___  ___ "
                   db 10, 13, "                  |  _| \ \/ / '_ \ / _ \ '_ \/ __|/ _ \/ __|"
                   db 10, 13, "                  | |___ >  <| |_) |  __/ | | \__ \  __/\__ \"
                   db 10, 13, "                  |_____/_/\_\ .__/ \___|_| |_|___/\___||___/"
                   db 10, 13, "                             |_|                             "
                   db "$"

    expensesMenu db 10, 13, "                        ========== Expenses ========="
                 db 10, 13, "                          1. Groceries"
                 db 10, 13, "                          2. Vehicle"
                 db 10, 13, "                          3. Accomodation"
                 db 10, 13, "                          4. Bills"
                 db 10, 13, "                          5. Insurance"
                 db 10, 13, "                          6. Back"
                 db 10, 13, "                        ============================="
                 db "$"

    signupBanner db 10, 13, "          ___          _    _               _                      _"
                 db 10, 13, "         | _ \___ __ _(_)__| |_ ___ _ _    /_\  __ __ ___ _  _ _ _| |_"
                 db 10, 13, "         |   / -_) _` | (_-<  _/ -_) '_|  / _ \/ _/ _/ _ \ || | ' \  _|"
                 db 10, 13, "         |_|_\___\__, |_/__/\__\___|_|   /_/ \_\__\__\___/\_,_|_||_\__|"
                 db 10, 13, "                 |___/"
                 db "$"

    loginBanner db 10, 13, "         _                _            _                             _   "
                db 10, 13, "        | |    ___   __ _(_)_ __      / \   ___ ___ ___  _   _ _ __ | |_ "
                db 10, 13, "        | |   / _ \ / _` | | '_ \    / _ \ / __/ __/ _ \| | | | '_ \| __|"
                db 10, 13, "        | |__| (_) | (_| | | | | |  / ___ \ (_| (_| (_) | |_| | | | | |_ "
                db 10, 13, "        |_____\___/ \__, |_|_| |_| /_/   \_\___\___\___/ \__,_|_| |_|\__|"
                db 10, 13, "                    |___/                                                "
                db "$"

    initialBalanceMsg db 10, 13, "           _                      ___              _"
                      db 10, 13, "          |_.__|_ _ ._ \_/_    ._  | ._ o_|_o _.| |_) _.| _.._  _ _"
                      db 10, 13, "          |_| ||_(/_|   |(_)|_||  _|_| || |_|(_|| |_)(_||(_|| |(_(/_"
                      db "$"

    exitMsg db 10, 13, "             ______ _                    _      _"
            db 10, 13, "            (_) |  | |                  | |    (_|   |"
            db 10, 13, "                |  | |     __,   _  _   | |      |   |  __"
            db 10, 13, "              _ |  |/ \   /  |  / |/ |  |/_)     |   | /  \_|   |"
            db 10, 13, "             (_/   |   |_/\_/|_/  |  |_/| \_/     \_/|/\__/  \_/|_/"
            db 10, 13, "                                                    /|"
            db 10, 13, "                                                    \|"
            db 10, 13, "             _                        ,__ __                _"
            db 10, 13, "            (_|   |_/                /|  |  |              | |    |"
            db 10, 13, "              |   | _   ,_            |  |  |          __  | |    |"
            db 10, 13, "              |   ||/  /  |  |   |    |  |  |  |   |  /    |/ \   |"
            db 10, 13, "               \_/ |__/   |_/ \_/|/   |  |  |_/ \_/|_/\___/|   |_/o"
            db 10, 13, "                                /|"
            db 10, 13, "                                \|"
            db "$"

    userDecoration db " +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+$"
    usernameFormat db "Username: $"
    balanceFormat db "Balance: RM$"

    expensesPercentagesBanner db 10, 13, "                      ___                               "
                              db 10, 13, "                     | __|_ ___ __  ___ _ _  ___ ___ ___"
                              db 10, 13, "                     | _|\ \ / '_ \/ -_) ' \(_-</ -_|_-<"
                              db 10, 13, "                     |___/_\_\ .__/\___|_||_/__/\___/__/"
                              db 10, 13, "                             |_|                        "
                              db 10, 13, "                 ___                    _                    "
                              db 10, 13, "                | _ \___ _ _ __ ___ _ _| |_ __ _ __ _ ___ ___"
                              db 10, 13, "                |  _/ -_) '_/ _/ -_) ' \  _/ _` / _` / -_|_-<"
                              db 10, 13, "                |_| \___|_| \__\___|_||_\__\__,_\__, \___/__/"
                              db 10, 13, "                                                |___/        "
                              db "$"

    expensesPercentages db 10, 13, "                      Groceries Percentage        :"
                        db 10, 13, "                      Vehicle Percentage          :"
                        db 10, 13, "                      Accomodation Percentage     :"
                        db 10, 13, "                      Bills Percentage            :"
                        db 10, 13, "                      Insurance Percentage        :"
                        db "$"

    loopCount dw 0
    arrIndex dw 0
    rowNum db 12


    incomePercentageBanner db 10, 13, "                      ___                                "
                           db 10, 13, "                     |_ _|_ __   ___ ___  _ __ ___   ___ "
                           db 10, 13, "                      | || '_ \ / __/ _ \| '_ ` _ \ / _ \"
                           db 10, 13, "                      | || | | | (_| (_) | | | | | |  __/"
                           db 10, 13, "                     |___|_| |_|\___\___/|_| |_| |_|\___|"
                           db 10, 13, "                                                  "
                           db 10, 13, "               ____                         _                   "
                           db 10, 13, "              |  _ \ ___ _ __ ___ ___ _ __ | |_ __ _  __ _  ___ "
                           db 10, 13, "              | |_) / _ \ '__/ __/ _ \ '_ \| __/ _` |/ _` |/ _ \"
                           db 10, 13, "              |  __/  __/ | | (_|  __/ | | | || (_| | (_| |  __/"
                           db 10, 13, "              |_|   \___|_|  \___\___|_| |_|\__\__,_|\__, |\___|"
                           db 10, 13, "                                                     |___/      "
                           db "$"

    incomePercentage db "                      Your Income Percentage        : $"

    include datetime.inc

.code
ShowMainMenu proc
    call showDate
    call showTime
    call ShowUserInfo

    NEW_LINE

    lea si, banner
    mov dl, stringFlag
    call Display

    NEW_LINE

    lea si, mainMenu
    mov dl, stringFlag
    call display
    ret
ShowMainMenu endp

ShowTransactionMenu proc
    lea si, transactionBanner
    mov dl, stringFlag
    call display

    NEW_LINE

    lea si, transactionSelectionMenu
    mov dl, stringFlag
    call display
    ret
ShowTransactionMenu endp

ShowSignup proc
    lea si, signupBanner
    mov dl, stringFlag
    call display
    ret
ShowSignup endp

ShowLogin proc
    lea si, loginBanner
    mov dl, stringFlag
    call display
    ret
ShowLogin endp

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

    lea si, username + 2
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

    lea si, currentBalance
    mov dl, digitsFlag
    call display

    NEW_LINE

    lea si, userDecoration
    mov dl, stringFlag
    call display
    ret

ShowUserInfo endp

ListExpenses proc
    lea si, expensesBanner
    mov dl, stringFlag
    call display
    NEW_LINE
    lea si, expensesMenu
    mov dl, stringFlag
    call display
    ret
ListExpenses endp

ShowExitScreen proc
    CLEAR

    mov dh, 4
    mov dl, 5
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, exitMsg
    mov dl, stringFlag
    call Display

    ret
ShowExitScreen endp

ShowInitialBalanceScreen proc
    CLEAR

    mov dh, 8
    mov dl, 5
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, initialBalanceMsg
    mov dl, stringFlag
    call Display

    NEW_LINE

    mov dh, 14
    mov dl, 29
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, balanceFormat
    mov dl, stringFlag
    call Display

    ret
ShowInitialBalanceScreen endp

DisplayFloatingPoint proc ; si = msg, di = value
    lea si, [si]
    mov dl, stringFlag
    call Display

    lea si, [di]
    mov dl, digitsFlag
    call Display

    mov dl, '.'
    mov ah, 02h
    int 21h

    lea si, quotient
    mov dl, charFlag
    call Display

    lea si, remainder
    mov dl, charFlag
    call Display
    ret
DisplayFloatingPoint endp

DisplayTotalExpensesPercentage proc
    lea si, expensesPercentagesBanner
    mov dl, stringFlag
    call Display

    NEW_LINE

    lea si, expensesPercentages
    mov dl, stringFlag
    call Display

    mov cx, 5
    mov bx, 0

DisplayPercentages:
    mov dh, rowNum
    mov dl, 52
    mov bh, 0
    mov ah, 2
    int 10h

    mov loopCount, cx
    mov arrIndex, bx

    lea si, expensesArray[bx]
    call CompareAmountAndCalculatePercentage

    lea si, percentage
    mov dl, digitsFlag
    call Display

    mov cx, loopCount
    mov bx, arrIndex

    mov dl, "%"
    mov ah, 02h
    int 21h

    add bx, 2
    inc rowNum

    loop DisplayPercentages

    mov dh, 20
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    mov rowNum, 12

    ret
DisplayTotalExpensesPercentage endp

DisplayTotalIncomePercentage proc
    lea si, incomePercentageBanner
    mov dl, stringFlag
    call Display

    NEW_LINE
    NEW_LINE
    NEW_LINE
    NEW_LINE

    lea si, incomePercentage
    mov dl, stringFlag
    call Display

    lea si, incomeTotal
    call CompareAmountAndCalculatePercentage

    lea si, percentage
    mov dl, digitsFlag
    call Display

    mov dl, "%"
    mov ah, 02h
    int 21h

    mov dh, 20
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    ret
DisplayTotalIncomePercentage endp

