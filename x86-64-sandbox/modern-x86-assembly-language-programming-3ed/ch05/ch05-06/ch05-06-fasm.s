; Ue RIP-relative memory addressing
default rel

MxcsrRcMask equ 9fffh       ; bit mask for MXCSR.RC
MxcsrRcShift equ 13         ; shift count for MXCSR.RC
MxcsrRSP equ -8             ; stack offset for vstmxcsr & vldmxcsr

%macro GetRC_M 1
  vstmxcsr [rsp+MxcsrRSP]   ; save mxcsr register
  mov %1, [rsp+MxcsrRSP]
  shr %1, MxcsrRcShift      ; %1[1:0] = MXCSR.RC
  and %1, 3                 ; clear unused bits
%endmacro

; clobbers rax
%macro SetRC_M 1
  vstmxcsr [rsp+MxcsrRSP]   ; load current MXCSR
  mov eax, [rsp+MxcsrRSP]

  and %1, 3
  shl %1, MxcsrRcShift

  and eax, MxcsrRcMask
  or eax, %1

  mov [rsp+MxcsrRSP], eax
  vldmxcsr [rsp+MxcsrRSP]
%endmacro

section .text

global ConvertScalar_avx:
; inputs:
;   des:    rdi (64-bit address of Uval union)
;   src:    rsi (64-bit address of Uval union)
;   cvt_op: edx (32-bit unsigned integer)
;   rc:     ecx (32-bit unsigned integer)
; outputs:
;
; volatile registers clobbered:
;   rax
;   r10
;   r11
;   xmm0
;   xmm1
ConvertScalar_avx:
  ; make sure cvt_op is valid
  cmp edx, CvtOpTableCount
  jae BadCvtOp

  ; load current MXCSR.rc
  GetRC_M r10d

  SetRC_M ecx

  ; jump to target conversion code block
  mov eax, edx
  lea r11, [CvtOpTable]
  lea r11, [r11 + rax*8]
  jmp qword [r11]

I32_F32:
  mov eax, [rsi]              ; load integer value
  vcvtsi2ss xmm0, xmm0, eax    ; convert to float
  vmovss [rdi], xmm0          ; save result
  jmp Done

F32_I32:
  vmovss xmm0, [rsi]
  vcvtss2si eax, xmm0
  mov [rdi], eax
  jmp Done

I32_F64:
  mov eax, [rsi]
  vcvtsi2sd xmm0, xmm0, eax
  vmovsd [rdi], xmm0
  jmp Done

F64_I32:
  vmovsd xmm0, [rsi]
  vcvtsd2si eax, xmm0
  mov [rdi], eax
  jmp Done

I64_F32:
  mov rax, [rsi]
  vcvtsi2ss xmm0, xmm0, rax
  vmovss [rdi], xmm0
  jmp Done

F32_I64:
  vmovss xmm0, [rsi]
  vcvtss2si rax, xmm0
  mov [rdi], rax
  jmp Done

I64_F64:
  mov rax, [rsi]
  vcvtsi2sd xmm0, xmm0, rax
  vmovsd [rdi], xmm0
  jmp Done

F64_I64:
  vmovsd xmm0, [rsi]
  vcvtsd2si rax, xmm0
  mov [rdi], rax
  jmp Done

F32_F64:
  vmovss xmm0, [rsi]
  vcvtss2sd xmm1, xmm1, xmm0
  vmovsd [rdi], xmm1
  jmp Done

F64_F32:
  vmovsd xmm0, [rsi]
  vcvtsd2ss xmm1, xmm1, xmm0
  vmovss [rdi], xmm1
  jmp Done

BadCvtOp:
  xor eax, eax
  ret

Done:
  SetRC_M r10d
  mov eax, 1
  ret

section .data align = 8

CvtOpTable equ $
  dq I32_F32, F32_I32
  dq I32_F64, F64_I32
  dq I64_F32, F32_I64
  dq I64_F64, F64_I64
  dq F32_F64, F64_F32
CvtOpTableCount equ ($ - CvtOpTable) / 8
