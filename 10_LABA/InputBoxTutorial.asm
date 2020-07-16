     .386
      .model flat, stdcall
      option casemap :none
;#########################################################################
      include \masm32\include\windows.inc
      include \masm32\include\user32.inc
      include \masm32\include\kernel32.inc
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\kernel32.lib
;#########################################################################

;#### User Library includes

includelib	InputBox.lib
			
;#### // User Library includes	

;#### Prototypes includes

include Prototypes.inc
include substr_pos.inc

;#### // Prototypes includes			

    .data
	
	     	MsgBoxCaption    db "MASM32 Prog 2", 0			 
		    InputCaption     db "Ввод значений", 0
		    InputBoxText     db "Пожалуйста, введите значение",0
            RegistInputError db "Вы ввели неправильное значение поиска", 13, 10
                             db "Повторить ввод?", 0
            Text             db "Текст: ",0
            Simv             db "Кол-во символов: ",0
            InputBoxRegistr  db "Пожалуйста, введите что ищете", 0
	    	ValueInputError      db "Повторить ввод?",0
            
            InputValue       db 100 dup (0)           
		    InputValuefir        db 100 dup (0)
            InputValuesec    db 100 dup (0)
            Summa            db 100 dup (0)

		InputValueLength db 100 dup (0)
		MessageTemplate  db "Кол-во подстрок в строке: ",0



;#########################################################################
    .code

start:

mov EAX,0
    fghj:
     mov Summa[EAX],0
     mov InputValuefir[EAX],0
     mov InputValuesec[EAX],0
     mov InputValue[EAX],0
     inc EAX
     cmp EAX, 101
     jb fghj
	
	push	offset InputValue
	push	offset InputCaption
	push	offset InputBoxText
	call	InputBox
      test    EAX, EAX
	jz      InputErrorValue

REG:
      push	offset InputValuefir
	push	offset InputCaption
	push	offset InputBoxRegistr
	call	InputBox
      cmp EAX, 0
      jz InputErrorRegistr

  Copyre:
   push offset InputValue
   push offset InputValuefir
   call substr_pos  
   cmp EAX, 0
   jz InputErrorValue        
   mov ECX, offset MessageTemplate
   mov EDX, 0
   
   asdf:
   cmp byte ptr[ECX], 0
   jz puup
   mov BH, byte ptr[ECX]
   add Summa[EDX], BH
   inc ECX
   inc EDX
   jmp asdf
      
   puup:
     cmp byte ptr[EAX],0
     jz vyvod
     mov BH, byte ptr[EAX]
     add Summa[EDX], BH
     inc EAX
     inc EDX
     jmp puup
   
   vyvod:       
    push   MB_RETRYCANCEL + MB_ICONINFORMATION ; Параметр набора кнопок  a
    push   offset MsgBoxCaption ; Параметр "адрес заголовка"
    push   offset Summa ; Параметр "адрес текста сообщения"
    push   0                    ; Параметр "родительское окно" - NULL
    call   MessageBox           ; Вызов API-функции вывода сообщения на экран
   cmp    EAX, 4
   jz     start
   jmp    exit
  

InputErrorValue:
  push   MB_YESNO + MB_ICONERROR ; Параметр набора кнопок
  push   offset MsgBoxCaption    ; Параметр "адрес заголовка"
  push   offset ValueInputError  ; Параметр "адрес текста сообщения"
  push   0                       ; Параметр "родительское окно" - NULL
  call   MessageBox              ; Вызов API-функции вывода сообщения на экран

  cmp    EAX, 6
  jz     start
  jmp exit

InputErrorRegistr:
  push   MB_YESNO + MB_ICONERROR
  push   offset MsgBoxCaption    
  push   offset RegistInputError 
  push   0                       
  call   MessageBox              
  cmp EAX, 6
  jz  REG
  jmp exit


exit:
  push   0                    ; Пустой параметр для функции выхода
  call   ExitProcess          ; Вызов API-функции выхода

end start
