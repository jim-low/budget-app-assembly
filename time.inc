.data
    hours db ?
    minutes db ?
    seconds db ?
    time_format db "00:00:00$"

.code
show_time proc
GetTime:
    mov ah, 2ch
    int 21h

    mov hours, ch
    mov minutes, cl
    mov seconds, dh

FormatTime:
    lea si, hours
    lea di, time_format
    mov bx, 0
    call Insert8BitData

    lea si, minutes
    lea di, time_format
    mov bx, 3
    call Insert8BitData

    lea si, seconds
    lea di, time_format
    mov bx, 6
    call Insert8BitData

PrintTime:
    lea dx, time_format
    mov ah, 09h
    int 21h
    ret

show_time endp

