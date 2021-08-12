.data
    day db ?
    month db ?
    year dw ?
    year_remainder db ?
    date_format db "00/00/0000$"

.code
show_date proc
GetDate:
    mov ah, 2ah
    int 21h

    mov day, dl
    mov month, dh
    mov year, cx
    jmp FormatDate

FormatDate:
    lea si, day
    lea di, date_format
    mov bx, 0
    call Insert8BitData

    lea si, month
    lea di, date_format
    mov bx, 3
    call Insert8BitData

    lea si, year
    mov bx, 9
    mov cx, 4
    call Insert16BitData

Insert8BitData:
    mov dl, 10
    mov ax, 0
    mov al, [si]
    div dl
    add al, '0'
    add ah, '0'
    add di, bx
    mov [di], al
    inc di
    mov [di], ah
    ret

Insert16BitData:
    mov dl, 10
    mov ax, 0
    mov ax, [si]
    cmp cx, 4
    jl ExtendZero
    ExtendZeroEnd:
        div dl
        add ah, '0'
        mov date_format[bx], ah
        mov ah, 0
        mov year_remainder, al
        dec bx
        lea si, year_remainder
        loop Insert16BitData

PrintDate:
    lea dx, date_format
    mov ah, 09h
    int 21h
    ret

ExtendZero:
    mov ah, 0
    jmp ExtendZeroEnd

show_date endp

