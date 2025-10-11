global exit
global string_length
global print_string
global print_char
global print_newline
global print_uint
global print_int
global read_char
global read_word
global parse_uint
global parse_int
global string_equals
global string_copy

section .text
; string_copy(rdi,rsi,rax) descriptions:get 2 pointers first des buff secound src buss and copy thr src to dest if the buff not fit returen  else retum pointer to to des
string_copy:
	push rbp
	mov rbp,rsp
	sub rsp,16

	xor rcx,rcx ; counter
	xor rdx,rdx ; temp
	.check_string:
		mov dl,byte[rsi+rcx]
		inc rcx
		cmp dl,0
		je .copy

		cmp rcx,rax
		jg .error
		jmp .check_string

	.copy:
		xor rcx,rcx
		xor rdx,rdx
		.loop:
			mov dl,byte[rsi+rcx]
			mov byte[rdi,rcx],dl
			inc rcx
			cmp dl,0
			je .end
			jmp .loop
	.error:
		xor rax,rax
		add rsp,16
		pop rbp
		ret
	.end:
		mov dl,0
		mov byte[rdi,rcx],dl
		mov rax,rdi
		add rsp,16
		pop rbp
		ret		
		

	


; string_equals(rdi,rsi) descriptions: get 2 pointers to strings and ret 1 if equals 0 if not
string_equals:
	push rbp
	mov rbp,rsp
	sub rsp,16
	
	xor rcx,rcx ;counter
	xor rax,rax
	xor r8,r8
	.loop:
		
		mov al,byte[rdi+rcx]
		mov r8b,byte[rsi+rcx]

	
		cmp al,r8b
		jne .not_equal

		cmp al,0
		je .equal

		inc rcx
		jmp .loop
	.not_equal:
		xor rax,rax
		jmp .end
	.equal:
		mov rax,1
		jmp .end
	.end:
		add rsp,16
		pop rbp
		ret
		

; parse_int(rdi) description: get puinter to string and return it in sign 
parse_int:
	push rbp
	mov rbp,rsp
	sub rsp,24
	
	mov rsi,rdi  ; hold pointer
	xor rcx,rcx  ; index 
	xor rdi,rdi  ; sign flag 
	xor rax,rax
	xor r8,r8	
	.sing_check:
		mov al,[rsi+rcx]
		cmp al,0x2d
		je .flag
		jmp .buff

	.buff:
		mov al,[rsi+rcx]
		cmp al,0x20
		je .prep		

		cmp al,0
		je .prep

		sub al,0x30
		cmp al,9
		jg .skip
		
		cmp al,0
		jl .skip

		cmp rcx,20
		je .error
		
		mov byte [rsp+r8],al
		inc r8
		inc rcx
		jmp .buff
	.error:
		mov rax,-1
		jmp .end
	.flag:
		mov rdi,1
		jmp .buff	
	.skip:
		inc rcx
		jmp .buff		
;rsi = pointer NULL , rax = byte that write to stack, rcx = count char in pointer, rdi = sing flag
	.prep:
		test r8,r8
		jz .end
		xor rcx,rcx ;counter of stack
		xor rsi,rsi ; tmp num
		xor rax,rax ;result
		xor rdx,rdx
		jmp .build	
	.build:
		lea rsi,byte[rsp+rcx]
		movzx rbx,byte[rsi]
		imul rax,10
		add rax,rbx
		inc rcx
	
		cmp r8,rcx
		je .sign
		
		jmp .build

	.sign:
		cmp rdi,1
		jne .end

		not rax
		add rax,1
		jmp .end

	.end:
		mov rdx,rcx
		add rsp,24
		pop rbp
		ret
		
		





; parse_uint(rdi) discription: get pointer to string and return rax = numbr rdx = cunot chars 
parse_uint:
	push rbp
	mov rbp,rsp
	sub rsp, 24
	
	xor rdx,rdx  ; count chars
	xor rax,rax  ; the number
	xor rsi,rsi  ; hold the number



	.char_to_number:
		mov sil,[rdi+rdx]
		cmp sil,0x0
		je .preper_reg

		sub sil,0x30
		mov [rsp+rdx],sil
		inc rdx
		
		jmp .char_to_number

	.preper_reg:
		xor r8,r8
		xor rax,rax ;store result
		xor rdi,rdi
		jmp .number_to_decimal

	.number_to_decimal:
		lea rsi,[rsp+r8]
		imul rax,10
		
		movsx rdi,byte[rsi]
		add rax,rdi
		inc r8
		
		cmp r8,rdx
		je .end

		jmp .number_to_decimal

	.end:
		add rsp,24
		pop rbp
		ret	







