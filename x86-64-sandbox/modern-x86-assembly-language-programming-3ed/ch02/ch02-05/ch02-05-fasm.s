%include "mod-x86-asm-3e-nasm.inc"

section .text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; void MulI32_a(
;   int* prod1,       // rdi
;   long long* prod2, // rsi
;   int a,            // edx
;   int b);           // ecx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global MulI32_a
MulI32_a:
  mov eax, edx      ; eax = a
  imul edx, ecx     ; edx = a * b (32-bit product)
  mov [rdi], edx    ; save a * b to prod1

  movsxd rax, eax   ; rax = a (sign-extended)
  movsxd rcx, ecx   ; rcx = b (sign-extended)
  imul rcx          ; rdx:rax = a * b (128-bit product)
  mov [rsi], rax    ; save low-order qword to prod2

  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; int DivI32_a(
;   int* quo, // rdi
;   int* rem, // rsi
;   int a,    // edx
;   int b);   // ecx
; // return value: eax
; // returns: 0 = error (divisor equals zero), 1 = success
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global DivI32_a
DivI32_a:
  or ecx, ecx       ; is b == 0?
  jz InvalidDivisor ; jump if yes

  mov eax, edx      ; eax = a
  cdq               ; sign-extend a = 64-bits (edx:eax)
  idiv ecx          ; eax = quotient, edx = remainder

  mov [rdi], eax    ; save quotient
  mov [rsi], edx    ; save remainder

  mov eax, 1        ; set success return code
  ret
InvalidDivisor:
  xor eax, eax      ; set error return code
  ret
