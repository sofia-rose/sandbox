; Ue RIP-relative memory addressing
default rel

section .text

global CalcArrayVals_a
; inputs:
;   c:  rdi (64-bit address to 64-bit signed int array)
;   a:  rsi (64-bit address to 64-bit signed int array)
;   b:  rdx (64-bit address to 64-bit signed int array)
;   n:  rcx (64-bit unsigned int)
; outputs:
;   return value: void
; mutations:
;   c array contents are mutated
CalcArrayVals_a:
; make sure n is valid
  or rcx, rcx                   ; n == 0?
  jz .done                      ; jump if yes

; initialize
  ; move b to r8 because rdx will be used by idiv instruction
  mov r8, rdx                   ; r8 = ptr to b[]
  mov r11, -8                   ; r11 = common offset for arrays

; calculate c[i] = (a[i] * 25) / (b[i] + 10)
.loop1:
  add r11, 8

  mov rax, [rsi + r11]          ; rax = a[i]
  imul rax, rax, 25             ; rax = a[i] * 25

  mov r9, [r8 + r11]            ; r9 = b[i]
  add r9, 10                    ; r9 = b[i] + 10

  cqo                           ; rdx:rax = a[i] * 25
  idiv r9                       ; rax = (a[i] * 25) / (b[i] + 10)

  mov [rdi + r11], rax          ; save result to c[i]

  sub rcx, 1                    ; n -= 1
  jnz .loop1                    ; repeat until n == 0

.done:
  ret
