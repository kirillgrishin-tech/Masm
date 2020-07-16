 .386; ����������� ���������� 
      .model flat, stdcall
      option casemap :none
;######################################################################### ��� ����������� ���������
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

include poisk3.inc
include Prototypes.inc

;#### // Prototypes includes			

    .data;����� ������������ ������
	
		MsgBoxCaption    db "MASM32 Prog 2", 0 ;� ����� ������ ����� ���������� 0 ��� ��������� �� �� ��� ������ ����������� 
						 
		InputCaption     db "���� ��������", 0
		InputBoxText     db "����������, ������� ��������",0
            RegistInputError db "�� ����� ������������ �������� ��������", 10; 10 � ����� ���������� ������� �� ����� ������ � ASCII ��� newline
                             db "��������� ����?", 0
            Text             db "�����: ",0
            Simv             db "������ �� ��������",0
            InputBoxRegistr  db "����������, ������� 3 �������, ������� �� �����: ", 0
		ValueInputError  db "�� �� ����� ��������", 13; 13 � ����� ���� ���������� ������� � ������� ASCII ��� ENTER
		                 db "��������� ����?",0
            
        OutputValue      db 100 dup (0);��� ������������ �������. ��� 4 ������� ������� 100 � ��������� �� ����� �����: 0000000000000000000000000             
        InputValue       db 100 dup (0)
        InputValueReg    db 100 dup (0)
		InputValueLength db 100 dup (0)



;#########################################################################
    .code

start:

mov ECX,0
 clear:
  mov InputValueReg[ECX],0
  mov InputValue[ECX],0
  inc ECX
  cmp ECX, 101
  jb clear
	
	
	; ����� InputBox
	; �� ��� �� ������ ����� ���������� ����� �������: invoke   InputBox, ADDR InputBoxText, ADDR InputCaption, ADDR InputValue
      ; ������� ��� ����� ������� �������� ���� �����
	; ����� �� ������ ����� � ������� ����� ����������� ������� 

	push	offset InputValue; ����� ���� �� �������� ��������� �����
	push	offset InputCaption; ��� �������� ������
	push	offset InputBoxText; ��� ���������. ����� ��������, ��� �� ���������� ������ � ������� �� �������, � ���� ����� (offset). �� ��������� ����� ������� �������, � ������� ����� ����������
	call	InputBox; ���� � ����� ������� �������� �������  � ���������, ��� ������ 0
      test    EAX, EAX
	jz      InputErrorValue

    InputRegistr: ;��� �� ��������� ��������� ��������_���������:    
     ; ���� �����, �������� Inputbox ������ ��� ��� �������� 
      push	offset InputValueReg
	push	offset InputCaption
	push	offset InputBoxRegistr
	call	InputBox
      cmp EAX, 0
      jz InputErrorRegistr
      cmp EAX,3
      jz vyvod
      jmp InputErrorRegistr
      
  vyvod:
   push offset InputValueReg
   push offset InputValue
   call poisk3
   cmp byte ptr[EAX],0
   jz EAXpris
   push   MB_RETRYCANCEL + MB_ICONINFORMATION ; �������� ������ ������
   push   offset MsgBoxCaption ; �������� "����� ���������"
   push   EAX                  ; �������� "����� ������ ���������"
   push   0                    ; �������� "������������ ����" - NULL
   call   MessageBox           ; ����� API-������� ������ ��������� �� �����

   cmp    EAX, 4
   jz     start
   jmp    exit

EAXpris:
   push   MB_RETRYCANCEL + MB_ICONINFORMATION ; �������� ������ ������
   push   offset MsgBoxCaption ; �������� "����� ���������"
   push   offset Simv                 ; �������� "����� ������ ���������"
   push   0                    ; �������� "������������ ����" - NULL
   call   MessageBox           ; ����� API-������� ������ ��������� �� �����

  
InputErrorRegistr:; ���� �������� ��������� ����� �� ����� jmp InputErrorRegistr ��� jz,ja,jb InputErrorRegistr �� ������������� �� ��� ���������
  push   MB_YESNO + MB_ICONERROR ; �������� ������ ������
  push   offset MsgBoxCaption    ; �������� "����� ���������"
  push   offset RegistInputError ; �������� "����� ������ ���������"
  push   0                       ; �������� "������������ ����" - NULL
  call   MessageBox              ; ����� API-������� ������ ��������� �� �����
  cmp EAX, 6
  jz  InputRegistr



InputErrorValue:
  push   MB_YESNO + MB_ICONERROR ; �������� ������ ������
  push   offset MsgBoxCaption    ; �������� "����� ���������"
  push   offset ValueInputError  ; �������� "����� ������ ���������"
  push   0                       ; �������� "������������ ����" - NULL
  call   MessageBox              ; ����� API-������� ������ ��������� �� �����

  cmp    EAX, 6
  jz     start


exit:
  push   0                    ; ������ �������� ��� ������� ������
  call   ExitProcess          ; ����� API-������� ������

end start
