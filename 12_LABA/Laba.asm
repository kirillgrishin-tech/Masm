;Шаблон программы в MASM32
;---------------------------------------------------------------------------
.386                  ; архитектура процессора
      .model flat, stdcall
      option casemap :none
;#########################################################################
      include \masm32\include\windows.inc
      include \masm32\include\user32.inc
      include \masm32\include\kernel32.inc
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\kernel32.lib
      include inttostr.inc
      include CONCAT.inc
;#########################################################################

.data  
   
   data SYSTEMTIME <>
   buffer dw 0,0
   colon db ":",0
   strhours db 100 dup(0)
   strminutes db 10 dup(0)
   Text   db "Текущее время: ",0
   MsgBoxCaption db "Время",0
   Summa         db 100 dup(0)

;#########################################################################

.code                  ; секция кода

start:                 ; метка начала
mov EAX,0
clear:
mov Summa[EAX],0
inc EAX
cmp EAX,101
jb clear

 push offset data
 call GetLocalTime
 
 mov buffer[0],0
 mov CX, data.wHour
 add buffer[0], CX
 
  push offset strhours
  push offset buffer
  call inttostr
  
 mov buffer[0],0
 mov CX, data.wMinute
 add buffer[0], CX
  cmp buffer[0],10
  jb minmin
  push offset strminutes
  push offset buffer
  call inttostr
  jmp Vyvod

  minmin:
  mov strminutes[0],48
  push offset [strminutes+1]
  push offset buffer
  call inttostr
  
  Vyvod:
 push offset Summa
 push offset strminutes
 push offset colon
 push offset strhours
 push offset Text
 call CONCAT
    push   MB_RETRYCANCEL ; Параметр набора кнопок  a
    push   offset MsgBoxCaption ; Параметр "адрес заголовка"
    push   offset Summa ; Параметр "адрес текста сообщения"
    push   0                    ; Параметр "родительское окно" - NULL
    call   MessageBox           ; Вызов API-функции вывода сообщения на экран

cmp  EAX, 4
   jz     start
   jmp    exit

exit:
  push   0                    ; Пустой параметр для функции выхода
  call   ExitProcess          ; Вызов API-функции выхода

end start              ; метка конца
;----------------------------------------------------------------------------
