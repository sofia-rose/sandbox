; Ue RIP-relative memory addressing
default rel

; offsets for red zone variables
RZ_A equ -8
RZ_B equ -16
RZ_C equ -120
RZ_D equ -128

; offsets for stack arguments
ARG_G equ 8
ARG_H equ 16

section .text

; inputs:
;   a:  rdi       8-bit integer
;   b:  rsi      16-bit integer
;   c:  rdx      32-bit integer
;   d:  rcx      64-bit integer
;   e:  r8        8-bit integer
;   f:  r9       16-bit integer
;   g:  [rsp+8]  32-bit integer
;   h:  [rsp+16] 64-bit integer
; outputs:
;   rax:  8-bit boolean
; volatile registers clobbered:
;   r10
;   r11
global MulIntegers_a
MulIntegers_a:
  ; sign-extend and save a, b, c, d to red zone
  movsx rdi, dil
  mov [rsp + RZ_A], rdi
  movsx rsi, si
  mov [rsp + RZ_B], rsi
  movsxd rdx, edx
  mov [rsp + RZ_C], rdx
  mov [rsp + RZ_D], rcx

  ; calculate a * b * c * d * e * f * g * h
  movsx r8, r8b
  movsx r9, r9w
  movsxd r10, [rsp + ARG_G]
  mov r11, [rsp + ARG_H]

  imul r8, [rsp + RZ_A]
  imul r9, [rsp + RZ_B]
  imul r10, [rsp + RZ_C]
  imul r11, [rsp + RZ_D]

  imul r8, r9
  imul r10, r11
  imul r8, r10

  mov rax, r8

  ret
