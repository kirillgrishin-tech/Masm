.code
 CONCAT proc arg1:DWORD, arg2:DWORD, arg3:DWORD, arg4:DWORD, arg5:DWORD
 mov EDX, arg1
 mov ECX, arg2
 mov EAX, arg3
 mov EBX, arg5
 
   Count1:
    cmp EDX,0
    jz preCount2
    cmp byte ptr[EDX],0
    jz preCount2
	push EDX
	mov DH, byte ptr[EDX]
	mov byte ptr[EBX], DH
	pop EDX
	inc EDX
	inc EBX
    jmp Count1
	
	preCount2:
	 mov EDX,arg4
	
	Count2:
    cmp ECX,0
    jz Count3
    cmp byte ptr[ECX],0
    jz Count3
	push ECX
	mov CH, byte ptr[ECX]
	mov byte ptr[EBX], CH
	pop ECX
	inc EBX
	inc ECX
    jmp Count2
	
	Count3:
	cmp EAX,0
    jz Count4
    cmp byte ptr[EAX],0
    jz Count4
	push EAX
	mov AH, byte ptr[EAX]
	mov byte ptr[EBX], AH
	pop EAX
	inc EBX
	inc EAX
    jmp Count3
	
	Count4:
	cmp EDX,0
    jz vyhod
    cmp byte ptr[EDX],0
    jz vyhod
	push EDX
	mov DH, byte ptr[EDX]
	mov byte ptr[EBX], DH
	pop EDX
	inc EBX
	inc EDX
    jmp Count4
	
	
	
 vyhod:
  ret
 CONCAT  endp
