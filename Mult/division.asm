section .data
    num1 dq 50000000000
    num2 dd 3333333
    quotient dq 0
    remainder dd 0
section .text
    global _start
_start:
    mov eax, dword[num1]
    mov edx, dword[num1+4]
    div dword[num2]
    mov dword[quotient], eax
    mov dword[remainder], edx
    mov rax, 60
    mov rdi, 0
    syscall