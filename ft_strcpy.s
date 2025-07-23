section .data

section .text
	global ft_strcpy

ft_strcpy:
	mov rax, rdi
	mov rcx, 0
	jmp loop

loop:
	cmp byte [rsi + rcx], 0
	mov dl, [rsi + rcx]
	mov[rdi + rcx], dl
	je exit
	inc rcx
	jmp loop

exit:
	ret