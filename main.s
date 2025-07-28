section .data
    test_string db 'test1', 0
    result_char db '0'
    newline db 10, 0

section .bss
    copy_str resb 20 

section .text
    extern ft_strlen
    extern ft_strcpy
    extern ft_write
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, test_string
    mov rdx, 5
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

; * ft_strlen * 

    mov rdi, test_string
    call ft_strlen

    add rax, '0'
    mov [result_char], al
    
    mov rax, 1
    mov rdi, 1
    mov rsi, result_char
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

; * ft_strcpy + ft_write*

    mov rdi, copy_str
    mov rsi, test_string
    call ft_strcpy

    mov rax, 1
    mov rdi, 1
    mov rsi, copy_str
    mov rdx, 5
    call ft_write

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    
    mov rax, 60
    mov rdi, 0
    syscall