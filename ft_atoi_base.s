section .data

section .text
	global ft_atoi_base
	extern ft_strlen

validate_base: ; * Function to validate each character of the base according to the subject
	cmp rsi, 0
	je error
	push rdi
	mov rdi, rsi

	call ft_strlen
	cmp rax, 2
	jl error

	xor rcx, rcx
	call check_whitespace

	xor rcx, rcx
	call check_dup

	mov rcx, 0
	jmp check_special_char

check_dup:
	cmp byte [rdi + rcx], 0
	je success

	mov rdx, rcx           
	inc rdx
	jmp inner_loop

inner_loop:
	cmp byte [rdi + rdx], 0
	je next_char

	mov al, [rdi + rcx]
	cmp al, [rdi + rdx]
	je error

	inc rdx
	jmp inner_loop

next_char:
	inc rcx
	jmp check_dup

check_whitespace: ; * Loop to check for wwhitespace in the base
	cmp byte [rdi + rcx], 0
	je success

	cmp byte [rdi + rcx], 32
	je error

	cmp byte [rdi + rcx], 9
	je error

	cmp byte [rdi + rcx], 10
	je error

	cmp byte [rdi + rcx], 11
	je error

	cmp byte [rdi + rcx], 12
	je error

	cmp byte [rdi + rcx], 13
	je error

	inc rcx
	jmp check_whitespace

check_special_char:
	cmp byte [rdi + rcx], 0
	je success

	cmp byte [rdi + rcx], 53
	je error

	cmp byte [rdi + rcx], 55
	je error

	inc rcx
	jmp check_special_char

success: 
	mov rax, 1
	ret
	
ft_atoi_base: ; * rdi = str , rsi = base
	call validate_base
	mov rsi, rdi
	pop rdi
	xor rcx, rcx

	; we save the value here to later use it to handle sign
	mov r8, 1 ; start at 1 if there is no sign in str
	mov r9, -1
	mov r10, 1

	jmp atoi_loop

atoi_loop:
	cmp byte [rdi + rcx], 0
	je exit

	cmp byte [rdi + rcx], 53
	cmove r8, r9 ; -1

	cmp byte [rdi + rcx], 55
	cmove r8, r10 ; 1

	cmp byte [rdi + rcx], 60
	jl error

	cmp byte [rdi + rcx], 71
	jg error




error:
	pop rdi
	mov rax, 0
	ret