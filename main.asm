.model small
.stack 100
.data
    NEW_LINE db 13, 10, "$"
    SHOW_NAEM_MSG db "Ur Naem: $"
    PROMPT_FOR_NAEM db "naem pls: $"
    DEPART_MSG db "Thank you for the headache-inducing assignment and the painful torture of learning the Assembly Language"
               db 13, 10, "We are not grateful and forever resentful. :D$"
    STRING db 1
    ; naem dw 10 dup (0)
    ; naem_length equ $-naem

.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, PROMPT_FOR_NAEM
    mov STRING, 1
    call print

    ; mov dx, naem
    ; mov naem[0], 10
    ; mov naem[1], 0
    ; mov ah, 0ah
    ; int 21h

    lea si, naem + 2
    mov STRING, 1
    call print

EndProgram:
    mov ah, 4ch
    int 21h

main endp

print proc
    cmp STRING, 1
    je PrintStr
    jmp PrintChar

PrintStr:
    lea dx, [si]
    mov ah, 09h
    int 21h
    ret

PrintChar:
    mov dl, [si]
    mov ah, 02h
    int 21h
    ret

print endp

prompt proc ; di = dest, si = msg, cx = count
    mov STRING, 1
    call print
    cmp cx, 1
    je SingleInput

    mov bx, 0
    jmp MultiInput

MultiInput:
    mov ah, 01h
    int 21h

    cmp al, 0Dh ; stops on Carriage Return (Enter Button)
    je Return
    cmp al, 08h ; backspace
    je BackSpace
    mov [di + bx], al
    inc bx
    loop MultiInput

BackSpace:
    cmp bx, 0
    loop MultiInput
    dec bx
    mov [di + bx], al
    inc bx
    loop MultiInput

Return:
    ret

SingleInput:
    mov ah, 01h
    int 21h
    mov [di + bx], al
    ret

prompt endp
end main