; read_word(rdi,rsi) description: get length of bytes and buffer address
read_word:
	push rbp
	mov rbp,rsp
	sub rsp,16

	xor rbx,rbx
	mov r8,rdi

	.read:
		cmp r8,rbx
		je .error
		
		mov rax,0
		mov rdi,0
		mov rdx,1
		syscall
		test rax,rax
		jz .exit_s
		jmp .test_c


	.test_c:
		mov al,[rsi]
		cmp al,0x20
		je .read

		cmp al,0xa
		je .exit_s

		inc rsi
		inc rbx

		jmp .read

	.error:
		xor rax,rax
		jmp .return
	.exit_s:
		mov al,0x0
		mov [rsi],al
		sub rsi,rbx
		mov rax,rsi
		jmp .return

	.return:
		add rsp,16
		pop rbp
		ret

		
	

	

; read_char description: get input as char and return it 
read_char:
	push rbp
	mov rbp,rsp
	sub rsp,16

	mov rax,0
	mov rdi,0
	mov rsi,rsp
	mov rdx,1
	syscall 
	mov rax,[rsp]
	add rsp,16
	pop rbp
	ret
	
	

; print_int(rdi) description: get number and print it as sign format
print_int:
	push rbp
	mov rbp,rsp
	sub rsp,24
	
	xor rax,rax
	xor rcx,rcx
	xor r8,r8
	mov r8,rbp
	mov rax,rdi
	

	.check_MSB:
		mov rdi,1
		shl rdi,63
		and rdi,rax
		mov rdi,10
		jz .unsigned


		cmp rax,0xffffffffffffffff
		je .mone
		
		not rax
		add rax,1
		jmp .sign

	.sign:
		xor rdx,rdx
		div rdi
		add dl,0x30
		
		dec r8
		inc rcx
		mov byte[r8],dl
		
		test rax,rax
		jz .addm
		jmp .sign

	.addm:
		dec r8
		inc rcx
		mov byte[r8],0x2d
		jmp .end

	.mone:
		dec r8
		mov byte[r8],0x31
		dec r8
		mov byte[r8],0x2d
		mov rcx,2
		jmp .end
	.unsigned:
		xor rdx,rdx
		div rdi
		add dl,0x30
		
		dec r8
		inc rcx
		mov byte[r8],dl
		
		test rax,rax
		jz .end
		jmp .unsigned
		
	.end:
		mov rax,1
		mov rdi,1
		mov rsi,r8
		mov rdx,rcx
		syscall
		xor rax,rax
		add rsp,24
		pop rbp 
		ret
	


; print_uint(rdi) description: get unsinged int and print in decimal format
print_uint:
	push rbp
	mov rbp,rsp
	sub rsp,24
	
	xor r8,r8
	xor rax,rax
	xor rcx,rcx
	mov r8,rbp
	
	mov rax,rdi
	xor rdi,rdi
	mov rdi,10
	.loop:
		xor rdx,rdx
		div rdi
		add dl,0x30
		
		dec r8
		inc rcx
		mov byte[r8],dl

		test rax,rax
		jz .end
		jmp .loop	
	.end:
		mov rax,1
		mov rdi,1
		mov rsi,r8
		mov rdx,rcx
		syscall
		
		xor rax,rax	
		add rsp,24
		pop rbp 
		ret

; print_newline() description: print '\n'
print_newline:
	mov rdi,0xA
	call print_char
	xor rax,rax
	ret

; print_char(rdi) description: get chr code and print it
print_char:
	push rdi
	mov rax,1
	mov rdi,1
	mov rsi,rsp
	mov rdx,1
	syscall
	pop rdi
	xor rax,rax
	ret

; print_string(rdi) description:get pointer to string and print out string tiill NULL
print_string:
    mov rsi, rdi
	xor rdx,rdx
.count_loop:
    cmp byte [rsi+rdx], 0
    je .write
    inc rdx
    jmp .count_loop

.write:
    mov rax, 1
    mov rdi, 1
    syscall
    mov rax, rdx
    ret

; string_length(rdi) description:get pointer to strinf and retun the length of strig till NULL
string_length: 
	xor rax,rax
	.loop:
		cmp byte [rdi+rax],0
		je .end
		inc rax
		jmp .loop
	.end:
		ret
	
; exit fun description: trminated the prosess
exit:
	mov rax,60
	syscall
