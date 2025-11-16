; Ue RIP-relative memory addressing
default rel

section .text

global SumElementsI32_a
; inputs:
;   x:  rdi (64-bit address to 32-bit signed int)
;   n:  rsi (64-bit unsigned int)
; outputs:
;   return value: rax (64-bit signed int)
SumElementsI32_a:
  xor eax, eax
  sub rdi, 4

  or rsi, rsi
  jz .done

.loop1:
  add rdi, 4

  movsxd r11, dword [rdi]
  add rax, r11

  sub rsi, 1
  jnz .loop1

.done:
  ret
