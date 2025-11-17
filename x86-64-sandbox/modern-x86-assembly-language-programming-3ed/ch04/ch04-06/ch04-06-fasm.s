; Ue RIP-relative memory addressing
default rel

section .text

global CopyArrayI32_a
; inputs:
;   b: rdi (64-bit address of array of signed 32-bit integers)
;   a: rsi (64-bit address of array of signed 32-bit integers)
;   n: rdx (unsigned 64-bit integer)
; outputs:
;   return value: void
; used volatile registers:
;   rcx
CopyArrayI32_a:
  ; rdi already contains pointer to destination array
  ; rsi already contains pointer to source array
  mov rcx, rdx
  rep movsd
  ret

global FillArrayI64_a
; inputs:
;   a: rdi (64-bit address of array of signed 64-bit integers)
;   fill_val: rsi (64-bit fill value)
;   n: rdx (unsigned 64-bit integer)
; outputs:
;   return value: void
; used volatile registers:
;   rax
;   rcx
FillArrayI64_a:
  ; rdi already contains pointer to array
  mov rax, rsi          ; rax = fill value
  mov rcx, rdx          ; rcx = element count
  rep stosq
  ret
