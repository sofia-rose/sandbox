; Ue RIP-relative memory addressing
default rel

section .rdata

F32_ScaleFtoC dd 0.55555556
F32_ScaleCtoF dd 1.8
F32_32p0      dd 32.0


section .text

global ConvertFtoC_avx
; inputs:
;   f: xmm0 (32-bit floatng point)
; outputs:
;   return value: xmm0
; volatile registers clobbered:
;   xmm1
;   xmm2
ConvertFtoC_avx:
  vmovss xmm1, [F32_32p0]         ; xmm1 = 32
  vsubss xmm2, xmm0, xmm1         ; xmm2 = f - 32
  vmovss xmm1, [F32_ScaleFtoC]    ; xmm1 = 5 / 9
  vmulss xmm0, xmm2, xmm1         ; xmm0 = (f - 32) * 5 / 9
  ret

global ConvertCtoF_avx
; inputs:
;   c: xmm0 (32-bit floatng point)
; outputs:
;   return value: xmm0
; volatile registers clobbered: NONE
ConvertCtoF_avx:
  vmulss xmm0, xmm0, [F32_ScaleCtoF]  ; xmm0 = c * 9 / 5
  vaddss xmm0, xmm0, [F32_32p0]       ; xmm0 = c * 9 / 5 + 32
  ret

