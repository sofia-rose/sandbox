; Ue RIP-relative memory addressing
default rel

section .text

global CountChars_a
; inputs:
;   s:  rdi (64-bit address to 0 terminated character string)
;   c:  sil (8 bit character)
; outputs:
;   return value: rax (64-bit unsigned integer)
; used volatile registers:
;   dl (8 bit character)
;   al (8 bit character)
;   rsi (64-bit address to 0 terminated character string)
;   r8
;   ecx
CountChars_a:
  mov dl, sil                   ; dl = c
  mov rsi, rdi                  ; rsi = s
  xor ecx, ecx                  ; num_chars = 0
  xor r8d, r8d                  ; r8 = 0

.loop1:
  lodsb                         ; load next char into register al
  test al, al                   ; test for end of string
  jz .done

  cmp al, dl                    ; compare string char to c char
  sete r8b                      ; r8b = 1 if match, 0 otherwise
  add rcx, r8                   ; num_chars += r8

  jmp .loop1

.done:
  mov rax, rcx
  ret
