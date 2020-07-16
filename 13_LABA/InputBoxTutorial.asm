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
include CONCAT.inc
include inttostr.inc
include strtoint.inc
include sqr.inc
;#### // Prototypes includes			

    .data

            qua              dw 0,0
	      InputValue       dw 1000 dup (0) 
	     	MsgBoxCaption    db "MASM32 Prog 2", 0			 
		InputCaption     db "Ввод значений", 0
            InputBoxText1    db "Пожалуйста, введите число",0

            RegistInputError db "Вы ввели неправильное значение поиска", 13, 10
                             db "Повторить ввод?", 0
	    	ValueInputError  db "Повторить ввод?",0
            JKL              db ": ",0
		Message          db "Квадрат числа ",0
            InputValuestr    db 1000 dup (0)             
            Summa            db 10000 dup (0)
		InputValueLength db 100 dup (0)



;#########################################################################
    .code

start:

mov EAX,0
    Clear:
     mov InputValue[EAX],0
     mov InputValuestr[EAX],0
     inc EAX
     cmp EAX, 1001
     jb Clear
     
  mov EAX,0
  clear:
     mov Summa[EAX],0
     inc EAX
     cmp EAX, 10001
     jb clear

     
  REG:
	push	offset InputValuestr
	push	offset InputCaption
	push	offset InputBoxText1
	call	InputBox
      cmp    EAX, 0
	jz     InputErrorValue

   
   vyvod:
    push offset InputValue
    push offset InputValuestr
    call strtoint

    push offset qua
    push offset InputValue
    call sqr

    push offset InputValue
    push offset qua
    call inttostr
    
    push offset Summa
    push offset InputValue
    push offset JKL
    push offset InputValuestr
    push offset Message
    call CONCAT
    
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
  jz     REG
  jmp exit


exit:
  push   0                    ; Пустой параметр для функции выхода
  call   ExitProcess          ; Вызов API-функции выхода

end start
