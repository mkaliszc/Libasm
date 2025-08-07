section .data

section .text
	global ft_strcpy

ft_strcpy:
	push rbp
	mov rbp, rsp

	mov rax, rdi
	mov rcx, 0
	jmp loop

loop:
	mov dl, [rsi + rcx]
	mov [rdi + rcx], dl
	cmp byte [rsi + rcx], 0
	je exit
	inc rcx
	jmp loop

exit:
	leave
	ret