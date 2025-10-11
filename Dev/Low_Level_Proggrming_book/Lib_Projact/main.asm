%include "lib.asm"
%include "q20.asm" 
global _start

section .data
src: db "aaaaaaa",0
des: times 5 db 0 

section .text
_start:
	mov rdi,0x34
	call print_chart
	call print_newlinet	
	mov rdi,0
	call exit
	
