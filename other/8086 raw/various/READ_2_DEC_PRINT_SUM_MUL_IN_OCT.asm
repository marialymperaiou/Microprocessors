INCLUDE macro.asm

STACK_SEG SEGMENT STACK
    DW 128 DUP(?)
ENDS
 
DATA_SEG SEGMENT
    IN_MSG DB 0AH,0DH, "GIVE 2 DEC DIGITS: $"     
    MSG2 DB "OVERFLOW $"
    MSG1    DB  0AH,0DH,'SUM :$' 
    MSG3    DB  0AH,0DH,'MUL:$'
   ; OUT_MSG DB "THE DECIMAL NOTATION IS: $"
    LINE DB 0AH,0DH,"$"
ENDS
 
CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG,SS:STACK_SEG,DS:DATA_SEG,ES:DATA_SEG
MAIN PROC FAR
    ;SET SEGMENT REGISTERS
    MOV AX,DATA_SEG
    MOV DS,AX
    MOV ES,AX
;=-=-=-=-==-=-=-=-=-=-=-CODE-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=
START:   
    
    PRINT_STRING IN_MSG
    CALL DEC_IN 
    PUSH AX
    CALL DEC_IN   
    PUSH AX
    POP AX 
    MOV BL,AL
    MOV DL,AL
    POP AX
    MOV CL,AL
    ADD DL,AL
    PRINT_STRING MSG1
    CALL PRINT_OCT 
    PRINT_STRING MSG3 
    MOV AL,BL
    MUL CL
    CMP AL,40H
    JG OVER
    MOV DL,AL  
    
    CALL PRINT_OCT
    JMP KSANA    
OVER:
    PRINT_STRING MSG2    

KSANA: 
    JMP START   
    
EXODOS: 
    PRINT AL
    EXIT
MAIN ENDP
    
    
    
DEC_IN PROC NEAR

IGNORE:  
    READ  
    CMP AL,'Q'
    JE EXODOS         ;Read changes AX: puts input in AL and gives DOS function code with AH
    CMP AL,30H
    JL IGNORE
    CMP AL,39H
    JG IGNORE       ;If we pass we have accepted value
    
    PASS0:
    PRINT AL 
    SUB AL,30H
    RET
DEC_IN ENDP     



PRINT_OCT PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AX,DX   ;Put number in AX
    MOV BX,8   ;Put the divisor in BX
    MOV CX,0    ;Counts the number of decimal digits
AGAIN2:
    MOV DX,0
    DIV BX      ;quotient in AX and remainder in DX
    PUSH DX
    INC CX
    CMP AX,0    ;Check if quotient = 0 (all digits stored in stack)
    JNE AGAIN2
PRINT_LOOP2:
    POP DX
    CMP DL,9    ;i know that in char is something between 00000000 and 00001111
    JBE DEC_DEC2    ;if A<=9 jump to DEC_DEC
    ADD DL,07H;we add total 37H, if we have something A-F
DEC_DEC2:
    ADD DX,30H
    MOV AH,02H
    INT 21H        ;To print the DL

    CMP CX,04H
    JL PPAASSPP2
    PRINT 44 
PPAASSPP2:
    LOOP PRINT_LOOP2
TELOS:
    POP DX
    POP CX
    POP BX
    POP AX   
    RET
PRINT_OCT ENDP
