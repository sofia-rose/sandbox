; Ue RIP-relative memory addressing
default rel

section .text

global ReverseArrayI32_a
; inputs:
;   y: rdi (64-bit address of array of signed 32-bit integers)
;   x: rsi (64-bit address of array of signed 32-bit integers)
;   n: rdx (signed 32-bit integer)
; outputs:
;   return value: rax
; used volatile registers:
;   rcx
ReverseArrayI32_a:
  ; make sure n is valid
  xor eax, eax
  test edx, edx
  jle .done

  ; initialize registers
  ; rdi already set to y
  ; rsi already set to x
  mov ecx, edx                ; rcx = n
  lea rsi, [rsi + rcx*4 - 4]  ; rsi = &x[n-1]

  ; save caller's RFLAGS.DF, then set RFLAGS.DF to 1
  pushfq
  std

.loop1:
  lodsd             ; eax = *x--
  mov [rdi], eax    ; *y = eax
  add rdi, 4        ; ++y
  sub rcx, 1        ; n -= 1
  jnz .loop1        ; loop if n > 0

  ; restore caller's RFLAGS.DF and set return code
  popfq
  mov eax, 1

.done:
  ret
