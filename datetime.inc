.data
    day db ?
    month db ?
    year dw ?
    yearRemainder db ?
    dateDecoration db "+-+-+-+-+-+-+-+-+$"
    dateFormat db "00 / 00 / 0000$"

    hours db ?
    minutes db ?
    seconds db ?
    timeDecoration db "+-+-+-+-+-+$"
    timeFormat db "00 : 00$"

.code
ShowDate proc
GetDate:
    mov ah, 2ah
    int 21h

    mov day, dl
    mov month, dh
    mov year, cx
    jmp FormatDate

FormatDate:
    lea si, day
    lea di, dateFormat
    mov bx, 0
    call Insert8BitData

    lea si, month
    lea di, dateFormat
    mov bx, 5
    call Insert8BitData

    lea si, year
    mov bx, 13
    mov cx, 4
    call Insert16BitData

    call PrintDate
    ret

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
        mov dateFormat[bx], ah
        mov ah, 0
        mov yearRemainder, al
        dec bx
        lea si, yearRemainder
        loop Insert16BitData
        ret

PrintDate:
    mov dh, 0
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, dateDecoration
    mov dl, stringFlag
    call display

    mov dh, 2
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, dateDecoration
    mov dl, stringFlag
    call display

    mov dh, 1
    mov dl, 1
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, dateFormat
    mov dl, stringFlag
    call display
    ret

ExtendZero:
    mov ah, 0
    jmp ExtendZeroEnd

ShowDate endp

ShowTime proc
GetTime:
    mov ah, 2ch
    int 21h

    mov hours, ch
    mov minutes, cl
    mov seconds, dh

FormatTime:
    lea si, hours
    lea di, timeFormat
    mov bx, 0
    call Insert8BitData

    lea si, minutes
    lea di, timeFormat
    mov bx, 5
    call Insert8BitData

PrintTime:
    mov dh, 0
    mov dl, 69
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, timeDecoration
    mov dl, stringFlag
    call display

    mov dh, 2
    mov dl, 69
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, timeDecoration
    mov dl, stringFlag
    call display

    mov dh, 1
    mov dl, 71
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, timeFormat
    mov dl, stringFlag
    call display
    ret

ShowTime endp

