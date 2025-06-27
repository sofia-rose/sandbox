; PURPOSE: This program finds the maximum number of a set of a data items.
;

; VARIABLES: The registers have the following uses:
;
; rbx: holds the index of the data item being examined
; rdi: largest data item found
; rax: current data item
;
; The following memory locations are used:
;
; data_items: contains the item data. A 0 is used to terminate the data.
;

section .data

data_items:
  dq 3, 67, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 250, 0

section .text

global _start

_start:
  mov rbx, 0
  mov rax, [rbx*8 + data_items]
  mov rdi, rax

start_loop:
  cmp rax, 0
  je loop_exit
  inc rbx
  mov rax, [rbx*8 + data_items]
  cmp rax, rdi
  jle start_loop
  mov rdi, rax
  jmp start_loop

loop_exit:
  ; rdi is the status code for the exit system call and it already has the
  ; maximum number
  mov rax, 60
  syscall
