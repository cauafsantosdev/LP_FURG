#include <stdio.h>
#include <string.h>

int main()
{
    char scale;
    printf("Type [C] to convert for ºC or [F] to convert for ºF: ");
    scanf("%c", &scale);

    if (scale == 'C') {
        float fahrenheit;
        printf("Type the temperature in ºF: ");
        scanf("%f", &fahrenheit);

        float celsius = ((fahrenheit - 32) * 5) / 9;
        printf("%f ºF is %f ºC\n", fahrenheit, celsius);
        return(0);
    }
    else if (scale == 'F') {
        float celsius;
        printf("Type the temperature in ºC: ");
        scanf("%f", &celsius);

        float fahrenheit = (celsius * 9 / 5) + 32;
        printf("%f ºC is %f ºF\n", celsius, fahrenheit);
        return(0);
    }
    else {
        printf("Invalid temperature scale\n");
        return(0);
    }
}