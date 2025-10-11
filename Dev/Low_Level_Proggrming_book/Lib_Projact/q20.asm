global print_newlinet
global print_chart





section .text

; Question 20 try to rewrite print_newline without calling print_char or copy inits code. hint: read about tail call optimization.

print_newlinet:
	mov rdi,0xa
	jmp print_char


print_chart:
	push rbp
	mov rbp,rsp
	sub rsp,10
	
	mov byte[rsp+1],dil
	lea rsi,byte[rsp+1]
	mov rax,1
	mov rdi,1
	mov rdx,1
	syscall

	add rsp,10
	pop rbp
	ret
