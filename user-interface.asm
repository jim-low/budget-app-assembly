.model small
.stack 100
.data
    ; choices go by ascending order (1..5)
    expenses db "Groceries"
             db "Vehicle"
             db "Accomodation"
             db "Bills" ; can be further expanded if needed
             db "Insurance"
    banner db 10, 13, " _            _          _"
           db 10, 13, "| |__ _  _ __| |__ _ ___| |_   __ _ _ __ _ __"
           db 10, 13, "| '_ \ || / _` / _` / -_)  _| / _` | '_ \ '_ \"
           db 10, 13, "|_.__/\_,_\__,_\__, \___|\__| \__,_| .__/ .__/"
           db 10, 13, "               |___/               |_|  |_|"
           db "$"
    user_choice db 0

.code
main proc

main endp
end main
