section .data
    num dw 225
    mul_3 dw 0
    other dw 0
section .text
    global _start

_start:
    mov ax, word[num]
    mov dx, 0
    mov cx, 3
    div cx
    cmp dx, 0
    je step_two
    jmp else_block

step_two:
    mov cx, 5
    div cx
    cmp dx, 0
    je else_block
    jmp checks_out

checks_out:
    inc word[mul_3]
    jmp end_prog

else_block:
    inc word[other]
    jmp end_prog

end_prog:
    mov rax, 60
    mov rdi, 1
    syscall