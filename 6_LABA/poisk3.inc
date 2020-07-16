.code
  poisk3 proc value:dword, arg1:dword
  mov ECX, value
  mov EDX, arg1
  mov EBX, arg1
  add EBX, 5
  push EDX
  dec ECX
  
  naz:
   pop EDX
   push EDX
   inc ECX
   cmp byte ptr[ECX],0
   jz exitp
  
  pereb:
   mov EAX,0
   mov AH, byte ptr[EDX]
   cmp byte ptr[ECX], AH
   jz save
   inc EDX
   cmp byte ptr[EDX], 0
   jz naz
   jmp pereb
   
   save:
    mov byte ptr[EBX], AH
	inc EBX
	inc EDX
	cmp byte ptr[EDX], 0
    jz naz
	jmp pereb
	
  exitp:
  mov EAX, arg1
  add EAX,5
   ret
  poisk3 endp