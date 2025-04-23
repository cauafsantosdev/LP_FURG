#include <stdio.h>
#include <string.h>
#include <ctype.h>

void lower(char *str) {
    for (int i=0; str[i]; i++) {
        str[i] = tolower((unsigned char)str[i]);
    }
}

int main() {
    char string[100];
    printf("Type a string: ");
    fgets(string, sizeof(string), stdin);
    string[strcspn(string, "\n")] = 0;
    
    char substring[47];
    printf("Which substring do you wanna count? ");
    fgets(substring, sizeof(substring), stdin);
    substring[strcspn(substring, "\n")] = 0;

    int count = 0;

    for (int i=0; i <= strlen(string) - strlen(substring); i++) {
        char test[strlen(substring) + 1];
        strncpy(test, string + i, strlen(substring));
        test[strlen(substring)] = '\0';

        char test_lower[strlen(test)];
        char sub_lower[strlen(substring)];
        strcpy(test_lower, test);
        strcpy(sub_lower, substring);

        lower(test_lower);
        lower(sub_lower);

        if (strcmp(test_lower, sub_lower) == 0) {
            count++;
        }
    }
    printf("The substring \"%s\" appears %i times on the phrase\n", substring, count);
    return(0);
}