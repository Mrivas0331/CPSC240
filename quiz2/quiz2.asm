section .data
    shortArr dw -3012, 623, -1234, 2345, 3456, 1267, -89, 6232, -231, 0
section .bss
    evenSum resw 1
section .text
    global _start
_start:
    mov rdi, 0
    mov rsi, 0
    mov word[evenSum], 0
    mov bx, 2
doloop:
    cmp word[shortArr + (rsi * 2)], 0     ;checks if at end
    je doneWLoop                    ;if at end, end loop
    jg checkLoop                    ;if positive, restart loop
    mov ax, word[shortArr+ (rsi*2)]                               
    idiv bx                          ;looks for remainder
    cmp dx, 0                       ;compares remainder to 0
    jnz checkLoop                   ;if not 0 (not even), restart loop
    add word[evenSum], ax           ;if 0, even, add to evenSum
    jmp checkLoop                   ;restart loop
checkLoop:
    inc rsi         
    jmp doloop
doneWLoop:
    mov rax, 60
    mov rdi, 0
    syscall


