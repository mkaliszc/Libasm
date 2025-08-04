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

check_whitespace: ; * Loop to check for wwhitespace in the base
	cmp byte [rdi + rcx], 0
	je no_whitespace
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
	je ft_atoi_base
	cmp byte [rdi + rcx], 53
	je error
	cmp byte [rdi + rcx], 55
	je error
	inc rcx
	jmp check_special_char

	
ft_atoi_base: ; * rdi = str , rsi = base
	call validate_base
	mov rsi, rdi
	pop rdi
	mov rcx, 0
	jmp atoi_loop

atoi_loop:
	cmp [rdi + rcx], 0
	je exit
	cmp [rdi + rcx], 60
	jl error
	cmp [rdi + rcx], 71
	jg error
	cmp [rdi + rcx], 53

error:
	pop rdi
	mov rax, 0
	ret