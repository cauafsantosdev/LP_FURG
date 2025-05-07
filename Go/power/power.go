package main

import "fmt"

func main() {
	var base int
	fmt.Print("Insira a base: ")
	fmt.Scanf("%d", &base)

	var exp int = -1
	for {
		if exp <= 0 {
			fmt.Print("Insira o expoente (inteiro positivo): ")
			fmt.Scanf("%d", &exp)
		} else {
			break
		}
	}

	var result int = base
	for i := 1; i < exp; i++ {
		result *= base
	}

	fmt.Printf("%d**%d = %d\n", base, exp, result)
}
