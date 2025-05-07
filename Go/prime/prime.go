package main

import "fmt"

func main() {
	var (
		num   int
		prime bool = true
	)
	fmt.Print("Insira um número para verificar se é primo: ")
	fmt.Scanf("%d", &num)

	if num <= 1 {
		fmt.Printf("%d não é um número primo\n", num)
	} else {
		for i := 2; i <= num/2; i++ {
			if num%i == 0 {
				prime = false
				break
			}
		}

		if prime {
			fmt.Printf("%d é um número primo\n", num)
		} else {
			fmt.Printf("%d não é um número primo\n", num)
		}
	}
}
