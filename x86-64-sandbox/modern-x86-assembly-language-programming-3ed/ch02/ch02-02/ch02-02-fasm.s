%include "mod-x86-asm-3e-nasm.inc"

section .text
global BitOpsU32_a

BitOpsU32_a:
  ; ABI (C ABI):
  ; a: rdi (edi)
  ; b: rsi (esi)
  ; c: rdx (edx)
  ; d: rcx (ecx)
  ; return value: rax (eax)

  ; Calculate ~(((a & b) | c) ^ d)

  and edi, esi  ; edi = a & b
  or edi, edx   ; edi = (a & b) | c
  xor edi, ecx  ; edi = ((a & b) | c) ^ d
  not edi       ; edi = ~(((a & b) | c) ^ d)

  mov eax, edi  ; eax = final result

  ret
