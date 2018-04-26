                                     INCLUDE macros.txt
 
STACK_SEG SEGMENT STACK
    DW 128 DUP(?)
ENDS
 
DATA_SEG SEGMENT

    NUM1 DW 0
    NUM2 DW 0 
    
    PROSIMO DB "+$"
    ISON    DB "SUM=$"
    LINE DB 0AH,0DH,"$"
;variables here


ENDS
 
CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG,SS:STACK_SEG,DS:DATA_SEG,ES:DATA_SEG
MAIN PROC FAR
    MOV AX,DATA_SEG
    MOV DS,AX
    MOV ES,AX
START:
    CALL READ_2_DIG
    MOV AH,0
    MOV [NUM1],AX 
                                    
IGNR:                               ;WAIT '+' OR 'A'
    READ
    CMP AL,'A'
    JNE NEXT1
    EXIT
NEXT1:
    CMP AL,'+'
    JNE IGNR
    
    CALL READ_2_DIG
    MOV AH,0
    MOV [NUM2],AX  
    
IGNR2:              ;WAIT ENTER OR A
    READ     
    CMP AL,'A'
    JNE NEXT2
    EXIT
NEXT2:
    CMP AL,0DH
    JNE IGNR2     
    
    MOV DX,[NUM1]                ;PRINT INPUT
    CALL PRINT_OCT                
    PRINT_STRING PROSIMO
    MOV DX,[NUM2]
    CALL PRINT_OCT
    PRINT_STRING LINE
    PRINT_STRING ISON
    
    MOV AX,[NUM1]
    MOV DX,[NUM2]
    ADD DX,AX
    CALL PRINT_HEX 
    PRINT_STRING LINE
    JMP START       
    
MAIN ENDP     


READ_2_DIG PROC NEAR
    PUSH DX
    CALL READ_DIG
    SHL AL,3
    MOV DH,AL
    CALL READ_DIG
    ADD AL,DH
    POP DX
    RET    
    
READ_2_DIG ENDP
             
             
READ_DIG PROC NEAR

IGNORE:
    CMP AL,'A'
    JNE CONT
    EXIT
CONT:
    READ
    CMP AL,'0'
    JL IGNORE
    CMP AL,'8'
    JG IGNORE
    SUB AL, 30H
    RET
    
READ_DIG ENDP



 
PRINT_HEX PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AX,DX   ;Put number in AX
    MOV BX,16   ;Put the divisor in BX
    MOV CX,0    ;Counts the number of decimal digits
AGAIN:
    MOV DX,0
    DIV BX      ;quotient in AX and remainder in DX
    PUSH DX
    INC CX
    CMP AX,0    ;Check if quotient = 0 (all digits stored in stack)
    JNE AGAIN
PRINT_LOOP:
    POP DX
    CMP DL,9    ;i know that in char is something between 00000000 and 00001111
    JBE DEC_DEC    ;if A<=9 jump to DEC_DEC
    ADD DL,07H;we add total 37H, if we have something A-F
DEC_DEC:
    ADD DX,30H
    MOV AH,02H
    INT 21H        ;To print the DL

    CMP CX,04H
    JL PPAASSPP:
    PRINT 44 
    PPAASSPP:
    LOOP PRINT_LOOP
    POP DX
    POP CX
    POP BX
    POP AX   
    RET
PRINT_HEX ENDP

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
    POP DX
    POP CX
    POP BX
    POP AX   
    RET
PRINT_OCT ENDP


CODE_SEG ENDS
 
END MAIN 