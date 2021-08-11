.data
    day db ?
    month db ?
    year dw ?
    date_format db "00/00/0000$"

.code
date proc
GetDate:
    mov ah, 2ah
    int 21h

    mov day, dl
    mov month, dh
    mov year, cx
    jmp FormatDate

FormatDate:
    lea si, day
    mov bx, 0
    call Insert8BitDate

    lea si, month
    mov bx, 3
    call Insert8BitDate

    lea dx, date_format
    mov ah, 09h
    int 21h
    ret

Insert8BitDate:
    mov dl, 10
    mov ax, 0
    mov al, [si]
    div dl
    add al, '0'
    add ah, '0'
    mov date_format[bx], al
    mov date_format[bx+1], ah
    ret

date endp

