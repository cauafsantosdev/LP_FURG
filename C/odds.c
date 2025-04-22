#include <stdio.h>

int main() {
    int num;
    printf("How many odd numbers you wanna print? ");
    scanf("%d", &num);
    int i = 0;
    int acc = 1;

    while (i < num){
        if (acc % 2 != 0) {
            printf("%d ", acc);
            acc++;
            i++;
        }
        else {
            acc++;
        }
    }

    printf("\n");
    return(0);
}