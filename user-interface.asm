.model small
.stack 100
.data
    ; choices go by ascending order (1..5)
    expenses db "Groceries"
             db "Vehicle"
             db "Accomodation"
             db "Bills" ; can be further expanded
             db "Insurance"
    user_choice db 0

.code
main proc

main endp
end main
