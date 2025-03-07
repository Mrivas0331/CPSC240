%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
%endmacro

%macro scan 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
%endmacro

section .bss
    buffer resb 4
    n resd 1
    sumN resd 1
    ascii resb 10

section .data
    msg1 db "Input a number (001~140): " ;26long
    msg2 db "1 + 2 + 3 +...+ N = " ;16long

section .text
    global _start

_start:
    print msg1, 26 ;prints msg
    scan buffer, 4 ;takes input
    mov rbx, buffer ;rdx = buffer
    call toInteger
    mov rcx, 0
    mov edi, dword[n] ;edi = sumN
    call calculate
    
    call toString
    print msg2, 16 ;print msg2
    print ascii, 7 ;print sum
    mov rax, 60
    mov rdi, 0
    syscall

toInteger:
    mov rax, 0
    mov rdi, 10
    mov rsi, 0
multiplicationLoop:
    and byte[rbx+rsi], 0fh ;turn ascii to #
    add al, byte[rbx+rsi] 
    adc ah, 0 ;clear ah
    cmp rsi, 2 
    je multiplicationSkip
    mul di
multiplicationSkip:
    inc rsi
    cmp rsi, 3
    jl multiplicationLoop
    mov word[n], ax
    ret

calculate:
sumLoop:
    add dword[sumN], ecx
    inc ecx
    cmp ecx, edi
    jbe sumLoop
    ret

toString:
    mov eax, dword[sumN]
    mov rcx, 0
    mov ebx, 10
divisionLoop:
    mov edx, 0
    div ebx ;div by 10
    push rdx ;pushes remainder
    inc rcx
    cmp eax, 0
    jne divisionLoop
    
    mov rbx, ascii
    mov rdi, 0

popLoop:
    pop rax ;pop digit
    add al, "0"
    mov byte[rbx+rdi], al
    inc rdi
    loop popLoop
    mov byte[rbx+rdi], 10 ;creates newline
    ret
