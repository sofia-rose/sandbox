%include "mod-x86-asm-3e-nasm.inc"

section .text
global AddSubI32_a

AddSubI32_a:
  ; ABI (C ABI):
  ; a: rdi (edi)
  ; b: rsi (esi)
  ; c: rdx (edx)
  ; d: rcx (ecx)
  ; return value: rax (eax)

  ; Calculate (a + b) - (c + d) + 7

  add edi, esi  ; edi = a + b
  add edx, ecx  ; edx = c + d
  sub edi, edx  ; edi = (a + b) - (c + d)
  add edi, 7    ; edi = (a + b) - (c + d) + 7

  mov eax, edi  ; eax = final result

  ret
