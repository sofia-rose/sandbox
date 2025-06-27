; PURPOSE: Simple program that exits and returns a status code back to the
;          Linux kernel.
;

; INPUT: none
;

; OUTPUT: Returns a status code. This can b viewed by typing `echo $?` after
;         running the program.

; VARIABLES:
;             rax: holds the system call number
;             rdi: holds the return status

global _start

section .text

_start:
  mov rax, 60
  mov rdi, 42
  syscall
