; Ue RIP-relative memory addressing
default rel

extern g_F64_PI

section .rdata

F64_3p0 dq 3.0
F64_4p0 dq 4.0

section .text

global CalcSphereVolSA_avx
; inputs:
;   vol:  rdi (64-bit address of 64-bit floatng point number)
;   sa:   rsi (64-bit address of 64-bit floatng point number)
;   r:    xmm0 (64-bit floatng point number)
; outputs:
;   writes 64-bit floating point number to address in rdi
;   writes 64-bit floating point number to address in rsi
; volatile registers clobbered:
;   xmm1
CalcSphereVolSA_avx:
  ; calculate surface area = 4 * PI * r * r
  vmulsd xmm1, xmm0, xmm0           ; xmm1 = r * r
  vmulsd xmm1, xmm1, [g_F64_PI]     ; xmm1 = r * r * PI
  vmulsd xmm1, xmm1, [F64_4p0]     ; xmm1 = r * r * PI * 4
  vmovsd [rsi], xmm1                ; save surface area

  ; calculate volume = sa * r / 3
  vmulsd xmm1, xmm1, xmm0           ; xmm1 = sa * r
  vdivsd xmm1, xmm1, [F64_3p0]       ; xmm1 = sa * r / 3
  vmovsd [rdi], xmm1                ; save volume
  ret
