.code
 POS proc arg1:DWORD, value:DWORD
 mov EBX, arg1
 mov EAX,value
 mov EDX, 0
 mov ECX, 0
 Count:
    cmp byte ptr[EBX],0
    jz poig
    inc EDX
	inc EBX
    jmp Count
	
	poig:
	mov EBX, arg1
	push EDX
	
	poif:
	pop EDX
	push EDX
	mov EBX,arg1
	
 poi1:
  push EAX
  mov AL, byte ptr[EAX]
  cmp byte ptr[EBX], AL
  jz cont
  pop EAX
  inc EAX
  inc ECX  
  cmp byte ptr[EAX],0
  jz prevyhod
  jmp poi1
  
  cont:
   pop EAX
   inc EAX
   inc EBX
   inc ECX
   dec EDX
   cmp EDX,0
   jz suc
   cmp byte ptr[EAX],0
   jz prevyhod
   push EAX
   mov AL, byte ptr[EAX]
   cmp byte ptr[EBX], AL
   jz cont
   pop EAX
   cmp byte ptr[EBX], AL
   jne poif
  
 prevyhod:
   mov EAX,0
   jmp vyhod
   
 suc:
   pop EDX
   sub EDX, 1
   sub ECX,EDX
   
   Lalka:
	   mov EDX, 0
       mov EAX, 1
       mov EBX, 10
	   mov value,0

    GOKOD:
      cmp ECX, EAX
      jb poi
	  inc value
      mul EBX
      jmp GOKOD
	  
	 poi:
	  push ECX
	  mov ECX, arg1
	  
	 mvzae:
	   cmp value,0
	   jz hahaha
	   mov byte ptr[ECX], 48
	   inc ECX
	   dec value
	   jmp mvzae

    hahaha:
	 mov byte ptr[ECX], 0 
	 pop ECX 
     div EBX
     mov EBX, EAX
     mov EAX, ECX
	 mov EDX,0
     div EBX
	 mov ECX, arg1
     push EAX
	 push EDX
	 mov EDX,0
     mov EAX, EBX
     mov EBX, 10
     div EBX
     mov EBX,EAX
	 pop EDX
     pop EAX
	 add byte ptr[ECX], AL
     inc ECX
	 cmp EDX, 0
     jz vyhod1
	
	qwer:
     mov EAX, EDX
     mov EDX,0
     div EBX
     push EAX
     push EDX
	 mov EDX,0
     mov EAX, EBX
     mov EBX, 10
     mov EDX,0
     div EBX
     mov EBX,EAX
     pop EDX
     pop EAX
     mov byte ptr[ECX], 48
     add byte ptr[ECX], AL
     inc ECX
     cmp EDX, 0
     jz vyhod1
     jmp qwer
	 
 vyhod1:
  mov EAX,arg1
 
 vyhod:
  ret
 POS endp
