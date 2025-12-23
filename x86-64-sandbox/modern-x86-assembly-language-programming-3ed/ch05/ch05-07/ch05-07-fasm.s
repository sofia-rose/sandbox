; Ue RIP-relative memory addressing
default rel

section .text

; inputs:
;   mean: rdi (64-bit address of 64-bit floating point number)
;   x:    rsi (64-bit address of array of 64-bit floating point number)
;   n:    rdx (64-bit unsigned integer)
; outputs:
;   rax:  8-bit boolean
; volatile registers clobbered:
;   xmm0
;   xmm1
global CalcMeanF64_avx
CalcMeanF64_avx:
  ; make sure n is valid
  cmp rdx, 1                    ; is n <= 1?
  jbe .badArg                   ; skip calculation if yes

  ; initialize
  sub rsi, 8                    ; rsi = &x[-1]
  vxorpd xmm0, xmm0, xmm0       ; sum = 0.0
  vcvtsi2sd xmm1, xmm1, rdx     ; convert n to 64-bit floating point number

  ; sum the elements of x
.loop:
  add rsi, 8                    ; rsi = &x[i]
  vaddsd xmm0, xmm0, [rsi]      ; sum += x[i]
  sub rdx, 1                    ; n -= 1
  jnz .loop

  ; calculate and save the mean
  vdivsd xmm1, xmm0, xmm1       ; xmm1 = mean = sum / n
  vmovsd [rdi], xmm1            ; save mean

  mov eax, 1                    ; set success return code
  ret

.badArg:
  xor eax, eax                  ; set error return code
  ret

; inputs:
;   std_dev:  rdi (64-bit address of 64-bit floating point number)
;   x:        rsi (64-bit address of array of 64-bit floating point number)
;   n:        rdx (64-bit unsigned integer)
;   xmm0:     rcx (64-bit floating point number)
; outputs:
;   rax:  8-bit boolean
; volatile registers clobbered:
;   xmm0
;   r9
global CalcStdDevF64_avx
CalcStdDevF64_avx:
  ; make sure n is valid
  cmp rdx, 1                    ; is n <= 1?
  jbe .badArg                   ; skip calculation if yes

  ; initialize
  sub rsi, 8                    ; rsi = &x[-1]
  mov r9, rdx                   ; r9 = n
  sub r9, 1                     ; r9 = n - 1
  vcvtsi2sd xmm4, xmm4, r9      ; converter n -1 to 64-bit floating point number
  vmovsd xmm3, xmm0, xmm0       ; xmm3 = mean
  vxorpd xmm0, xmm0, xmm0       ; sum_squares = 0.0

  ; sum the elements of x
.loop:
  add rsi, 8                    ; rsi = &x[i]
  vmovsd xmm1, [rsi]            ; xmm1 = x[i]
  vsubsd xmm2, xmm1, xmm3       ; xmm2 = x[i] - mean
  vmulsd xmm2, xmm2, xmm2       ; xmm2 = (x[i] - mean) ** 2
  vaddsd xmm0, xmm0, xmm2       ; sum_squares += (x[i] - mean) ** 2
  sub rdx, 1                    ; n -= 1
  jnz .loop

  ; calculate and save standard deviations
  vdivsd xmm0, xmm0, xmm4       ; xmm0 = sum_squares / (n - 1)
  vsqrtsd xmm0, xmm0, xmm0      ; xmm0 = std_dev
  vmovsd [rdi], xmm0            ; save std_dev

  mov eax, 1                    ; set success return code
  ret

.badArg:
  xor eax, eax                  ; set error return code
  ret
