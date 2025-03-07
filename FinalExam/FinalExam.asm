%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro scan 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

section .data
    msg1 db "Input 1st number (0~9): " ;24 long
    msg2 db "Input 2nd number (0~9): " ;24 long
    msg3 db "Input 3rd number (0~9): " ;24 long
    msg4 db "Sum = " ;6 long
    msg5 db "Quotient = " ;11 long

section .bss
    buffer resb 2
    num1 resb 1
    num2 resb 1
    num3 resb 1
    sum resb 1
    quotient resb 1
    ascii resb 10

section .text
    global _start

_start:
    print msg1, 24 ;prints 1st message
    scan buffer, 2 ;takes 1st message
    mov al, byte[buffer] 
    and al, 0fh ;converts to int
    mov byte[num1], al

    print msg2, 24
    scan buffer, 2
    mov al, byte[buffer]
    and al, 0fh
    mov byte[num2], al

    print msg3, 24
    scan buffer, 2
    mov al, byte[buffer]
    and al, 0fh
    mov byte[num3], al

    mov dil, byte[num1]
    mov sil, byte[num2]
    mov dl, byte[num3]
    mov rcx, sum
    mov rdx, quotient
    call calculate

    mov rax, 60
    mov rdi, 0
    syscall

calculate:
    mov al, dil
    add al, sil
    mov byte[rcx], al
    mov rdi, rcx
    mov rsi, ascii
    call toString
    print msg4, 6
    print ascii, 2

    mov al, dil
    add al, sil
    cmp dl, 0
    je zero_div
    div dl
    mov byte[rdx], al
    mov rdi, rdx
    mov rsi, ascii
    call toString
    print msg5, 11
    print ascii, 2
    ret

zero_div:
    mov byte[rdx], 0
    ret


toString:
    movzx eax, byte[rdi]
    mov rcx, 0
    mov rbx, 10
pushLoop:
    mov edx, 0
    div rbx
    push dx
    inc rcx
    cmp eax, 0
    jne pushLoop
    mov rbx, ascii
    mov rdi, 0
popLoop:
    pop ax
    add al, "0"
    mov byte[rbx+rdi], al
    inc rdi
    loop popLoop
    mov byte[rbx+rdi], 10
    ret