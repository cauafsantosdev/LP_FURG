#include <stdio.h>

int main()
{
    int num;
    printf ("Type a number to see if it is prime: ");
    scanf ("%d",&num);

    if (num <= 2){
        printf("%d Isn't a prime number\n", num);
    }
    else{
        int i;
        for (i=2; i<=num/2; i++){
            if (num % i == 0){
                printf("%d isn't a prime number\n", num);
                return(0);
            }
        }
        printf("%d is a prime number\n", num);
        return(0);
    }
}