;diavazei 3 dekaeksadikous arithmous kai tous emfanizei 
INCLUDE macro.asm
 
STACK_SEG SEGMENT STACK
    DW 128 DUP(?)
ENDS
 
DATA_SEG SEGMENT
   
    IN_MSG DB 0DH,0AH, "GIVE A  DECIMAL NUMBER: $"
    ;OUT_MSG DB "THE DECIMAL NOTATION IS: $"
    IN_MSG_SEC DB 0DH,0AH,"GIVE THE SECOND NUMBER: $" 
    ADDITION DB 0DH,0AH,"ATHR= ",'$'           
    SUBI DB 0DH,0AH,"DIAF=",'$' 
    SUBINEG DB 0DH,0AH,"DIAF=-",'$'
    NEWLINE DB 0AH, 0DH, '$'
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
    MOV BL,AL
    PRINT_STRING IN_MSG_SEC
    CALL DEC_IN
    MOV CL,AL
    
WAIT_FOR_ENTER:
    READ					
    SUB AL,30H
    CMP AL,221
    JE PRAKSI
    JMP WAIT_FOR_ENTER    
PRAKSI:
   
   
   MOV AL,CL
   ADD AL,BL ;O AL EXEI TO ATHROISMA    
   PRINT_STRING ADDITION             
 
   MOV DL,AL
   CALL PRINT_HEX
   CMP BL,CL
   JGE BLMAX
   PRINT_STRING SUBINEG
   SUB CL,BL
   MOV DL,CL
   CALL PRINT_HEX
   JMP KSANA
   
BLMAX:   
   PRINT_STRING SUBI
   SUB BL,CL
   MOV DL,BL
   CALL PRINT_HEX

KSANA:
    JMP START   
EXODOS:
    EXIT
MAIN ENDP   

DEC_IN PROC NEAR
  ;  MOV DX,0
  ;  MOV BH,0
  ;  MOV CX,4
IGNORE:  
    READ           ;Read changes AX: puts input in AL and gives DOS function code with AH
    CMP AL,30H
    JL IGNORE
    CMP AL,39H
    JG IGNORE       ;If we pass we have accepted value
    
    PASS0: 
    
    PRINT AL    
    SUB AL,30H
    RET
DEC_IN ENDP
  

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