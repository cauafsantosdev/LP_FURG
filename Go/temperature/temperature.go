package main

import (
	"fmt"
	"strings"
)

func main() {
	var (
		mode string = ""
		temperature float64
	)

	for {
		if mode != "C" && mode != "F" {
			fmt.Print("[C] para converter para ºC ou [F] para converter para ºF: ")
			fmt.Scanf("%s", &mode)
			mode = strings.ToUpper(mode)
		} else {
			break
		}
	}

	if mode == "C" {
		fmt.Print("Insira a temperatura em ºF: ")
		fmt.Scanf("%f", &temperature)

		var converted = ((temperature - 32) * 5) / 9
		fmt.Printf("%.1f ºF = %.1f ºC\n", temperature, converted)
	} else {
		fmt.Print("Insira a temperatura em ºC: ")
		fmt.Scanf("%f", &temperature)

		var converted = temperature * 9 / 5 + 32
		fmt.Printf("%.1f ºC = %.1f ºF\n", temperature, converted)
	}
}