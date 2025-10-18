%include "mod-x86-asm-3e-nasm.inc"

section .text

global CalcResultI64_a
; a: dil (8 bit value)
; b: si  (16 bit vlaue)
; c: edx (32 bit value)
; d: rcx (64 bit value)
; e: r8b (8 bit value)
; f: r9w (16 bit value)
; g: [rsp+8] (32 bit value) (stack always aligned to 8 byte boundary)
; h: [rsp+16] (64 bit value)
CalcResultI64_a:
  ; calculate a * b * c * d
  movsx rax, dil      ; rax = a
  movsx r10, si       ; r10 = b
  imul rax, r10       ; rax = a * b
  movsxd r10, edx     ; r10 = c
  imul r10, rcx       ; r10 = c * d
  imul rax, r10       ; rax = a * b * c * d

  ; calculate e * f * g * h
  movsx r10, r8b              ; r10 = e
  movsx r11, r9w              ; r11 == f
  imul r10, r11               ; r10 = e * f
  movsxd r11, dword [rsp+8]   ; r11 = g
  imul r11, [rsp + 16]        ; r11 = g * h
  imul r10, r11               ; r10 = e * f * g * h

  ; calculate (a * b * c * d) + (e * f * g * h)
  add rax, r10
  ret


global CalcResultU64_a
; a: dil (8 bit value)
; b: si  (16 bit vlaue)
; c: edx (32 bit value)
; d: rcx (64 bit value)
; e: r8b (8 bit value)
; f: r9w (16 bit value)
; g: [rsp+8] (32 bit value) (stack always aligned to 8 byte boundary)
; h: [rsp+16] (64 bit value)
; quo: [rsp+24] (64 bit address)
; rem: [rsp+32] (64 bit address)
CalcResultU64_a:
  ; calculate a + b + c + d
  movzx rax, dil            ; rax = a
  movzx r10, si             ; r10 = b
  add rax, r10              ; rax = a + b
  mov r11d, edx             ; r11 = c (movs into registers always zero extend 32 bit values)
  add r11, rcx              ; r11 = c + d
  add rax, r11              ; rax = a + b + c + d

  ; calculae e + b + c + d
  movzx r10, r8b            ; r10 = e
  movzx r11, r9w            ; r11 = f
  add r10, r11              ; r10 = e + f
  mov r11d, [rsp+8]         ; r11 = g
  add r11, [rsp+16]         ; r11 = g + h
  add r10, r11              ; r10 = e + f + g + h

  ; calculate (a + b + c + d) / (e + f + g + h)
  ; (no check for division by zero)
  xor edx, edx              ; rdx:rax = a + b + c + d
  div r10                   ; rdx:rax = rdx:rax / r10

  ; save results

  mov rcx, [rsp+24]         ; save quotient
  mov [rcx], rax

  mov rcx, [rsp+32]         ; save remainder
  mov [rcx], rdx

  ret
