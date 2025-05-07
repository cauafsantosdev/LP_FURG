package main

import "fmt"

func main() {
	var ( 
	    limit int = -1
	    i int = 0
	)
	
	for {
	    if limit <= 0 {
	        fmt.Print("Insira quantos números ímpares imprimir: ")
	        fmt.Scanf("%d", &limit)
	    } else {
	        break
	    }
	}
	
	for num := 1; i < limit; num++ {
	    if num % 2 != 0 {
	        fmt.Printf("%d ", num)
	        i++
	    }
	}
	fmt.Print("\n")
}