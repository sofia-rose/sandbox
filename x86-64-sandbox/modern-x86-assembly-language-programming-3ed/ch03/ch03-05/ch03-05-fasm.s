%include "mod-x86-asm-3e-nasm.inc"

section .text
  extern g_ValMax

global CalcSumCubes_a
; sum:  rdi (64-bit address to 64-bit signed int)
; n:    rsi (64-bit signed int)
CalcSumCubes_a:
  ; make sure n is valid
  test rsi, rsi           ; n <= 0?
  jle .badArg             ; bad arg if yes
  cmp rsi, [g_ValMax]     ; n > g_valMax?
  jg .badArg              ; bad arg if yes

  ; initialize
  xor r10, r10            ; i = 0
  xor eax, eax            ; sum = 0

.loop1:
  add r10, 1              ; i += 1
  mov r11, r10            ; r11 = i
  imul r11, r11           ; r11 = i * i
  imul r11, r10           ; r11 = i * i * i
  add rax, r11            ; sum += i * i * i

  cmp r10, rsi            ; i < n?
  jl .loop1               ; repeat loop if yes

.done:
  mov [rdi], rax          ; save final sum
  mov eax, 1              ; rc = true
  ret

.badArg:
  mov qword [rdi], 0      ; sum = 0 (error)
  xor eax, eax            ; rc = false
  ret
