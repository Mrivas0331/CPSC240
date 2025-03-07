section .data
    array dw 12, 1003, 6543, 24680, 789, 30123, 32766
section .bss
    even resw 7
section .text
    global _start
_start:
    mov rsi, 0
    mov rdi, 0
doloop:
    mov ax, [array + rsi * 2]
    test ax, 1
    jnz check_loop
    mov [even + rdi * 2], ax
    inc rdi
    jmp check_loop
check_loop:
    inc rsi
    cmp rsi, 7
    jg end_loop
    jmp doloop
end_loop:
    mov rax, 60
    mov rdi, 0
    syscall
