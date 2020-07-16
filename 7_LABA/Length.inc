
 .code
 len proc value:DWORD, buff:DWORD ;value это входные данные, buff будет хранить в себе длну в строковом формвте 
	mov EDX,value
	mov ECX, 0
    Count:;считаем длину
    cmp byte ptr[EDX],0
    jz Lalka
    inc EDX
	inc ECX
    jmp Count
	
    ;отсюда начинается перевод ECX в строковый формат
	Lalka:;присваеваем переменным начальные условия. Ддину хранит регистр ECX
	   mov EDX, 0
       mov EAX, 1
       mov EBX, 10
	   mov value,0

    GOKOD:;считаем кол-во символов в ECX
      cmp ECX, EAX
      jb poi
	  inc value
      mul EBX
      jmp GOKOD
	  
	 poi:; сохраняем ECX в стэк и присваиваем ему buff
	  push ECX
	  mov ECX, buff
	  
	 mvzae: ;выделяемв buff место для 0 именно нулей, которые в таблице ASCII под номером 48 
	   cmp value,0
	   jz hahaha
	   mov byte ptr[ECX], 48
	   inc ECX
	   dec value
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



vyhod:
    ret
    len endp
