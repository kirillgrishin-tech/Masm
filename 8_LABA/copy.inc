
 .code
 copy proc value:DWORD, arg1:DWORD, arg2:DWORD
 mov EDX, arg1
 mov ECX, 0
 argu:
   cmp byte ptr[EDX],0
   jz next
   inc EDX
   inc ECX
   jmp argu
   
 next:
   push EDX
   push ECX
   mov EDX,0
   mov EAX,1
   mov EBX, 10
  
  asd:
   dec ECX
   cmp ECX,0
   jz fgh
   mul EBX
   jmp asd
 
  fgh:
   pop ECX
   pop EDX
   sub EDX,ECX
   mov ECX,EDX
   mov EBX, EAX
   mov EAX,0
   push EAX
   
  qwert:
	mov EAX,0
	mov AL, byte ptr[ECX]
	sub EAX, 48
	mul EBX
	push EAX
	mov EAX,EBX
	mov EBX,10
	div EBX
	mov EBX, EAX
	pop EAX
	pop EDX
	add EDX, EAX
	push EDX
	mov EDX,0
    inc ECX
	cmp byte ptr[ECX],0
	jz nextarg
	jmp qwert
 
 nextarg:
  mov EDX, arg2
  mov ECX, 0
 
 argu1:
   cmp byte ptr[EDX],0
   jz next1
   inc EDX
   inc ECX
   jmp argu1
   
 next1:
   push EDX
   push ECX
   mov EDX,0
   mov EAX,1
   mov EBX, 10
  
  asd1:
   dec ECX
   cmp ECX,0
   jz fgh1
   mul EBX
   jmp asd1
 
  fgh1:
   pop ECX
   pop EDX
   sub EDX,ECX
   mov ECX,EDX
   mov EBX, EAX
   mov arg1,0
   
  qwert1:
	mov EAX,0
	mov AL, byte ptr[ECX]
	sub EAX, 48
	mul EBX
	push EAX
	mov EAX,EBX
	mov EBX,10
	div EBX
	mov EBX, EAX
	pop EAX
	add arg1, EAX
	mov EDX,0
    inc ECX
	cmp byte ptr[ECX],0
	jz vyhod
	jmp qwert1
 
   vyhod:
  pop EBX
  mov EAX, value
  add EAX, EBX
  dec EAX
  mov EDX, EAX
  add EDX, arg1
  mov byte ptr[EDX],0
  ret
 copy endp
