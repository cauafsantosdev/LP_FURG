%INCLUDE "io.inc"

SECTION .data
num        DD 5 ; number of odd numbers to print
odd_number DD 1 ; first odd number (1)

SECTION .text
global CMAIN
CMAIN:
    MOV EAX, [num]        ; EAX = n (how many odd numbers to print)
    MOV EBX, 0            ; EBX = counter, starts from 0
    MOV ECX, [odd_number] ; ECX = first odd number (1)

print_loop:
    PRINT_UDEC 4, ECX     ; print the current odd number
    PRINT_CHAR 10         ; print a new line

    ADD ECX, 2            ; increment ECX by 2 (next odd number)
    MOV EAX, EBX          ; move counter (EBX) to EAX for comparison
    ADD EAX, 1            ; increment EAX by 1
    MOV EBX, EAX          ; store updated counter in EBX
    CMP EBX, [num]        ; compare counter (EBX) with n
    JL print_loop         ; if EBX < n, continue the loop

    MOV EAX, 0            ; return 0 (success)
    RET
