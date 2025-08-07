section .data

section .text
	global ft_atoi_base
	extern ft_strlen

ft_atoi_base:
	push rbp
	mov rbp, rsp
	sub rsp, 48

	mov [rbp-8], r12
	mov [rbp-16], r13
	mov [rbp-24], r14
	mov [rbp-32], r15

	mov r12, rdi
	mov r13, rsi
	xor r15, r15

	call .validate_base
	test rax, rax
	jz .error

	mov r14, rax

	call .skip_whitespace_and_signs

	call .convert_digits

	test r15, r15
	jz .exit
	neg rax

	jmp .exit

.error:
	xor rax, rax

.exit:
	mov r12, [rbp-8]
	mov r13, [rbp-16]
	mov r14, [rbp-24]
	mov r15, [rbp-32]
	leave
	ret

.validate_base:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	test r13, r13
	jz .validate_error

	mov rdi, r13
	call ft_strlen

	cmp rax, 2
	jl .validate_error

	mov r8, rax
	xor rcx, rcx

.validate_loop:
	cmp rcx, r8
	je .validate_success

	mov al, [r13 + rcx]

	cmp al, ' '
	je .validate_error
	cmp al, 9
	je .validate_error
	cmp al, 10
	je .validate_error
	cmp al, 11
	je .validate_error
	cmp al, 12
	je .validate_error
	cmp al, 13
	je .validate_error

	cmp al, '+'
	je .validate_error
	cmp al, '-'
	je .validate_error

	mov rdx, rcx
	inc rdx

.check_duplicate:
	cmp rdx, r8
	je .no_duplicate
	cmp al, [r13 + rdx]
	je .validate_error
	inc rdx
	jmp .check_duplicate

.no_duplicate:
	inc rcx
	jmp .validate_loop

.validate_success:
	mov rax, r8
	leave
	ret

.validate_error:
	xor rax, rax
	leave
	ret

.skip_whitespace_and_signs:
	push rbp
	mov rbp, rsp

	xor rcx, rcx
	mov r15, 1

.skip_loop:
	mov al, [r12 + rcx]
	test al, al
	jz .skip_done

	cmp al, ' '
	je .skip_whitespace
	cmp al, 9
	je .skip_whitespace
	cmp al, 10
	je .skip_whitespace
	cmp al, 11
	je .skip_whitespace
	cmp al, 12
	je .skip_whitespace
	cmp al, 13
	je .skip_whitespace

	cmp al, '+'
	je .skip_plus
	cmp al, '-'
	je .skip_minus

	jmp .skip_done

.skip_whitespace:
	inc rcx
	jmp .skip_loop

.skip_plus:
	inc rcx
	mov r15, 1
	jmp .skip_loop

.skip_minus:
	inc rcx
	neg r15
	jmp .skip_loop

.skip_done:
	add r12, rcx
	leave
	ret

.convert_digits:
	push rbp
	mov rbp, rsp

	xor rax, rax
	xor rcx, rcx

.convert_loop:
	mov r8b, [r12 + rcx]
	test r8b, r8b
	jz .convert_done

	call .find_char_in_base
	cmp r9, -1
	je .convert_done

	mul r14
	add rax, r9
	inc rcx
	jmp .convert_loop

.convert_done:
	leave
	ret

.find_char_in_base:
	push rbp
	mov rbp, rsp

	xor rdx, rdx

.find_loop:
	cmp rdx, r14
	jae .char_not_found
	cmp r8b, [r13 + rdx]
	je .char_found
	inc rdx
	jmp .find_loop

.char_found:
	mov r9, rdx
	leave
	ret

.char_not_found:
	mov r9, -1
	leave
	ret