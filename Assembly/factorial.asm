%INCLUDE "io.inc"

SECTION .data
num DD 5  ; number to calculate factorial
fact DD 1 ; variable to store the result

SECTION .text
global CMAIN
CMAIN:
    MOV ECX, [num]       ; ECX = counter from 5 to 1
    MOV EAX, 1           ; EAX = factorial accumulator

loop_factorial:
    MUL ECX              ; EAX = EAX * ECX
    LOOP loop_factorial  ; decrement ECX and repeat while ECX != 0

    MOV [fact], EAX      ; store the result in fact

    PRINT_UDEC 4, [fact] ; display the result
    PRINT_CHAR 10        ; print newline

    MOV EAX, 0
    RET
