.data
    SINGLE_INPUT db ?

CLEAR macro ; to clear console screen
    mov ax, 0003h
    int 10h
endm

.code
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

