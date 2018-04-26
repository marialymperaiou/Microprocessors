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
 

 
CODE_SEG ENDS
 
END MAIN
