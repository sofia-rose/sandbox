%include "mod-x86-asm-3e-nasm.inc"

section .text

global SumValsI32_a
; a: edi
; b: esi
; c: edx
; d: ecx
; e: r8d
; f: r9d
; g: [rsp+8]  (stack always aligned to 8 byte boundary)
; h: [rsp+16]
SumValsI32_a:
  ; calculate a + b + c + d
  add edi, esi        ; edi = a + b
  add edx, ecx        ; edx = c + d
  add edi, edx        ; edi = a + b + c + d

  ; calculate e + f + g + h
  add r8d, r9d        ; r8d = e + f
  mov eax, [rsp+8]    ; eax = g
  add eax, [rsp+16]   ; eax = g + h
  add eax, r8d        ; eax = e + f + g + h

  add eax, edi        ; eax = final sum
  ret

global MulValsU64_a
; a: rdi
; b: rsi
; c: rdx
; d: rcx
; e: r8
; f: r9
; g: [rsp+8]
; h: [rsp+16]
MulValsU64_a:
  ; calculate a * b * c * d * e * f * g * h
  mov r10, rdx        ; save copy of c
  mov rax, rdi        ; rax = a
  mul rsi             ; rax = a * b
  mul r10             ; rax = a * b * c
  mul rcx             ; rax = a * b * c * d
  mul r8              ; rax = a * b * c * d * e
  mul r9              ; rax = a * b * c * d * e * f
  mul qword [rsp+8]   ; rax = a * b * c * d * e * f * g
  mul qword [rsp+16]  ; rax = a * b * c * d * e * f * g * h
  ret
