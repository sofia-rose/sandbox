%include "cmpequ_fp.inc"

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
;   writes 8 8-bit unsigned integers to array at address in rdi
; volatile registers clobbered:
;   xmm2
CompareF32_avx:
  ; perform compare for equality
  vcmpss xmm2, xmm0, xmm1, CMP_EQ_OQ  ; perform compare operation
  vmovd eax, xmm2                     ; eax = compare result (all 1s or all 0s)
  and al, 1                           ; mask out unneeded bits
  mov [rdi], al                       ; save result

  ; perform compare for inequality
  vcmpss xmm2, xmm0, xmm1, CMP_NEQ_OQ
  vmovd eax, xmm2
  and al, 1
  mov [rdi+1], al

  ; perform compare for less than
  vcmpss xmm2, xmm0, xmm1, CMP_LT_OQ
  vmovd eax, xmm2
  and al, 1
  mov [rdi+2], al

  ; perform compare for less than or equal
  vcmpss xmm2, xmm0, xmm1, CMP_LE_OQ
  vmovd eax, xmm2
  and al, 1
  mov [rdi+3], al

  ; perform compare for greater than
  vcmpss xmm2, xmm0, xmm1, CMP_GT_OQ
  vmovd eax, xmm2
  and al, 1
  mov [rdi+4], al

  ; perform compare for greater than or equal
  vcmpss xmm2, xmm0, xmm1, CMP_GE_OQ
  vmovd eax, xmm2
  and al, 1
  mov [rdi+5], al

  ; perform compare for ordered
  vcmpss xmm2, xmm0, xmm1, CMP_ORD_Q
  vmovd eax, xmm2
  and al, 1
  mov [rdi+6], al

  ; perform compare for unordered
  vcmpss xmm2, xmm0, xmm1, CMP_UNORD_Q
  vmovd eax, xmm2
  and al, 1
  mov [rdi+7], al

  ret
