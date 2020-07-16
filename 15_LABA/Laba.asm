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
   summa dq 0,0
   number dq 0,0
   nepoln db "0,",0
   strsumma db 1000 dup(0)
   stroka db 1000 dup(0)
   stroka2 db 1000 dup(0)
   strnumber db 1000  dup(0)
   
   MsgBoxCaption db "�����",0
   Text   db "����� ����: ",0
   Kol db ". ���-�� ������: ",0

;#########################################################################

.code                  ; ������ ����

start:                 ; ����� ������
mov EAX,0
clear:
mov strsumma[EAX],0
mov strnumber[EAX],0
mov stroka[EAX],0
mov stroka2[EAX],0
inc EAX
cmp EAX,1001
jb clear

mov EBX,0
mov EAX,0
mov EDX,0
mov ECX,offset summa
mov [ECX], EDX

summa_ryada:
mov EAX,1
inc EBX
add EAX, EBX
mul EBX
mov EDX,0
push EBX
mov EDX,0
mov EBX,EAX
mov EAX,1000000
div EBX
mov EDX,0
add [ECX], EAX
mov EDX,EBX
pop EBX
cmp EDX,10000
ja Vyvod
cmp EBX, 30    
jz Vyvod
jmp summa_ryada

  Vyvod:
  mov ECX, offset number
  mov EDX,0
  mov [ECX],EDX
  add [ECX], EBX
  push offset strsumma
  push offset summa
  call inttostr
  
  push offset strnumber
  push offset number
  call inttostr
  mov strsumma[4],0
  
 push offset stroka
 push offset Kol
 push offset strsumma
 push offset nepoln
 push offset Text
 call CONCAT

 push offset stroka2
 push 0
 push offset strnumber
 push 0
 push offset stroka
 call CONCAT

    push   MB_RETRYCANCEL + MB_ICONINFORMATION ; �������� ������ ������  a
    push   offset MsgBoxCaption ; �������� "����� ���������"
    push   offset stroka2 ; �������� "����� ������ ���������"
    push   0                    ; �������� "������������ ����" - NULL
    call   MessageBox           ; ����� API-������� ������ ��������� �� �����
   

cmp    EAX, 4
   jz     start
   jmp    exit

exit:
  push   0                    ; ������ �������� ��� ������� ������
  call   ExitProcess          ; ����� API-������� ������

end start              ; ����� �����
;----------------------------------------------------------------------------
