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

include Prototypes.inc

;#### // Prototypes includes			

    .data;����� ������������ ������
	
		MsgBoxCaption    db "MASM32 Prog 2", 0 ;� ����� ������ ����� ���������� 0 ��� ��������� �� �� ��� ������ ����������� 
						 
		InputCaption     db "���� ��������", 0
		InputBoxText     db "����������, ������� ��������",0
            RegistInputError db "�� ����� ������������ �������� ��������", 10; 10 � ����� ���������� ������� �� ����� ������ � ASCII ��� newline
                             db "��������� ����?", 0
            Text             db "�����: ",0
            Simv             db "���-�� ��������: ",0
            InputBoxRegistr  db "����������, ������� ��. ��������", 0
		ValueInputError  db "�� �� ����� ��������", 13; 13 � ����� ���� ���������� ������� � ������� ASCII ��� ENTER
		                 db "��������� ����?",0
            
        OutputValue      db 100 dup (0);��� ������������ �������. ��� 4 ������� ������� 100 � ��������� �� ����� �����: 0000000000000000000000000             
		InputValue       db 100 dup (0)
            InputValueReg    db 1 dup (0)
            InputValueReg1    db 1 dup (0)
		InputValueLength db 100 dup (0)



;#########################################################################
    .code

start:

	mov EDX,2
	
	; ����� InputBox
	; �� ��� �� ������ ����� ���������� ����� �������: invoke InputBox, ADDR InputBoxText, ADDR InputCaption, ADDR InputValue
    ; ������� ��� ����� ������� �������� ���� �����
	; ����� �� ������ ����� � ������� ����� ����������� ������� 

	push	offset InputValue; ����� ���� �� �������� ��������� �����
	push	offset InputCaption; ��� �������� ������
	push	offset InputBoxText; ��� ���������. ����� ��������, ��� �� ���������� ������ � ������� �� �������, � ���� ����� (offset). �� ��������� ����� ������� �������, � ������� ����� ����������
	call	InputBox; ���� � ����� ������� �������� �������  � ���������, ��� ������ 0
    cmp EAX, 0
	jz  InputErrorValue
REG:
    InputRegistr: ;��� �� ��������� ��������� ��������_���������:    
      ; ���� �����, �������� Inputbox ������ ��� ��� �����
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



      ;�� ����� cmp ��� if, ������������ ������� cmp �� if ��� ������ �����.
      ; cmp ���������1, ���������2 == if <���������1> ? <���������2> then
      ; ���� � Lazarus �� ������ ����� ������, ������, �����, �� � ���������� �� ������ ������ �����. ����� ��� �������������
      ; ���������        Lazarus
      ;jmp <�����>  =      goto <�����> 
      ;jz <�����>   =      if <���������>=(���������2) then goto <�����> 
      ;ja <�����>   =      if <���������1> ������ <���������2> goto <�����> 
      ;jb <�����>   =      if <���.1> ������  <���.2> goto <�����> 
      

Registr:
  cmp byte ptr[InputValueReg], 123; byte ptr[�����] ��� ��������� ������� � 123. � ���������� ��� ������� �������� � ������ (������ ������� ASCII) 
  jb Wert 
  jmp InputErrorRegistr


 Wert:
  mov BH, byte ptr[InputValueReg]; ��������� BH ������ �� ������ InputValueReg
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
   push   MB_RETRYCANCEL + MB_ICONINFORMATION ; �������� ������ ������
   push   offset MsgBoxCaption ; �������� "����� ���������"
   push   offset InputValue   ; �������� "����� ������ ���������"
   push   0                    ; �������� "������������ ����" - NULL
   call   MessageBox           ; ����� API-������� ������ ��������� �� �����

   cmp    EAX, 4
   jz     start
   jmp    exit
  
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
