include 'emu8086.inc'
org 100h
    
start:
    mov cl,20
    mov bx,1000
loop1:
    mov ah,08
    int 21h
    cmp al,61
    jz telos
    cmp al,13
    jz cont1
    cmp al,48
    jc loop1
    cmp al,58
    jc number
    cmp al,97
    jc loop1
    cmp al,123
    jnc loop1
    mov ah,0Eh
    int 10h
    sub al,32
    mov [bx],al
    inc bx
    dec cl
    jz cont1
    jmp loop1
    
number: 
    mov ah,0Eh
    int 10h
    mov [bx],al
    inc bx
    dec cl
    jz cont1
    jmp loop1
    
cont1:
    mov ch,20
    sub ch,cl
    CALL pthis
	DB 13, 10, 0
    mov ah,0Eh
    mov bx,1000
loop2:
    mov al,[bx]
    int 10h 
    inc bx
    dec ch
    jz cont2
    jmp loop2

cont2:
    CALL pthis
	DB 13, 10, 0
	jmp start

    
telos:  
    ret
    
 

DEFINE_PTHIS
END    