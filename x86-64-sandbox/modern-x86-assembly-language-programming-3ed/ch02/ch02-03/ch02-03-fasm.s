%include "mod-x86-asm-3e-nasm.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; int ShiftU32_a(
;   unsigned int* a_shl,
;   unsigned int* a_shr,
;   unsigned int a,
;   unsigned int count);
;
; returns: 0 = invalid shift count, 1 = valid shift count
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text
global ShiftU32_a

ShiftU32_a:
  ; ABI (C ABI):
  ; &a_shl: rdi
  ; &b_shr: rsi
  ; a: rdx (edx)
  ; count: rcx (ecx)
  ; return value: rax (eax)

  cmp ecx, 32       ; is count >= 32
  jae BadCnt

  mov eax, edx      ; eax = a
  shl eax, cl       ; eax = a << count
  mov [rdi], eax    ; save shl result

  shr edx, cl       ; edx = a >> count
  mov [rsi], edx    ; save shr result

  mov eax, 1        ; valid shift count return code
  ret

BadCnt:
  xor eax, eax      ; invalid shift count return code
  return
