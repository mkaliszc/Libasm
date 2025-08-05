section .data

section .text
	global ft_atoi_base
	extern ft_strlen


; * Parsing function's
validate_base:
	cmp rsi, 0
	je error

	mov rdi, rsi

	call ft_strlen
	cmp rax, 2
	jl error
	mov r15, rax

	xor rcx, rcx
	call check_whitespace
	cmp rax, 0
	je exit

	xor rcx, rcx
	call check_dup
	cmp rax, 0
	je exit

	mov rcx, 0
	call check_special_char
	cmp rax, 0
	je exit

check_dup:
	cmp byte [rdi + rcx], 0
	je step_successs

	mov rdx, rcx           
	inc rdx
	jmp inner_loop

inner_loop:
	cmp byte [rdi + rdx], 0
	je next_char

	mov al, [rdi + rcx]
	cmp al, [rdi + rdx]
	je error

	inc rdx
	jmp inner_loop

next_char:
	inc rcx
	jmp check_dup

check_whitespace: ; * Loop to check for wwhitespace in the base
	cmp byte [rdi + rcx], 0
	je step_successs

	cmp byte [rdi + rcx], 32
	je error

	cmp byte [rdi + rcx], 9
	je error

	cmp byte [rdi + rcx], 10
	je error

	cmp byte [rdi + rcx], 11
	je error

	cmp byte [rdi + rcx], 12
	je error

	cmp byte [rdi + rcx], 13
	je error

	inc rcx
	jmp check_whitespace

check_special_char:
	cmp byte [rdi + rcx], 0
	je step_successs

	cmp byte [rdi + rcx], 43
	je error

	cmp byte [rdi + rcx], 45
	je error

	inc rcx
	jmp check_special_char

step_successs: 
	mov rax, 1
	ret

; * main function's
	
ft_atoi_base: ; rdi = str , rsi = base
	push rdi
	call validate_base

	cmp rax, 0
	je exit

	mov rsi, rdi
	pop rdi

	xor rcx, rcx
	xor rax, rax
	mov r8w, 1 ; start at 1 if there is no sign in str

	jmp atoi_loop

atoi_loop:
	mov r11b, [rdi + rcx]
	cmp byte r11b, 0
	je apply_sign

	cmp byte r11b, 43
	je handle_plus

	cmp byte r11b, 45
	je handle_sub

	jmp handle_char

not_find:
	mov r11, -1
	ret

find:
	mov r11, rdx
	ret

find_char_in_base: ; we search for the base index and stock it in r11b 
	cmp byte [rsi + rdx], 0
	je not_find

	cmp byte [rsi + rdx], r11b
	je find

	inc rdx
	jmp find_char_in_base

; Function to handle each atoi case

handle_plus:
	inc rcx
	mov r8w, 1
	jmp atoi_loop

handle_sub:
	inc rcx
	mov r8w, -1
	jmp atoi_loop

handle_char:
	xor rdx, rdx
	call find_char_in_base
	cmp r11, -1

	je apply_sign
	mul r15
	add rax, r11
	inc rcx
	jmp atoi_loop


; * return function

apply_sign:
	cmp r8w, -1
	jne exit
	neg rax
	jmp exit

error:
	pop rdi
	mov rax, 0
	ret

exit:
	ret