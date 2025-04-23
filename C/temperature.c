#include <stdio.h>
#include <string.h>

int main()
{
    char scale;
    printf("Type [C] to convert for ºC or [F] to convert for ºF: ");
    scanf("%c", &scale);

    if (scale == 'C' || scale == 'c') {
        float fahrenheit;
        printf("Type the temperature in ºF: ");
        scanf("%f", &fahrenheit);

        float celsius = ((fahrenheit - 32) * 5) / 9;
        printf("%.1f ºF is %.1f ºC\n", fahrenheit, celsius);
        return(0);
    }
    else if (scale == 'F' || scale == 'f') {
        float celsius;
        printf("Type the temperature in ºC: ");
        scanf("%f", &celsius);

        float fahrenheit = (celsius * 9 / 5) + 32;
        printf("%.1f ºC is %.1f ºF\n", celsius, fahrenheit);
        return(0);
    }
    else {
        printf("Invalid temperature scale\n");
        return(0);
    }
}