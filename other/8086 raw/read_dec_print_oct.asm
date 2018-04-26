


                              ;diavazei 3 dekaeksadikous arithmous kai tous emfanizei 
INCLUDE macro.asm
 
STACK_SEG SEGMENT STACK
    DW 128 DUP(?)
ENDS
 
DATA_SEG SEGMENT
   
    IN_MSG DB 0AH,0DH, "GIVE A 2 DIGIT DECIMAL NUMBER: $"         
    MSG   DB "OVERFLOW $"
    MSG1    DB  0AH,0DH,'SUM :$' 
    MSG3    DB  0AH,0DH,'MUL:$'
   ; IN_MSG1 DB "ATHR: $"
    LINE DB 0AH,0DH,"$"      
  ;  NUM_TABLE DB 16 DUP(?)
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
    CALL DEC_IN   ;DX<-0 0 0 0 0 0 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0
    PRINT_STR LINE    
    MOV DL,BL
    ADD DL,CL     
    PRINT_STR MSG1
    CALL PRINT_OCT
   ; CALL PRINT_HEX    ;mexri to 63     
    MOV AL,BL
    MUL CL
    MOV DL,AL
    CMP DL,3FH
    JG OVER 
    PRINT_STR MSG3
    CALL PRINT_OCT
    JMP KSANA
   
OVER:  
   PRINT_STR MSG     
  
  
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
    MOV BL,AL       ;O CL Ton min
         ;O BL ton max
IGNORE1:  
    READ           ;Read changes AX: puts input in AL and gives DOS function code with AH
    CMP AL,30H
    JL IGNORE1
    CMP AL,39H
    JG IGNORE1
 PASS1:
    PRINT AL  
    SUB AL,30H
   MOV CL,AL
   
  
 EPISTROFI:
    RET               ;Finally we have the number in DX
DEC_IN ENDP
  

 
;!!!!!APO TON AL !!!!!

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


    
