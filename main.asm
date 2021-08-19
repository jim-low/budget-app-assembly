.model small
.stack 100
.data
    NEW_LINE db 13, 10, "$"
    SHOW_NAEM_MSG db "Ur Naem: $"
    PROMPT_FOR_NAEM db "naem pls: $"
    DEPART_MSG db "Thank you for the headache-inducing assignment and the painful torture of learning the Assembly Language"
               db 13, 10, "We are not grateful and forever resentful. :D$"
    SINGLE_INPUT db ?
    include USER-I~1.ASM

CLEAR macro ; to clear console screen
    mov ax, 0003h
    int 10h
endm

.code
main proc
    mov ax, @data
    mov ds, ax

EndProgram:
    mov ah, 4ch
    int 21h

main endp

prompt proc ; di = dest, si = msg, SINGLE_INPUT = count
    lea dx, [si]
    mov ah, 09h
    int 21h

    cmp SINGLE_INPUT, 1
    je SingleInput
    jmp MultiInput

MultiInput:
    lea dx, [di]
    mov ah, 0ah
    int 21h
    ret

SingleInput:
    mov ah, 01h
    int 21h
    mov [di + bx], al
    ret

prompt endp
end main


