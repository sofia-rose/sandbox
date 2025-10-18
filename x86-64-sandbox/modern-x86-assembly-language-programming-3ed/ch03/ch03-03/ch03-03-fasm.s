%include "mod-x86-asm-3e-nasm.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .rdata

PrimeNums:
  dd  2,  3,  5,  7, 11, 13, 17, 19, 23
  dd 29, 31, 37, 41, 43, 47, 53, 59
  dd 61, 67, 71, 73, 79, 83, 89, 97

global g_NumPrimes_a
g_NumPrimes_a: dd ($ - PrimeNums) / 4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .data

global g_SumPrimes_a
g_SumPrimes_a: dd -9999

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .text

global MemAddressing_a
;  i: edi (32 bit signed int)
; v1: rsi (64-bit address to 32-bit signed int)
; v2: rdx (64-bit address to 32-bit signed int)
; v3: rcx (64-bit address to 32-bit signed int)
; v4: r8  (64-bit address to 32-bit signed int)
MemAddressing_a:
  ; make sure 'i' is valid
  cmp edi, -1
  jle .InvalidIndex
  cmp edi, [g_NumPrimes_a]
  jge .InvalidIndex

  ; initialize
  movsxd r10, edi
  lea r11, [PrimeNums]

  ; memory addressing - base regiser
  mov rdi, r10          ; rdi = i
  shl rdi, 2            ; rdi = i * 4
  mov rax, r11          ; rax = PrimeNums
  add rax, rdi          ; rax = PrimeNums + i * 4
  mov eax, [rax]        ; eax = PrimeNums[i]
  mov [rsi], eax        ; save to v1

  ; memory addressing - base register + index register
  mov rdi, r10          ; rdi = i
  shl rdi, 2            ; rdi = i * 4
  mov eax, [r11 + rdi]  ; eax = PrimNums[i]
  mov [rdx], eax        ; save to v2

  ; memory addressing - base register + index register * scale factor
  mov eax, [r11 + r10*4]    ; eax = PrimeNums[i]
  mov [rcx], eax            ; save to v3

  ; memory addressing - base register + index register * scale factor + disp
  sub r11, 42                   ; r11 = PrimeNums - 42
  mov eax, [r11 + r10*4 + 42]   ; eax = PrimeNums[i]
  mov [r8], eax                 ; save to v4

  ; memory addressing - RIP relative
  add [g_SumPrimes_a], eax      ; update sum
  mov eax, 1                    ; set success return code
  ret

.InvalidIndex:
  xor eax, eax                  ; set error return code
  ret

