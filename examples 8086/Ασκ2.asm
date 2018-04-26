include 'emu8086.inc'
org 100h 

Start:
    call PTHIS
    db 'x=',0
    mov cl,2
    mov bx,1000
loop1:
    mov ah,08h
    int 21h
    cmp al,48
    jc loop1
    cmp al,58
    jnc loop1
    mov ah,0Eh
    int 10h
    sub al,48
    mov [bx],al
    inc bx
    dec cl
    jnz loop1
    
cont:
    call PTHIS
    db ' y=',0

loop2:
    mov ah,08h
    int 21h
    cmp al,13
    jz cont2
    cmp al,48
    jc loop2
    cmp al,58
    jnc loop2
    mov ah,0Eh
    int 10h
    sub al,48
    mov [bx],al
    inc bx
    inc cl
    jnz loop2
      
cont2:
    cmp cl,2
    jnz error
    mov al,[1000]
    mov cl,10
    mul cl
    mov bl,al
    add bl,[1001]
    mov al,[1002]
    mul cl
    mov bh,al
    add bh,[1003]
    call PTHIS
    db 13,10,0
    call PTHIS
    db 'x+y=',0
    mov ch,bh
    add ch,bl
    mov cl,ch
    and ch,0F0h
    and cl,0Fh
    ror ch,4
    cmp ch,10
    jc number
    add ch,55
    mov al,ch
    mov ah,0Eh
    int 10h
cont3:
    cmp cl,10
    jc number2
    add cl,55
    mov al,cl
    int 10h
    jmp next
    
number:
    add ch,48
    mov al,ch
    mov ah,0Eh
    int 10h
    jmp cont3
    
number2:
    add cl,48
    mov al,cl
    int 10h
    
next:
    call PTHIS
    db ' x-y=',0
    cmp bl,bh
    jc arnitikos
    sub bl,bh
cont4:
    mov cl,bl
    and bl,0F0h
    and cl,0Fh
    ror bl,4
    cmp bl,10
    jc number3
    add bl,55
    mov ah,0Eh
    mov al,bl
    int 10h
cont5:
    cmp cl,10
    jc number4
    add cl,55
    mov al,cl
    int 10h
    jmp telos
    
arnitikos:
    call PTHIS
    db '-',0
    sub bh,bl
    mov bl,bh
    jmp cont4
    
number3:
    add bl,48
    mov ah,0Eh
    mov al,bl
    int 10h
    jmp cont5
    
number4:
    add cl,48
    mov al,cl
    int 10h
    jmp telos
    
error:
    call PTHIS
    db 13,10,'Error',0 
    call PTHIS
    db 13,10,0
    jmp start
    
telos:
    call PTHIS
    db 13,10,0
    jmp start
    
    
DEFINE_PTHIS
END
