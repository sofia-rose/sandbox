; Ue RIP-relative memory addressing
default rel

; offsets for red zone variables
TEMP_A equ -8
TEMP_B equ -16
TEMP_C equ -24
TEMP_D equ -32

; storage space allocated on stack for temp variables
STK_LOCAL equ 32

; RBP offsets for stack arguments
ARG_G equ 32
ARG_H equ 40

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
; non-volatile registers saved to stack:
;   rbp
;   r14
;   r15
global AddIntegers_a
AddIntegers_a:
  ; function prologue
  push rbp                    ; save caller's RBP
  push r14                    ; r14, r15 pushes for demo only
  push r15
  mov rbp, rsp
  sub rsp, STK_LOCAL

  ; sign-extend and save a, b, c, and d on stack
  movsx rdi, dil
  mov [rbp + TEMP_A], rdi
  movsx rsi, si
  mov [rbp + TEMP_B], rsi
  movsxd rdx, edx
  mov [rbp + TEMP_C], rdx
  mov [rbp + TEMP_D], rcx

  ; sign-extend e, f, and g
  movsx rcx, r8b              ; rcx = e
  movsx rdx, r9w              ; rdx = f
  movsxd r8, [rbp + ARG_G]    ; r8 = g
  mov r9, [rbp + ARG_H]       ; r9 = h

  ; calculate a + b + c + d + e + f + g + h
  add rcx, [rbp + TEMP_A]     ; rcx = e + a
  add rdx, [rbp + TEMP_B]     ; rdx = f + b
  add r8, [rbp + TEMP_C]      ; r8 = g + c
  add r9, [rbp + TEMP_D]      ; r9 = h + d
  add rcx, rdx                ; rcx = e + a + f + b
  add r8, r9                  ; r8 = g + c + h + d
  add rcx, r8                 ; rcx = e + a + f + b + g + c + h + d
  mov rax, rcx                ; rax = final product

  ; function epilogue
  mov rsp, rbp
  pop r15
  pop r14
  pop rbp
  ret
