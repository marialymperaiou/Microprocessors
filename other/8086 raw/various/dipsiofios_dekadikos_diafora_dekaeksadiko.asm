INCLUDE macro.asm
    
ORG 100H

.STACK
    DW   128  DUP(?)       

.DATA                                
    MSG DB 0DH,0AH,"DOSE TOYS ARITHMOYS: ",'$'
    SPACE DB " ",'$'
    ARNITIKO DB 0DH,0AH,"DIAFORA=- ",'$' 
    THETIKO DB 0DH,0AH,"DIAFORA=",'$'
    NEWLINE DB 0AH, 0DH, '$'
	
.CODE
	JMP START
	
START:      
   PRINT_STR MSG
   MOV DX,0
   MOV CX,2
  
ADDR1:     
    MOV AX,10
    MUL DX
    MOV DX,AX
    CALL READ_DEC
    MOV AH,0
    ADD DX,AX   
    MOV AX,10
    MUL DX
    MOV DX,AX
    CALL READ_DEC
    MOV AH,0
    ADD DX,AX
   ; LOOP ADDR1
    
    MOV BX,DX               ; O 1os ston BX
   
    ;CALL PRINT_DEC


   MOV DX,0
   MOV CX,2
  
ADDR2: 
    PRINT_STR SPACE    
    MOV AX,10
    MUL DX
    MOV DX,AX
    CALL READ_DEC
    MOV AH,0
    ADD DX,AX   
    MOV AX,10
    MUL DX
    MOV DX,AX
    CALL READ_DEC
    MOV AH,0
    ADD DX,AX
    
    MOV CX,DX               ; O 2os ston CX
   
    ;CALL PRINT_DEC
WAIT_FOR_ENTER:
    READ					; ??aµ??? ??a t? p?t?µa t?? ENTER
    CMP AL,'K'
    JE EXIT 
    SUB AL,30H
    CMP AL,221
    JE PRAKSI
    JMP WAIT_FOR_ENTER     	; ?pa?????? ??a ?s? de? d????µe ENTER                            
     
PRAKSI:  
     CMP BX,CX
     JG PRWTOS
     MOV DX,CX
     SUB DX,BX
     PRINT_STR ARNITIKO
     CALL PRINT_HEX
     JMP EXIT
  
PRWTOS:
    MOV DX,BX
    SUB DX,CX
    PRINT_STR THETIKO
    CALL PRINT_HEX
    
     

EXIT:
    EXIT

;typonei dekadiko

READ_DEC PROC NEAR
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
READ_DEC ENDP    




;!!!! AYTO POY THELW NA TYPWSW STON DL!!!!!!!

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