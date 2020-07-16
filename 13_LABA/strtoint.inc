.code
strtoint proc arg1:DWORD, buff:DWORD
   push buff
   push arg1
   mov buff,0
   mov ECX,arg1
   Count:
	inc ECX
	cmp byte ptr[ECX],0
    jne Count
	
	dec ECX
    mov EBX,10
	push EBX
	mov EBX,1
	
	string:
	sub byte ptr[ECX],48
	mov EAX,0
	push ECX
	mov CL,byte ptr[ECX]
	mov AL, CL
	mul EBX
    add buff,EAX
	pop ECX
	add byte ptr[ECX],48
	mov EAX, EBX
	pop EBX
	mul EBX
	push EBX
	mov EBX,EAX
	cmp ECX,arg1
	jz vyhod
    dec ECX
	jmp string


vyhod:
 pop EBX
 pop arg1
 mov ECX, buff
 pop buff
 mov EAX, buff
 add [EAX],ECX
ret
strtoint endp