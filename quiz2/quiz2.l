     1                                 %line 1+1 quiz2.asm
     2                                 [section .data]
     3 00000000 3CF46F022EFB290980-     shortArr dw -3012, 623, -1234, 2345, 3456, 1267, -89, 6232, -231, 0
     4 00000000 0DF304A7FF581819FF-
     5 00000000 0000               
     6                                 [section .bss]
     7 00000000 <gap>                   evenSum resw 1
     8                                 [section .text]
     9                                 [global _start]
    10                                 _start:
    11 00000000 48C7C700000000          mov rdi, 0
    12 00000007 48C7C600000000          mov rsi, 0
    13 0000000E 66C70425[00000000]-     mov word[evenSum], 0
    14 0000000E 0000               
    15                                 doloop:
    16 00000018 6683BE[00000000]00      cmp word[shortArr + rsi], 0
    17 00000020 7422                    je doneWLoop
    18 00000022 7F1B                    jg checkLoop
    19 00000024 668B86[00000000]        mov ax, word[shortArr+rsi]
    20 0000002B B400                    mov ah, 0
    21 0000002D B302                    mov bl, 2
    22 0000002F 66F7F0                  div ax
    23 00000032 80FC00                  cmp ah, 0
    24 00000035 7508                    jnz checkLoop
    25 00000037 66010425[00000000]      add word[evenSum], ax
    26 0000003F EBFE                    jmp checkLoop
    27                                 checkLoop:
    28 00000041 48FFC6                  inc rsi
    29 00000044 EBD0                    jmp doloop
    30                                 doneWLoop:
    31 00000046 66C70425[00000000]-     mov word[evenSum], 0
    32 00000046 0000               
    33 00000050 48C7C03C000000          mov rax, 60
    34 00000057 48C7C700000000          mov rdi, 0
    35 0000005E 0F05                    syscall
    36                                 
    37                                 
