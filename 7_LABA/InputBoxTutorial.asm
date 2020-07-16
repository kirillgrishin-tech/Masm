 .386
      .model flat, stdcall
      option casemap :none
;#########################################################################
      include \masm32\include\windows.inc;подключение библиотек
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
include Length.inc

;#### // Prototypes includes			

    .data;данные
	
		MsgBoxCaption    db "MASM32 Prog 2", 0
						 
		InputCaption     db "Ввод значений", 0
		InputBoxText     db "Пожалуйста, введите значение",0
            RegistInputError db "Вы ввели неправильное значение регистра", 13, 10
                             db "Повторить ввод?", 0
            Text             db "Текст: ",0
            Simv             db "Кол-во символов: ",0
            InputBoxRegistr  db "Пожалуйста, введите ув. регистра", 0
		ValueInputError  db "Вы не ввели значения", 13, 10
		                 db "Повторить ввод?",0
            
             OutputValue      db 100 dup (0)           
		 InputValue       db 1000 dup (0)
             Summa            db 100 dup (0)

		InputValueLength db 100 dup (0)
		MessageTemplate  db "Количество символов: ",0



;#########################################################################
    .code

start:
    mov EAX,0
    clear:;очистка регистра
     mov Summa[EAX],0
     mov OutputValue[EAX],0
     mov InputValue[EAX],0
     inc EAX
     cmp EAX, 101
     jb clear
	
	
	push	offset InputValue
	push	offset InputCaption
	push	offset InputBoxText
	call	InputBox
      test    EAX, EAX
	jz      InputErrorValue
      jmp lenre

      lenre:;вызов функции len
   push offset OutputValue
   push offset InputValue
   call len
   mov EAX, offset MessageTemplate
   mov EDX, 0
   
   asdf:;объединение двух строк(это первая чать)
   cmp byte ptr[EAX], 0
   jz uio
   mov BH, byte ptr[EAX]
   add Summa[EDX], BH
   inc EAX
   inc EDX
   jmp asdf


   uio:
     mov EAX,0
      
   puup:; это вторая
     cmp OutputValue[EAX],0
     jz vyvod
     mov BH, OutputValue[EAX]
     add Summa[EDX], BH
     inc EAX
     inc EDX
     jmp puup
   
   vyvod:; это вывод     
    push   MB_RETRYCANCEL + MB_ICONINFORMATION ; Параметр набора кнопок  a
    push   offset MsgBoxCaption ; Параметр "адрес заголовка"
    push   offset Summa ; Параметр "адрес текста сообщения"
    push   0                    ; Параметр "родительское окно" - NULL
    call   MessageBox           ; Вызов API-функции вывода сообщения на экран
   cmp    EAX, 4
   jz     start
   jmp    exit
  


InputErrorValue:;ошибка
  push   MB_YESNO + MB_ICONERROR ; Параметр набора кнопок
  push   offset MsgBoxCaption    ; Параметр "адрес заголовка"
  push   offset ValueInputError  ; Параметр "адрес текста сообщения"
  push   0                       ; Параметр "родительское окно" - NULL
  call   MessageBox              ; Вызов API-функции вывода сообщения на экран

  cmp    EAX, 6
  jz     start


exit:
  push   0                    ; Пустой параметр для функции выхода
  call   ExitProcess          ; Вызов API-функции выхода

end start
