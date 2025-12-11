; Ue RIP-relative memory addressing
default rel

section .rdata

section .text

global CompareF32_avx:
; inputs:
;   cmp_results:  rdi (64-bit address of array of 7 8-bit unsigned integer)
;   a:            xmm0 (64-bit floating point number)
;   a:            xmm1 (64-bit floatng point number)
; outputs:
;   writes 7 8-bit unsigned integers to array at address in rdi
; volatile registers clobbered:
CompareF32_avx:
  ; set result flags based on compare status
  vucomiss xmm0, xmm1
  setp [rdi]
  jnp .l1

  xor al, al
  mov [rdi+1], al
  mov [rdi+2], al
  mov [rdi+3], al
  mov [rdi+4], al
  mov [rdi+5], al
  mov [rdi+6], al
  ret

.l1:
  setb  [rdi+1]         ; set byte if a < b
  setbe [rdi+2]         ; set byte if a <= b
  sete  [rdi+3]         ; set byte if a == b
  setne [rdi+4]         ; set byte if a != b
  seta  [rdi+5]         ; set byte if a > b
  setae [rdi+6]         ; set byte if a >= b
  ret
