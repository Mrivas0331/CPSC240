section .data
    str1 db "1 + 2 + 3 + ... + 99 = "
    sum dw 0
    ascii db "0000", 10
section .text
    global _start

_start:

addLoop:
    add word[sum], cx
    inc cx
    cmp cx, 99 ;loops till 99
    jbe addLoop
    mov rcx, 3
    mov ax, word[sum] ;places ax into sum

nextPart:
    mov dx, 0
    mov bx, 10 ;breaks into ascii value
    div bx
    add byte[ascii + rcx], dl ;stores ascii value
    dec rcx
    cmp rcx, 0 ;goes down till 0
    jge nextPart

    mov rax, 1 ;print string portion
    mov rdi, 1
    mov rsi, str1
    mov rdx, 23
    syscall

    mov rax, 1 ;print ascii rep
    mov rdi, 1
    mov rsi, ascii
    mov rdx, 5
    syscall

    mov rax, 60 ;exiting
    mov rdi, 0
    syscall