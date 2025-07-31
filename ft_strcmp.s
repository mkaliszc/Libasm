section .data

section .text
	extern __errno_location
	global ft_strcmp

ft_strcmp:
	mov rcx, 0
	jmp loop

loop:
	mov al, [rdi + rcx]
	mov dl, [rsi + rcx]
	cmp byte al, dl
	jg return_greater
	jl return_lesser
	cmp byte [rdi + rcx], 0
	je nul_found 
	inc rcx
	jmp loop

nul_found:
	mov rax, 0
	ret

return_greater:
	mov rax, 1
	ret

return_lesser:
	mov rax, -1
	ret
