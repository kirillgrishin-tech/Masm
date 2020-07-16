;������ ��������� � MASM32
;---------------------------------------------------------------------------
.386                  ; ����������� ����������
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
   Text   db "������� �����: ",0
   MsgBoxCaption db "�����",0
   Summa         db 100 dup(0)

;#########################################################################

.code                  ; ������ ����

start:                 ; ����� ������
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
    push   MB_RETRYCANCEL ; �������� ������ ������  a
    push   offset MsgBoxCaption ; �������� "����� ���������"
    push   offset Summa ; �������� "����� ������ ���������"
    push   0                    ; �������� "������������ ����" - NULL
    call   MessageBox           ; ����� API-������� ������ ��������� �� �����

cmp  EAX, 4
   jz     start
   jmp    exit

exit:
  push   0                    ; ������ �������� ��� ������� ������
  call   ExitProcess          ; ����� API-������� ������

end start              ; ����� �����
;----------------------------------------------------------------------------
