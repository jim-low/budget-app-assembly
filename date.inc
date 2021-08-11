.data
    day db ?
    month db ?
    year dw ?

.code
date proc far
GetDate:
    mov ah, 2ah
    int 21h

    mov day, dl
    mov month, dh
    mov year, cx
    ret

date endp

