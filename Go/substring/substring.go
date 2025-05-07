package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("Digite uma frase: ")
	phrase, _ := reader.ReadString('\n')
	phrase = strings.TrimSpace(phrase)
	phrase = strings.ToLower(phrase)

	fmt.Print("Insira a substring que quer contar: ")
	substring, _ := reader.ReadString('\n')
	substring = strings.TrimSpace(substring)

	var (
		lower_substring string = strings.ToLower(substring)
		count int
	)

	for i := 0; i <= len(phrase) - len(substring); i ++ {
		if phrase[i:i+len(substring)] == lower_substring {
			count++
		}
	}

	fmt.Printf("A substring \"%s\" aparece %d vezes.\n", substring, count)
}
