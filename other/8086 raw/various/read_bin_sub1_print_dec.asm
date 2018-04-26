INCLUDE macro.asm
 
STACK_SEG SEGMENT STACK
    DW 128 DUP(?)
ENDS
 

   
 
DATA_SEG SEGMENT
    PKEY DB "Press any key to restart or 'Q' to exit!..$"
    IN_MSG DB "GIVE A 4-BIT BINARY NUMBER: $"
    OUT_MSG DB "THE DECIMAL NOTATION IS: $"
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
    PRINT_STR IN_MSG
    CALL BIN_4BIT_IN   ;DX<-0 0 0 0 0 0 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0
    PRINT_STR LINE  
               ;Read changes AX: puts input in AL and gives DOS function code with AH
   
PRAKSI:
    READ   
    CMP AL,'q'
    JE EXODOS
    CMP AL,'Q'
    JE EXODOS          ;Read changes AX: puts input in AL and gives DOS function code with AH
    CMP AL,'E'
    JE PROSTHESI
    CMP AL,'A'
    JE AFAIRESI 
    JMP PRAKSI
PROSTHESI:      
    INC DX 
    JMP PRINT1 
AFAIRESI:
    DEC DX
PRINT1:    
    CALL PRINT_DEC

    JE EXODOS
    PRINT_STR LINE     

    JMP START
EXODOS:
    EXIT
MAIN ENDP
;-=-=-=-=-=-=-=-=-=-=-=-ROUTINES-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
BIN_4BIT_IN PROC NEAR
    MOV DX,0
    MOV CX,4       ;Needed for LOOP, 10 repetitions
IGNORE:
    READ            ;Read changes AX: puts input in AL and gives DOS function code with AH
    CMP AL,'q'
    JE EXODOS
    CMP AL,'Q'
    JE EXODOS
    CMP AL,30H
    JL IGNORE
    CMP AL,31H
    JG IGNORE       ;If we pass we have 0 or 1
    PRINT AL
    SUB AL,30H      ;AX<-00000000 0000000(0 or 1)
    MOV AH,0
    ROL DX,1
    ADD DX,AX
    LOOP IGNORE     ;loop for 10 times to import 10 bits
    RET
BIN_4BIT_IN ENDP
 
PRINT_DEC PROC NEAR
;    PUSH AX
;    PUSH BX
;    PUSH CX
;    PUSH DX
    MOV AX,DX   ;Put number in AX
    MOV BX,10   ;Put the divisor in BX
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
    ;CMP DL,9    ;i know that in char is something between 00000000 and 00001111
    ;JBE DEC_DEC    ;if A<=9 jump to DEC_DEC
    ;ADD DL,07H;we add total 37H, if we have something A-F
DEC_DEC:
    ADD DX,30H
    MOV AH,02H
    INT 21H        ;To print the DL
    ;PRINT DL
    CMP CX,04H
    JL PPAASSPP:
    PRINT 44 
    PPAASSPP:
    LOOP PRINT_LOOP
;    POP DX
;    POP CX
;    POP BX
;    POP AX   
    RET
PRINT_DEC ENDP
 
CODE_SEG ENDS  

 
END MAIN
