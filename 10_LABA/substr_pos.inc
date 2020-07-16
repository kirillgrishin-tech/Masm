.code
 substr_pos proc arg1:DWORD, value:DWORD
   mov EBX, arg1
   mov EAX,arg1
   push EAX
   push EDX
   mov EDX, 0
   mov ECX, 0
 
   Count:
    cmp byte ptr[EBX],0
    jz poig
    inc EDX
	inc EBX
    jmp Count
	
	poig:
	mov EAX, arg1
	mov BH, byte ptr[EAX]
	mov EAX,value
	
 poi1:
  cmp byte ptr[EAX], BH
  jz contpred
  inc EAX
  cmp byte ptr[EAX],0
  jz precont
  jmp poi1
  
  contpred:
   push EAX
   push EDX
   inc EAX
   cmp byte ptr[EAX],0
   jz precont
   jmp poi1
   
  precont:
  pop EDX
  pop EAX
  mov EBX,0
  mov EBX,arg1
  jmp vbncont
  
  cont:
   pop EAX
   
  vbncont:
   cmp EAX,arg1
   jz Lalka
   inc EAX
   inc EBX
   dec EDX
   cmp EDX,0
   jz suc
   push EAX
   mov AL, byte ptr[EAX]
   cmp byte ptr[EBX], AL
   jz cont
   pop EAX
   cmp byte ptr[EAX],0
   jz precont
   cmp byte ptr[EBX], AL
   jne precont
   
   suc:
    inc ECX
    jmp precont
   
   Lalka:
       cmp ECX,0
       jz vyhod0
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
	 
 vyhod0:
  mov ECX, arg1
  mov byte ptr[ECX],48
  inc ECX
  mov byte ptr[ECX],0
  
 vyhod1:
  mov EAX,arg1
 
 vyhod:
  ret
 substr_pos endp
