.code
sqr proc value:DWORD, buff:DWORD
mov ECX,value
mov EAX,[ECX]
mov EBX,EAX
mul EBX
mov ECX,buff
mov [ECX],EAX
ret
sqr endp