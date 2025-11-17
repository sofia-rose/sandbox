; Ue RIP-relative memory addressing
default rel

struc TestStruct
.Val8:  resb 1
.PadA:  resb 7
.Val64: resq 1
.Val16: resw 1
.PadB:  resb 2
.Val32: resd 1
.endstruc

section .text

global SumStructVals_a
; inputs:
;   ts: rdi (64-bit address of TestStruct)
; outputs:
;   return value: rax
; used volatile registers:
;   rcx
SumStructVals_a:
  ; compute ts->Val8 + ts->Val16, note sign extensions to 32-bits
  movsx eax, byte [rdi + TestStruct.Val8]
  movsx edx, word [rdi + TestStruct.Val16]
  add eax, edx

  ; sign extend previous result to 64 bits
  movsxd rax, eax

  ; add ts->Val32 to sum
  movsxd rdx, [rdi + TestStruct.Val32]
  add rax, rdx

  ; add ts->Val64 to sum
  add rax, [rdi + TestStruct.Val64]
  ret
