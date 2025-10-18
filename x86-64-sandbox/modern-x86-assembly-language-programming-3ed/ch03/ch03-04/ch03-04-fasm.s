%include "mod-x86-asm-3e-nasm.inc"

section .text

global SignedMin1_a
; a: edi (32 bit signed int)
; b: esi (32 bit signed int)
; c: edx (32 bit signed int)
SignedMin1_a:
  mov eax, esi
  cmp eax, edi        ; compare a and b
  jle .f1
  mov eax, edi        ; eax = b (because b < a)
.f1:
  cmp eax, edx        ; compare min(a, b) and c
  jle .f2
  mov eax, edx        ; eax = c (because c < min(a, b)
.f2:
  ret

global SignedMin2_a
; a: edi (32 bit signed int)
; b: esi (32 bit signed int)
; c: edx (32 bit signed int)
SignedMin2_a:
  cmp edi, esi        ; compare a and b
  cmovg edi, esi      ; edi = min(a, b)
  cmp edi, edx
  cmovg edi, edx      ; edi = min(a, b, c)
  mov eax, edi
  ret

global SignedMax1_a
; a: edi (32 bit signed int)
; b: esi (32 bit signed int)
; c: edx (32 bit signed int)
SignedMax1_a:
  mov eax, esi
  cmp eax, edi        ; compare a and b
  jge .f1
  mov eax, edi        ; eax = b (because b > a)
.f1:
  cmp eax, edx        ; compare max(a, b) and c
  jge .f2
  mov eax, edx        ; eax = c (because c > max(a, b)
.f2:
  ret

global SignedMax2_a
; a: edi (32 bit signed int)
; b: esi (32 bit signed int)
; c: edx (32 bit signed int)
SignedMax2_a:
  cmp edi, esi        ; compare a and b
  cmovl edi, esi      ; edi = max(a, b)
  cmp edi, edx
  cmovl edi, edx      ; edi = max(a, b, c)
  mov eax, edi
  ret
