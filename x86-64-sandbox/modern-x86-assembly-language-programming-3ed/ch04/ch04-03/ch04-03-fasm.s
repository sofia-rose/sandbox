; Ue RIP-relative memory addressing
default rel

section .text

global CalcMat2dSquares_a
; inputs:
;   y:  rdi (64-bit address to m x n matrix (row major) of 32-bit signed ints)
;   x:  rsi (64-bit address to n x m matrix (row major) of 32-bit signed ints)
;   m:  rdx (64-bit unsigned int)
;   n:  rcx (64-bit unsigned int)
; outputs:
;   return value: void
; mutations:
;   y matrix is mutated
; temporary values (volatile registers):
;   i: r8
;   j: r9
;   temp0: r10
;   temp1: rax
CalcMat2dSquares_a:
  ; make sure m and n are valid
  test rdx, rdx
  jz .invalidSize

  test rcx, rcx
  jz .invalidSize

  ; initialize
  xor r8, r8                    ; i = 0

.loop1:
  xor r9, r9                    ; j = 0

.loop2:
  mov rax, r9                   ; rax = j
  imul rax, rdx                 ; rax = j * m
  add rax, r8                   ; rax = j * m + i (kx)

  mov r10d, [rsi + rax*4]       ; r10d = x[j][i]
  imul r10d, r10d               ; r10d = x[j][i] * x[j][i]

  mov rax, r8                   ; rax = i
  imul rax, rcx                 ; rax = i * n
  add rax, r9                   ; rax = i * n + j (ky)

  mov [rdi + rax*4], r10d       ; y[i][j] = x[j][i] * x[j][i]

  add r9, 1                     ; j += 1
  cmp r9, rcx
  jb .loop2                     ; loop again if j < n

  add r8, 1                     ; i += 1
  cmp r8, rdx
  jb .loop1                     ; loop again if i < m

.invalidSize:
  ret
