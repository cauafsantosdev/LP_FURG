%INCLUDE "io.inc"

SECTION .data
number DD 23  ; the number to be tested
is_prime DD 1 ; assume the number is prime (1 = true, 0 = false)

SECTION .text
global CMAIN
CMAIN:
    MOV EAX, [number]     ; EAX = number
    CMP EAX, 2            ; if number < 2, it is not prime
    JL not_prime

    MOV ECX, 2            ; ECX = divisor starting at 2

check_loop:
    MOV EBX, [number]     ; EBX = number to divide
    MOV EDX, 0            ; clear EDX before division
    DIV ECX               ; EAX = EBX / ECX, EDX = EBX % ECX

    CMP EDX, 0            ; if remainder == 0, number is not prime
    JE not_prime

    MOV EAX, ECX          ; move divisor into EAX
    ADD EAX, 1            ; increment divisor by 1
    MOV ECX, EAX          ; update ECX with the new divisor
    MOV EAX, [number]     ; reload number into EAX for comparison
    CMP ECX, EAX          ; if ECX == number, end loop
    JL check_loop

    JMP end               ; if no divisors found, number is prime

not_prime:
    MOV [is_prime], DWORD 0  ; set result to false (0)

end:
    PRINT_UDEC 4, [is_prime] ; print result (1 = prime, 0 = not prime)
    PRINT_CHAR 10            ; newline

    MOV EAX, 0
    RET
