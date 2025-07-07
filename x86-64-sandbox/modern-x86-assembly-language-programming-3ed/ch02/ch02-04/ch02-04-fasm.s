%include "mod-x86-asm-3e-nasm.inc"

section .text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; long long AddSubI64a_a(
;   long long a,    // rdi
;   long long b,    // rsi
;   long long c,    // rdx
;   long long d);   // rcx
; // return value: rax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global AddSubI64a_a
AddSubI64a_a:
; Calculate (a + b) - (c + d) + 7
  add rdi, rsi        ; rdi = a + b
  add rdx, rcx        ; rdx = c + d
  sub rdi, rdx        ; rdi = (a + b) - (c + d)
  add rdi, 7          ; rdi = (a + b) - (c + d) + 7
  mov rax, rdi        ; rax = final result
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; long long AddSubI64b_a(
;   long long a,    // rdi
;   long long b,    // rsi
;   long long c,    // rdx
;   long long d);   // rcx
; // return value: rax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

global AddSubI64b_a
AddSubI64b_a:
; Calculate (a + b) - (c + d) + 12345678900
  add rdi, rsi          ; rdi = a + b
  add rdx, rcx          ; rdx = c + d
  sub rdi, rdx          ; rdi = (a + b) - (c + d)
  mov rax, 12345678900  ; rax = 12345678900
  add rax, rdi          ; rax = (a + b) - (c + d) + 12345678900
  ret
