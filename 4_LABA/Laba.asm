;Шаблон программы в MASM32
;---------------------------------------------------------------------------
.386                   ; архитектура процессора
.model flat, stdcall   ; сплошная модель памяти, очищение параметров вызываемой функцией
option casemap :none   ; различие регистра

;#########################################################################
      include \masm32\include\windows.inc
      include \masm32\include\user32.inc        ; подключаемые файлы, команды Windows
      include \masm32\include\kernel32.inc

      includelib \masm32\lib\user32.lib         ; библиотеки для использования API Windows
      includelib \masm32\lib\kernel32.lib
;#########################################################################

.data                  ; секция данных

    ;Caption  db 77,65,83,77,51,50,0
    Caption  db "MASM32",0
    Text     db "Hello, ИУБ-301!",0
    TextNF   db "Not Found",0

;#########################################################################

.code                  ; секция кода

start:                 ; метка начала

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

end start              ; метка конца
;----------------------------------------------------------------------------
