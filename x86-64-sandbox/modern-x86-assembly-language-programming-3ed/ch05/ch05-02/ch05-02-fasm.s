; Ue RIP-relative memory addressing
default rel

extern g_F32_PI

section .rdata

F32_3p0 dd 3.0

section .text

global CalcConeVolSA_avx
; inputs:
;   vol:  rdi (64-bit address of 32-bit floatng point number)
;   sa:   rsi (64-bit address of 32-bit floatng point number)
;   r:    xmm0 (32-bit floatng point number)
;   h:    xmm1 (32-bit floatng point number)
; outputs:
;   writes 32-bit floating point number to address in rdi
;   writes 32-bit floating point number to address in rsi
; volatile registers clobbered:
;   xmm3
;   xmm4
;   xmm5
CalcConeVolSA_avx:
  ; calculate vol = pi * r * r * h / 3.0f
  vmulss xmm2, xmm0, xmm0               ; xmm2 = r * r
  vmulss xmm3, xmm2, [g_F32_PI]         ; xmm3 = r * r * pi ; order of operations different from spec...
  vmulss xmm4, xmm3, xmm1               ; xmm4 = r * r * pi * h
  vdivss xmm5, xmm4, [F32_3p0]          ; xmm5 = r * r * pi * h / 3.0
  vmovss [rdi], xmm5                    ; save volume

  ; calculate sa = pi * r * (r + sqrt(r * r + h * h));
  vmulss xmm3, xmm1, xmm1               ; xmm3 = h * h
  vaddss xmm4, xmm2, xmm3               ; xmm4 = r * r + h * h
  vsqrtss xmm5, xmm4, xmm4              ; xmm5 = sqrt(r * r + h * h)
  vaddss xmm5, xmm0, xmm5               ; xmm5 = r + sqrt(r * r + h * h)
  vmulss xmm2, xmm0, [g_F32_PI]         ; xmm2 = r * pi
  vmulss xmm5, xmm2, xmm5               ; xmm5 = r * pi * (r + sqrt(r * r + h * h)) ; order of operations different from spec...
  vmovss [rsi], xmm5                    ; save surface area

  ret
