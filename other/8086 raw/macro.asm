PRINT MACRO CHAR
        PUSH DX
        PUSH AX
        MOV AH,2
        MOV DL,CHAR
        INT 21H
        POP AX
        POP DX
        PRINT ENDM    

READ MACRO
    MOV AH,8
    INT 21H
ENDM
                     
                     
PRINT_STR MACRO MESSAGE
    PUSH DX
    PUSH AX
    MOV AH,9
    MOV DX,OFFSET MESSAGE
    INT 21H
    POP AX
    POP DX
ENDM

EXIT MACRO
	MOV AX,4C00H
	INT 21H
ENDM 