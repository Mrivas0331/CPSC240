section .data
    msg1 db "Input a number (1~9) : "
    msg2 db " is a Multiple of 3. "
section .bss
    num resb 1
    buffer resb 4
section .text
    global _start

_start:
    mov r10, 0

loop_process:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, 23
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 2
    syscall

    mov al, byte[buffer]
    and al, 0fh
    mov byte[num], al
    mov bl, 3
    div bl
    cmp ah, 0
    je IsMultiple
    jmp checker

IsMultiple:
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, 21
    syscall
    jmp checker

checker:
    inc r10
    cmp r10, 9
    jl loop_process
    jmp done

done:
    mov rax, 60
    mov rdi, 0
    syscall