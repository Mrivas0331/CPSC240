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

section .bss
    buffer resb 4
    sumN resd 1
    n resd 1
    ascii resb 10

section .data
    msg1 db "Input a number (004~999): " ;26 long
    msg2 db "1 + 2 + 3 +...+ " ;16 long
    msg3 db " = " ;3 long

section .text
    global _start

_start:
    print msg1, 26
    scan buffer, 4
    mov ax, 0
    mov bx, 10
    mov rsi, 0 ;functions as counter
inputLoop:
    mov cl, byte[buffer+rsi] 
    and cl, 0fh ;converts ascii to #
    add al, cl
    adc ah, 0 ;make ah = 0
    cmp rsi, 2
    je doneWMult
    mul bx

doneWMult:
    inc rsi
    cmp rsi, 3
    jl inputLoop 
    mov word[n], ax
    mov ecx, 0

sumLoop:
    add dword[sumN], ecx
    inc ecx
    cmp ecx, dword[n]
    jbe sumLoop ;does as much as loop requires
    mov eax, dword[sumN]
    mov rcx, 0
    mov ebx, 10

divisionLoop:
    mov edx, 0
    div ebx
    push rdx ;pushes remainder
    inc rcx
    cmp eax, 0
    jne divisionLoop
    mov rbx, ascii
    mov rdi, 0

popLoop:
    pop rax
    add al, "0"
    mov byte[rbx+rdi], al
    inc rdi
    loop popLoop
    mov byte[rbx+rdi], 10

    print msg2, 16
    print buffer, 3
    print msg3, 3
    print ascii, 7

    mov rax, 60
    mov rdi, 0
    syscall