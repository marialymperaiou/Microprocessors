INCLUDE macros.asm
    
ORG 100H

.STACK
    DW   128  DUP(?)       

.DATA                                
    MSG DB 0DH,0AH,"Dose 6 Arithmous: ",'$'
    PROSIMO DB "-",'$' 
    MULTIPLICATION DB 0DH,0AH,"M=",'$'
    NEWLINE DB 0AH, 0DH, '$'
	
.CODE
    JMP START                                   

START:
                                       
    PRINT_STR MSG
    MOV CX,0006H
    MOV DX,0000H
DIGIT:
    CALL READ_DIGIT
    LOOP DIGIT
    PRINT_STR NEWLINE
    
    CMP DL,DH
    JGE ARTIOIP
    PRINT_STR PROSIMO
    SUB DH,DL
    MOV AL,DH
    JMP PRNT
ARTIOIP:
    SUB DL,DH
    MOV AL,DL

PRNT:  
    ADD AL,30H
    PRINT AL
    JMP START

READ_DIGIT PROC 
PSIFIA:                              
    READ 
    CMP AL,'A'    
    JE EXIT
    CMP AL,31H
    JL PSIFIA
    CMP AL,39H
    JG PSIFIA
    PRINT AL
    SUB  AL , 30H
    SHR AL,1
    JC PERRITOS
    INC DL
    JMP END_
PERRITOS:
    INC DH    
END_:                            
    RET
READ_DIGIT ENDP      


EXIT: