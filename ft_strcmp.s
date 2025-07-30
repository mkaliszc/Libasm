section .data

section .text
	extern __errno_location
	global ft_strcmp

ft_strcmp:
	mov rcx, 0
	jmp loop

loop:
	cmp byte [rdi + rcx], [rsi + rcx]
	jne return
	inc rcx
	je loop

return:
	movzx rax, [rdi + rcx]
	movzx rdx, [rsi + rcx]
	sub rax, rdx
	ret

