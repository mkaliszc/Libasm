section .data

section .text:
	global	ft_lit_push_front
	extern	malloc
	extern	__errno_location

ft_lit_push_front:
	push rbp
	mov rbp, rsp

	push rsi
	push rdi

	mov rdi, 16
	call malloc wrt ..plt

	test rax, rax
	jz .error

	pop rdi
	pop rsi

	mov [rax], rsi
	

	leave
	ret

.error:
	pop rdi
	pop rsi
	call __errno_location wrt ..plt
	mov dword [rax], 12
	leave
	xor rax, rax
	ret

	