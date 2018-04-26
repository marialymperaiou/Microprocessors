INCLUDE macros.asm
    
ORG 100H

.STACK
    DW   128  DUP(?)       

.DATA                                
    MSG DB 0DH,0AH,"DOSE TOYS ARITHMOYS: ",'$'
    SPACE DB " ",'$'
    ADDITION DB 0DH,0AH,"A=",'$' 
    MULTIPLICATION DB 0DH,0AH,"M=",'$'
    NEWLINE DB 0AH, 0DH, '$'
	
.CODE
	JMP START
	
START:      
    PRINT_STR MSG
    MOV CX, 05H				; 3 επαναλήψεις
DIGITS:
    CALL HEX_KEYB			; Διάβασμα των 3 ψηφίων
	PUSH AX					; και τοποθέτησή τους στη στοίβα
	LOOP DIGITS       
	         
	POP AX   
	MOV BX,AX 				; Τοποθέτηση του πρώτου στον BX
	MOV BH,0        
    POP AX   
	MOV CX,AX     			; Τοποθέτηση του δεύτερου στον CX
	MOV CH,0           
	POP AX 
	MOV DX,AX 				; Τοποθέτηση του τρίτου στον DX 
	MOV DH,0
	PUSH AX					; Ξανά στη στοίβα ο τρίτος (λίγοι καταχωρητές)
	
	MOV AX,CX
	ADD AX,BX
	ADD AX,DX 				; Υπολογισμός αθροίσματος στον AX
	MOV DX,AX 				; και μετά τοποθέτηση στον DX
     
	POP AX					; Ανάκτηση του 3ου αριθμού
	MOV BH,0
	MUL BL 					; Υπολογισμός πολλαπλασιασμού στον AX
	MOV CH,0
	MUL CL
	MOV CX,AX				; και μετά τοποθέτηση στον CX

WAIT_FOR_ENTER:
    READ					; Αναμονή για το πάτημα του ENTER
    CMP AL,'m'
    JE EXIT 
    SUB AL,30H
    CMP AL,221
    JE PRINTING
    JMP WAIT_FOR_ENTER     	; Επανάληψη για όσο δεν δίνουμε ENTER       
	
PRINTING:	
	PRINT_STR ADDITION      ; Εκτύπωση πρόσθεσης         
    CALL PRINT_HEX
    PRINT_STR MULTIPLICATION ; Εκτύπωση πολλαπλασιασμού  
    MOV DX,CX
    CALL PRINT_HEX 
    PRINT_STR NEWLINE		; Νέα γραμμή κι επανάληψη
    JMP START
TERMIN:
    RET   	
        
 ; Ρουτίνα που εκτυπώνει έναν αριθμό σε δεκαεξαδικό σύστημα       
PRINT_HEX PROC
	PUSH AX				; Αποθήκευση των καταχωρητών
	MOV AX, DX
	PUSH DX
	MOV DX, AX
    
    PUSH CX
	MOV CX, 04H 		; Το loop θα επαναληφθεί 4 φορές
HEXAL:
	SHR AX,12			; Απομόνωση των bit που θέλουμε (απ'το msb στο lsb)
	AND AX,0FH
	CALL CHECK_HEX 		; τυπώνεται ο ascii για αυτά 4 bit 
	SHL DX,4			; Ολίσθηση του αριθμού
	MOV AX,DX
	LOOP HEXAL
         
    POP CX
	POP DX				; Επαναφορά των καταχωρητών
	POP AX
	RET
PRINT_HEX ENDP	
	     
        
; Ρουτίνα που τυπώνει 4bit δυαδικού στο αντίστοιχο 16δικό
CHECK_HEX PROC
	CMP AL,9
	JLE ADR1
	ADD AL,37H				; αν είναι Α-F
	JMP ADR2
ADR1:
	ADD AL,'0'				; αν είναι 0-9
ADR2:        
	PRINT AL    
	RET
CHECK_HEX ENDP        
        
        
HEX_KEYB PROC
READSTART:
    CMP CX,03H
    JE SPACE1
    READ
	CMP AL,'M'				; Αν πατηθεί το Τ, τερματίζουμε
	JE EXIT
	CMP AL,'0'
	JL READSTART 			; Δέχεται νούμερα από 0-F
	CMP AL,'F'
	JG READSTART 
	PRINT AL				; Εμφάνιση του ψηφίου που διαβάζεται στην οθόνη
	CMP AL,'9' 				; Αν είναι Α-F
	JG NEXT2
	MOV AH,0
	SUB AX,'0'				; Μετατροπή από ASCII χαρακτήρα σε δεκαεξαδικό ψηφίο
	RET          
NEXT2:    					; Αν είναι 0-9
    MOV AH,0
	SUB AX,'A'				; Μετατροπή από ASCII χαρακτήρα σε δεκαεξαδικό ψηφίο
	ADD AX,10
    RET
SPACE1:
    PRINT_STR SPACE
    RET
EXIT: EXIT
HEX_KEYB ENDP
	         