section .data
    num1 dw 50000
    num2 dw 30000
    num3 dw 60000
    sum dd 0
    product dq 0


section .text
    global _start
_start:
    mov dx, 0
    mov ax, word[num1]
    add ax, word[num2]
    adc dx, 0
    mov word[sum], ax
    mov word[sum+2], dx

    mov eax, dword[num3]
    mov edx, dword[num3+2]
    mul dword[sum]
    mov dword[product], eax
    mov dword[product+4], edx 

    mov rdx, 60
    mov rdi, 0
    syscall

