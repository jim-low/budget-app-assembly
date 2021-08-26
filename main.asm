.model small
.stack 100
.data
    depart_msg db "thank you for the headache-inducing assignment and the painful torture of learning the assembly language"
               db 13, 10, "we are not grateful and forever resentful. :d$"
    include utils.inc
    include formulas.asm
    include login.asm
    include sign-up.asm
    include user-i~1.asm

.code
main proc
    mov ax, @data
    mov ds, ax

endprogram:
    mov ah, 4ch
    int 21h

main endp
end main

