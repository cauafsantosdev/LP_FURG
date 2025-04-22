#include <stdio.h>

int main()
{
    int num;
    printf ("Type a number to see its factorial: ");
    scanf ("%d",&num);
    int i = num - 1;
    int result = num;

    for (i; i>=1; i--) {
        result *= i;
    }

    printf("The factorial of %d is %d\n", num, result);
    return(0);
}
