.data
    SINGLE_INPUT db ?

CLEAR macro ; to clear console screen
    mov ax, 0003h
    int 10h
endm

NEW_LINE macro
    mov dl, 0dh
    mov ah, 02h
    int 21h

    mov dl, 0ah
    mov ah, 02h
    int 21h
endm

; stackoverflow perhaps?
; 0 = Black
; 1 = Blue
; 2 = Green
; 3 = Aqua
; 4 = Red
; 5 = Purple
; 6 = Yellow
; 7 = White
; 8 = Gray
; 9 = Light Blue
CHANGE_COLOR macro color_code, msg
    mov ah, 09h
    mov cx, 1000h
    mov al, 20h
    mov bl, color_code
    int 10h

    lea dx, msg
    mov ah, 09h
    int 21h

    mov ah, 09h
    mov bl, 07h
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

; TODO:
; - add a proc for displaying:
;   - character
;   - string
; pro gamer move
; mov     al, 182         ; meaning that we're about to load
;    out     43h, al         ; a new countdown value
;
;    mov     ax, 2153        ; countdown value is stored in ax. It is calculated by
;                            ; dividing 1193180 by the desired frequency (with the
;                            ; number being the frequency at which the main system
;                            ; oscillator runs
;    out     42h, al         ; Output low byte.
;    mov     al, ah          ; Output high byte.
;    out     42h, al
;
;    in      al, 61h
;                            ; to connect the speaker to timer 2
;    or      al, 00000011b
;    out     61h, al         ; Send the new value
