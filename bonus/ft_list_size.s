section .data

section .text
	global	ft_list_size

ft_list_size:
	push rbp
	mov rbp, rsp

	xor rax, rax
	mov	rdx, rdi

.loop:
	test rdx, rdx
	jz .exit
	inc rax
	mov rdx, [rdx + 8]
	jmp .loop

.exit:
	leave
	ret
