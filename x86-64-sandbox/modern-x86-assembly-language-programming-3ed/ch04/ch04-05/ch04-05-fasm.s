; Ue RIP-relative memory addressing
default rel

section .text

global CompareArrays_a
; inputs:
;   x: rdi (64-bit address of array of signed 32-bit integers)
;   y: rsi (64-bit address of array of signed 32-bit integers)
;   n: rdx (signed 32-bit integer)
; outputs:
;   return value: rax (64-bit unsigned integer)
; used volatile registers:
;   rcx
CompareArrays_a:
  mov rax, -1
  test rdx, rdx
  jle .done

  mov rcx, rdx
  mov rax, rdx

  repe  cmpsd

  jz .done
  sub rax, rcx
  sub rax, 1

.done:
  ret
