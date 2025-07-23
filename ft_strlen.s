section .data

section .text
	global ft_strlen

ft_strlen:
	mov rax, 0
	jmp loop

loop:
	cmp byte [rdi + rax], 0
	je _exit
	inc rax
	jmp loop

_exit:
	ret
	
