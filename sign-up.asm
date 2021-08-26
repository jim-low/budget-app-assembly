.model small
.stack 100h

begin macro
mov ax,@data
mov ds,ax
endm

printStr macro aString
mov ah,9h
lea dx, aString
int 21h
endm

;readch macro aValue
;mov ah,1h
;int 21h
;mov aValue,al
;endm

.data
;------------------------------------Sign-------------------------------------------------------------------
	signUp db 13,10,"        +++++++++++++++   "
               db 13,10,"        +   SIGN UP   +   "
               db 13,10,"        +++++++++++++++   $"

;-------------------------------------User name-------------------------------------------------------------
	inputMsg db "Please enter and create your user name :  $"
	errorMsg db "Incorect userinput (Capital letters and numbers only) $"
	userName db 30,?,32 dup("$")
	userNameHasNumber db 0
	userNameHasCapitalLetter db 0
	validUserName db 1
	userNameComfirmationMsg db "Your user name is comfirmed >>> $"
	nl db 10,13,"$"
;-------------------------------------User name-------------------------------------------------------------
;-------------------------------------Password--------------------------------------------------------------
	inputPsMsg db "Please enter your desired password [length = 10] : $"
	comfirmPsMsg db "Please comfirm your password : $"
	finalPsMsg db "Thank you for your password comfirmation : $"
	inputPs db 10,?,10 dup("$")
	errorPsMsg db  10,13,"Your password is not in the correct form"
        	   db  10,13,"Possible error:"
		   db  10,13,"              1) Not in 10 characters form"
	           db  10,13,"              2) Password must contain (uppercase,lowercase,number characters)"
	           db  10,13,"              3) Only characters metioned in 2) is acceptable$"
	nums db 0
	lowerLetters db 0
	upperLetters db 0
;-------------------------------------Password-------------------------------------------------------------
.code
main proc
	begin
	mov ax,0
	printStr signUp

;------------------USER NAME-------------------------------------------------------------------------------
;-----enter user name message
userMsg:
	printStr nl
	printStr inputMsg

;----get user input
inputGetter:
	lea dx,userName
	mov ah,0Ah
	int 21h
	printStr nl

;-----check for strings and numbers
	mov bx,0
validateUsername:
	mov dl,userName[bx+2]
	cmp dl,0dh
	je finalUserInput
	validateNumbers:
		cmp dl,'0'
		jl error
		jmp compareWithinNumbers

	validateCapitalLetter:
		cmp dl,'A'
		jl error
		jmp compareWithinLetters

	endValidate:
		inc bx
		jmp validateUsername

compareWithinNumbers:
	cmp dl,'9'
	jg validateCapitalLetter

compareWithinLetters:
	cmp dl,'Z'
	jg error
	jmp endValidate
;----------------------------------------

error:
	printStr nl
	printStr errorMsg
	jmp userMsg;

finalUserInput:
	printStr nl
	printStr userNameComfirmationMsg
	printStr userName+2
	jmp password

;------------------USER NAME---------------------------------------------------------------------------
;------------------PASSWORD----------------------------------------------------------------------------
password:
	printStr nl
	printStr inputPsMsg

	;-get input
	mov cx,15
	mov si,0

getInputPs:
	mov ah,07h
	int 21h
	mov inputPs[si],al
	inc si

	mov ah,02h
	mov dl,'@'
	int 21h
	loop getInputPs
	printStr nl

	mov si,0
;-----------password validation
chkStrlength:
	cmp si,15
	je checkNumIntAndLetters
	jne chkNum

chkNum:
	cmp inputPs[si],48
	jb errorPs

	cmp inputPs[si],57
	jbe addNum

chkLetters:
	cmp inputPs[si],'A'
	jb errorPs

	cmp inputPs[si],'Z'
	jbe nextPs

	cmp inputPs[si],'a'
	jb errorPs

	cmp inputPs[si],'z'
	jbe nextPs
	ja errorPs

addNum:
	inc nums
	jmp nextPs

lowLetters:
	inc lowerLetters
	jmp nextPs

upLetters:
	inc upperLetters
	jmp nextPs

checkNumIntAndLetters:
	cmp nums,0
	jne password
	cmp lowerLetters,0
	jne password
	cmp upperLetters,0
	jne password
	jmp finalMsg

nextPs:
	inc si
	jmp chkStrlength


errorPs:
	printStr nl
	printStr errorPsMsg
	printStr nl
	jmp password

finalMsg:
	printStr nl
	printStr finalPsMsg
	printStr inputPs
	jmp exit
;------------------PASSWORD-----------------------------------------------------------------------------------

exit:
	mov ah,04ch
	int 21h
main endp
end main

