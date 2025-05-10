package main

import "fmt"

func lcs(s1, s2 string) string {
	len1, len2 := len(s1), len(s2)
	dp := make([][]int, len1+1)
	for i := range dp {
		dp[i] = make([]int, len2+1)
	}

	for i := 1; i <= len1; i++ {
		for j := 1; j <= len2; j++ {
			if s1[i-1] == s2[j-1] {
				dp[i][j] = dp[i-1][j-1] + 1
			} else if dp[i-1][j] > dp[i][j-1] {
				dp[i][j] = dp[i-1][j]
			} else {
				dp[i][j] = dp[i][j-1]
			}
		}
	}

	i, j := len1, len2
	var seq []rune
	for i > 0 && j > 0 {
		switch {
		case s1[i-1] == s2[j-1]:
			seq = append(seq, rune(s1[i-1]))
			i--
			j--
		case dp[i-1][j] >= dp[i][j-1]:
			i--
		default:
			j--
		}
	}

	for l, r := 0, len(seq)-1; l < r; l, r = l+1, r-1 {
		seq[l], seq[r] = seq[r], seq[l]
	}

	return string(seq)
}

func main() {
	var (
		string1 string = "longestcommonsubsequence"
		string2 string = "strongestcommonsubsequence"
	)

	fmt.Printf("%s\n", lcs(string1, string2))
}
