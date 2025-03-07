section .data
    num1 dd 300000
    num2 dd 400000
    product dq 0
section .text
    global _start
_start:
    mov eax, dword[num1]
    mul dword[num2]
    mov dword[product], eax
    ;mov dword[product+4], edx

    mov rax, 60
    mov rdi, 0
    syscall