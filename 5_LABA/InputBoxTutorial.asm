 .386; архитектура процессора 
      .model flat, stdcall
      option casemap :none
;######################################################################### это подключение библиотек
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

;#### // Prototypes includes			

    .data;Здесь записываются данные
	
		MsgBoxCaption    db "MASM32 Prog 2", 0 ;в конце данных нужно записывать 0 это указатель на то что строка закончилась 
						 
		InputCaption     db "Ввод значений", 0
		InputBoxText     db "Пожалуйста, введите значение",0
            RegistInputError db "Вы ввели неправильное значение регистра", 10; 10 в конце обозначает перенос на новую строку в ASCII это newline
                             db "Повторить ввод?", 0
            Text             db "Текст: ",0
            Simv             db "Кол-во символов: ",0
            InputBoxRegistr  db "Пожалуйста, введите ув. регистра", 0
		ValueInputError  db "Вы не ввели значения", 13; 13 в конце тоже обозначает перенос в таблице ASCII это ENTER
		                 db "Повторить ввод?",0
            
        OutputValue      db 100 dup (0);так записываются массивы. Это 4 массива длинной 100 и состоящие из одних нулей: 0000000000000000000000000             
		InputValue       db 100 dup (0)
            InputValueReg    db 1 dup (0)
            InputValueReg1    db 1 dup (0)
		InputValueLength db 100 dup (0)



;#########################################################################
    .code

start:

	mov EDX,2
	
	; Вызов InputBox
	; то что вы видите внизу равноценно этому макросу: invoke InputBox, ADDR InputBoxText, ADDR InputCaption, ADDR InputValue
    ; макросы это штуки которые экономят наше время
	; внизу мы вводим текст в котором будем увеличивать регистр 

	push	offset InputValue; место куда мы помистим введенный текст
	push	offset InputCaption; это название лэйбла
	push	offset InputBoxText; это заголовок. Стоит заметить, что мы закидываем данные в функцию не целиком, а даем адрес (offset). Он указывает адрес первого символа, и функции этого достаточно
	call	InputBox; ведь в конце функция всеравно упрется  в указатель, это всегда 0
    cmp EAX, 0
	jz  InputErrorValue
REG:
    InputRegistr: ;так мы указываем процедуры Название_процедуры:    
      ; тоже самое, вызываем Inputbox только уже для буквы
        push	offset InputValueReg
	  push	offset InputCaption
	  push	offset InputBoxRegistr
	  call	InputBox
      cmp EAX, 0
      jz InputErrorRegistr
      cmp EAX,1
      ja InputErrorRegistr
      cmp InputValueReg[0], 96
      ja Registr
      jmp InputErrorRegistr



      ;по факту cmp это if, единственное отличие cmp от if это разные флаги.
      ; cmp Выражение1, выражение2 == if <выражение1> ? <выражения2> then
      ; если в Lazarus мы ставим знаки больше, меньше, равно, то в Ассемблере мы ставим разные флаги. Внизу они представленны
      ; Ассемблер        Lazarus
      ;jmp <метка>  =      goto <метка> 
      ;jz <метка>   =      if <выражение>=(выражение2) then goto <метка> 
      ;ja <метка>   =      if <выражение1> больше <выражения2> goto <метка> 
      ;jb <метка>   =      if <выр.1> меньше  <выр.2> goto <метка> 
      

Registr:
  cmp byte ptr[InputValueReg], 123; byte ptr[адрес] это сравнение символа с 123. В ассемблере все символы хранятся в цифрах (смотри таблицу ASCII) 
  jb Wert 
  jmp InputErrorRegistr


 Wert:
  mov BH, byte ptr[InputValueReg]; присвоить BH символ по адресу InputValueReg
  mov ECX, 0
  
  poisk:
   cmp InputValue[ECX],0
   jz vyvod
   cmp InputValue[ECX], BH
   jz Upreg
   inc ECX
   jmp poisk

Upreg:
    sub InputValue[ECX], 32
    inc ECX
    jmp poisk
    
  vyvod:
   dec edx
   cmp EDX,1
   jz REG
   push   MB_RETRYCANCEL + MB_ICONINFORMATION ; Параметр набора кнопок
   push   offset MsgBoxCaption ; Параметр "адрес заголовка"
   push   offset InputValue   ; Параметр "адрес текста сообщения"
   push   0                    ; Параметр "родительское окно" - NULL
   call   MessageBox           ; Вызов API-функции вывода сообщения на экран

   cmp    EAX, 4
   jz     start
   jmp    exit
  
InputErrorRegistr:; тоже название процедуры когда мы пишем jmp InputErrorRegistr или jz,ja,jb InputErrorRegistr мы перепрыгиваем на эту процедуру
  push   MB_YESNO + MB_ICONERROR ; Параметр набора кнопок
  push   offset MsgBoxCaption    ; Параметр "адрес заголовка"
  push   offset RegistInputError ; Параметр "адрес текста сообщения"
  push   0                       ; Параметр "родительское окно" - NULL
  call   MessageBox              ; Вызов API-функции вывода сообщения на экран
  cmp EAX, 6
  jz  InputRegistr



InputErrorValue:
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
