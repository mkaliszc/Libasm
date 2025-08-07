section .data

section .text
	global ft_strdup
	extern ft_strlen
	extern ft_strcpy
	extern malloc

ft_strdup:
	push rbp
	mov rbp, rsp
	sub rsp, 8

	call ft_strlen

	push rdi
	mov rdi, rax
	inc rdi
	call malloc wrt ..plt

	test rax, rax
	jz error

	pop rsi
	mov rdi, rax
	call ft_strcpy

	leave
	ret

error:
	xor rax, rax
	leave
	ret