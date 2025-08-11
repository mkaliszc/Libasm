section .data

section .text
	global	ft_read
	extern	__errno_location

ft_read:
	push rbp
	mov rbp, rsp
	sub rsp, 8

	mov rax, 0
	syscall
	cmp rax, 0
	jl error
	leave
	ret

error:
	neg rax
	mov rdi, rax
	call __errno_location wrt ..plt
	mov [rax], rdi
	mov rax, -1
	leave
	ret