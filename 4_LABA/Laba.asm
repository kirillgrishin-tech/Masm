;������ ��������� � MASM32
;---------------------------------------------------------------------------
.386                   ; ����������� ����������
.model flat, stdcall   ; �������� ������ ������, �������� ���������� ���������� ��������
option casemap :none   ; �������� ��������

;#########################################################################
      include \masm32\include\windows.inc
      include \masm32\include\user32.inc        ; ������������ �����, ������� Windows
      include \masm32\include\kernel32.inc

      includelib \masm32\lib\user32.lib         ; ���������� ��� ������������� API Windows
      includelib \masm32\lib\kernel32.lib
;#########################################################################

.data                  ; ������ ������

    ;Caption  db 77,65,83,77,51,50,0
    Caption  db "MASM32",0
    Text     db "Hello, ���-301!",0
    TextNF   db "Not Found",0

;#########################################################################

.code                  ; ������ ����

start:                 ; ����� ������

    invoke GetCommandLine
Metka:
    cmp byte ptr[EAX],64
    jz reg
    cmp byte ptr[EAX],36
    jz poisk
    cmp byte ptr[EAX], 0
    jz notfound
    inc EAX
    mov ECX,EAX
    inc ECX
    jmp Metka

reg:
   inc EAX
   inc ECX
   mov BH, byte ptr[EAX]
   jz notfound
   jmp Metka

poisk:
    cmp byte ptr[EAX], 0
    jz notfound
    cmp byte ptr[EAX], 33
    jz vyvod
    cmp byte ptr[EAX],BH
    jz Upreg
    inc EAX
    jmp poisk

Upreg:
    sub byte ptr[EAX], 32
    inc EAX
    jmp poisk
    

vyvod:
    dec byte ptr[EAX]
    invoke MessageBox, NULL, ECX, addr Caption, MB_OK
    invoke ExitProcess, NULL


notfound:
    invoke MessageBox, NULL, addr TextNF, addr Caption, MB_OK
    invoke ExitProcess, NULL

end start              ; ����� �����
;----------------------------------------------------------------------------
