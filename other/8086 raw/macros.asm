PRINT MACRO CHAR 		;Εκτύπωση χαρακτήρα που βρίσκεται στον AL στην οθόνη	
PUSH DX	
PUSH AX	
MOV AH,2	
MOV DL,CHAR	
INT 21H	
POP AX	
POP DX
ENDM

PRINT_STR MACRO MESSAGE 	;Εκτύπωση μηνύματος string	
PUSH DX	
PUSH AX	
MOV AH,9	
MOV DX,OFFSET MESSAGE	
INT 21H	
POP AX	
POP DX
ENDM

READ MACRO 			;Ανάγνωση χαρακτήρα από το πληκτρολόγιο και αποθήκευση στον AL	
MOV AH,8	
INT 21H
ENDM

EXIT MACRO	
MOV AX,4C00H	
INT 21H
ENDM