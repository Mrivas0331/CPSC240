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
    buffer resb 10
    num1 resb 1
    num2 resb 1
    num3 resb 1
    num4 resb 1
    num5 resb 1
    finalValue resb 1
    sym1 resb 1
    sym2 resb 1
    sym3 resb 1
    sym4 resb 1

section .data
    msg1 db "Enter Operation String: " ;24 long
    msg2 db " = " ;3 long
    ascii db "00", 10

section .text
    global _start

_start:
    print msg1, 24
    scan buffer, 10
;num1
    mov al, byte[buffer+0]
    and al, 0fh ;turn into #
    mov byte[num1], al
;num2
    mov al, byte[buffer+2]
    and al, 0fh ;turn into #
    mov byte[num2], al
;num3
    mov al, byte[buffer+4]
    and al, 0fh ;turn into #
    mov byte[num3], al
;num4
    mov al, byte[buffer+6]
    and al, 0fh ;turn into #
    mov byte[num4], al
;num5
    mov al, byte[buffer+8]
    and al, 0fh ;turn into #
    mov byte[num5], al
;sym1
    mov al, byte[buffer+1]
    mov byte[sym1], al
;sym2
    mov al, byte[buffer+3]
    mov byte[sym2], al
;sym3
    mov al, byte[buffer+5]
    mov byte[sym3], al
;sym4
    mov al, byte[buffer+7]
    mov byte[sym4], al

    mov al, byte[num1]
    mov byte[finalValue], al

;comparing all the symbols to see what operations are needed
    cmp byte[sym1], '+' ;checks if addition
    jne TrySub ;if not try subtraction
    mov dil, byte[finalValue] ;based off in class examples
    mov sil, byte[num2] ;based off in class examples
    call addition ;adds next value to total
    jmp second_sym
TrySub: ;same format used for all following until end
    cmp byte[sym1], '-'
    jne TryMult
    mov dil, byte[finalValue]
    mov sil, byte[num2]
    call subtraction
    jmp second_sym
TryMult: 
    cmp byte[sym1], '*'
    jne TryDiv
    mov dil, byte[finalValue]
    mov sil, byte[num2]
    call multiplication
    jmp second_sym
TryDiv: 
    cmp byte[sym1], '/'
    jne end
    mov dil, byte[finalValue]
    mov sil, byte[num2]
    call division
    jmp second_sym

second_sym:
    cmp byte[sym2], '+' 
    jne TrySub2
    mov dil, byte[finalValue] 
    mov sil, byte[num3] 
    call addition
    jmp third_sym
TrySub2:
    cmp byte[sym2], '-'
    jne TryMult2
    mov dil, byte[finalValue]
    mov sil, byte[num3]
    call subtraction
    jmp third_sym
TryMult2: 
    cmp byte[sym2], '*'
    jne TryDiv2
    mov dil, byte[finalValue]
    mov sil, byte[num3]
    call multiplication
    jmp third_sym
TryDiv2: 
    cmp byte[sym2], '/'
    jne end
    mov dil, byte[finalValue]
    mov sil, byte[num3]
    call division
    jmp third_sym

third_sym:
    cmp byte[sym3], '+' 
    jne TrySub3
    mov dil, byte[finalValue] 
    mov sil, byte[num4] 
    call addition
    jmp fourth_sym
TrySub3:
    cmp byte[sym3], '-'
    jne TryMult3
    mov dil, byte[finalValue]
    mov sil, byte[num4]
    call subtraction
    jmp fourth_sym
TryMult3: 
    cmp byte[sym3], '*'
    jne TryDiv3
    mov dil, byte[finalValue]
    mov sil, byte[num4]
    call multiplication
    jmp fourth_sym
TryDiv3: 
    cmp byte[sym3], '/'
    jne end
    mov dil, byte[finalValue]
    mov sil, byte[num4]
    call division
    jmp fourth_sym

fourth_sym:
    cmp byte[sym4], '+' 
    jne TrySub4
    mov dil, byte[finalValue] 
    mov sil, byte[num5] 
    call addition
    jmp end
TrySub4:
    cmp byte[sym4], '-'
    jne TryMult4
    mov dil, byte[finalValue]
    mov sil, byte[num5]
    call subtraction
    jmp end
TryMult4: 
    cmp byte[sym4], '*'
    jne TryDiv4
    mov dil, byte[finalValue]
    mov sil, byte[num5]
    call multiplication
    jmp end
TryDiv4: 
    cmp byte[sym4], '/'
    jne end
    mov dil, byte[finalValue]
    mov sil, byte[num5]
    call division
    jmp end

end:
    print buffer, 9
    print msg2, 3
    print finalValue, 2
    mov rax, 60
    mov rdi, 0
    syscall

addition:
    mov al, dil
    add al, sil
    mov byte[finalValue], al
    ret
subtraction:
    mov al, dil
    sub al, sil
    mov byte[finalValue], al
    ret
multiplication:
    mov al, dil
    mul sil
    mov byte[finalValue], al
    ret
division:
    mov ah, 0
    mov al, dil
    div sil
    mov byte[finalValue], al
    ret
