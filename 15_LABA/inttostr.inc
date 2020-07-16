.code
inttostr proc arg1:DWORD, buff:DWORD
   Lalka:
       push arg1
	   mov EDX, arg1
	   mov ECX, 0
       add ECX, [EDX]
	   cmp ECX,0
	   jz Vyhod0
	   mov EDX, 0
       mov EAX, 1
       mov EBX, 10
	   mov arg1,0

 GOKOD:;считаем кол-во символов в ECX
      cmp ECX, EAX
      jb poi
	  inc arg1
      mul EBX
      jmp GOKOD
	  
	 poi:; сохраняем ECX в стэк и присваиваем ему buff
	  push ECX
	  mov ECX, buff
	  
	 mvzae: ;выделяемв buff место для 0 именно нулей, которые в таблице ASCII под номером 48 
	   cmp arg1,0
	   jz hahaha
	   mov byte ptr[ECX], 48
	   inc ECX
	   dec arg1
	   jmp mvzae

    hahaha:;прибавляем к первому символ первое число регистра ECX
	 pop ECX 
     div EBX
     mov EBX, EAX
     mov EAX, ECX
	 mov EDX,0
     div EBX
	 mov ECX, buff
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
     jz vyhod
	
	qwer:;прибавляем ко всем остальным числа регистра ECX
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
     jz vyhod
     jmp qwer
	 
 Vyhod0:
 mov ECX,buff
 mov byte ptr[ECX],48

 vyhod:
 pop arg1
ret
inttostr endp