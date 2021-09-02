.model small
.stack 100
.data
    departMsg db "Thank you for the headache-inducing assignment and the painful torture of learning the Assembly Language"
              db 13, 10, "We are not grateful and forever resentful. :D$"
    choiceErrorMsg db "clearly the list is only from 1 to 6, but you still went over it you donkey$"
    choice db ?
    include utils.inc
    include sign-up.asm
    include login.asm
    include formulas.asm
    include user-i~1.asm

.code
main proc
    mov ax, @data
    mov ds, ax

Start:
    CLEAR
    call ShowMainMenu

InvalidChoice:
    CHANGE_COLOR 04h, choiceErrorMsg
    jmp Start

EndProgram:
    mov ah, 4ch
    int 21h

main endp
end main

