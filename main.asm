.model small
.stack 100
.data
    DEPART_MSG db "Thank you for the headache-inducing assignment and the painful torture of learning the Assembly Language"
               db 13, 10, "We are not grateful and forever resentful. :D$"
    include utils.inc

.code
main proc
    mov ax, @data
    mov ds, ax

EndProgram:
    mov ah, 4ch
    int 21h

main endp
end main


