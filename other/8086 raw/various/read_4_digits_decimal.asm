;diavazei 3 dekaeksadikous arithmous kai tous emfanizei 
INCLUDE macro.asm
 
STACK_SEG SEGMENT STACK
    DW 128 DUP(?)
ENDS
 
DATA_SEG SEGMENT
   
    IN_MSG DB "GIVE A 4 DIGIT DECIMAL NUMBER: $"
    ;OUT_MSG DB "THE DECIMAL NOTATION IS: $"
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
    PRINT_STRING IN_MSG
    CALL DEC_IN   ;DX<-0 0 0 0 0 0 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0
    PRINT_STRING LINE   
    PRINT CL
  
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
    MOV BL,AL       ;We have read withouth echo
IGNORE1:  
    READ           ;Read changes AX: puts input in AL and gives DOS function code with AH
    CMP AL,30H
    JL IGNORE1
    CMP AL,39H
    JG IGNORE1
    
    PASS1:
    PRINT AL 
   
     ;Add NEW digit
IGNORE2:  
    READ           ;Read changes AX: puts input in AL and gives DOS function code with AH
    CMP AL,30H
    JL IGNORE2
    CMP AL,39H
    JG IGNORE2 
    
    PASS2:
    PRINT AL
    MOV DL,AL        ;We have read withouth echo
    
 IGNORE3:  
    READ           ;Read changes AX: puts input in AL and gives DOS function code with AH
    CMP AL,30H
    JL IGNORE3
    CMP AL,39H
    JG IGNORE3
    
    PASS3:
    PRINT AL        ;We have read withouth echo   
    
    ;       LOOP IGNORE
    RET               ;Finally we have the number in DX
DEC_IN ENDP
  
  
