
include 'emu8086.inc'

org 100h 

Start:

call READ_DEC
mov bl,al 
mov ah,0Eh
int 10h
call READ_DEC
mov bh,al 
mov ah,0Eh
mov al,bh
int 10h
sub bl,48
sub bh,48
mov al,10
mul bl
mov bl,al
add bl,bh
mov cl,bl
call PTHIS
DB '=',0
call PRINT_HEX
call PTHIS
DB '=',0  
mov bl,cl
call PRINT_OCT
call PTHIS
DB '=',0 
mov bl,cl
call PRINT_BIN
call PTHIS
DB 13,10,0
jmp start


READ_DEC: 
    mov ah,08h 
    int 21h 
    cmp al, 48
    jc READ_DEC
    cmp al, 58
    jnc READ_DEC
    ret
         
PRINT_HEX: 
    mov ah,0Eh
    mov al,bl
    and bl,0Fh
    and al,0F0h
    ror al,4
    cmp al,10
    jc number
    add al,55
    int 10h
    
next:
    cmp bl,10
    jc number2
    mov al,bl 
    add al,55
    int 10h
    jmp telos
    
number:
    add al,48
    int 10h
    jmp next
    
number2:
    mov al,bl
    add al,48
    int 10h
 
telos:
    ret

PRINT_OCT:
    mov dx,0000h
ekato:
    cmp bl,64
    jc deka
    inc dh
    sub bl,64
    jmp ekato
deka:
    cmp bl,8
    jc monades
    inc dl
    sub bl,8
    jmp deka
monades:
    add dh,48
    add dl,48
    add bl,48
    mov ah,0Eh
    mov al,dh
    int 10h
    mov al,dl
    int 10h
    mov al,bl
    int 10h
    ret


PRINT_BIN:
    mov ah,0Eh
    mov dl,8
loop1:
    rol bl,1
    jc assos
    mov al,48
    int 10h
    dec dl
    jz telos2
    jmp loop1
assos:
    mov al,49
    int 10h
    dec dl
    jz telos2
    jmp loop1
telos2:
    ret    

DEFINE_PTHIS
END