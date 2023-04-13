package main

import (
	"bufio"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func main() {
	inScope := flag.Bool("in", false, "generate in-scope domains")
	outScope := flag.Bool("os", false, "generate out-of-scope domains")
	filePath := flag.String("t", "", "path to file containing domain list")
	flexScope := flag.Bool("fl", false, "generate flexible scope")
	flag.Parse()

	if !(*inScope || *outScope || *flexScope) {
		fmt.Println("Please specify either -in, -os, or -fl")
		os.Exit(1)
	}

	var input []byte
	var err error
	if *filePath == "" {
		input, err = ioutil.ReadAll(os.Stdin)
		if err != nil {
			fmt.Printf("Error reading from stdin: %v\n", err)
			os.Exit(1)
		}
	} else {
		input, err = ioutil.ReadFile(*filePath)
		if err != nil {
			fmt.Printf("Error reading file %s: %v\n", *filePath, err)
			os.Exit(1)
		}
	}

	var output []string
	scanner := bufio.NewScanner(strings.NewReader(string(input)))
	for scanner.Scan() {
		domain := scanner.Text()
		if *inScope {
			output = append(output, fmt.Sprintf(".*\\.%s$", strings.ReplaceAll(domain, ".", "\\.")))
		} else if *outScope {
			output = append(output, fmt.Sprintf("!.*%s$", strings.ReplaceAll(domain, ".", "\\.")))
		} else if *flexScope {
			rootDomain := strings.Split(domain, ".")[0]
			if !strings.ContainsAny(rootDomain, ".") {
				output = append(output, fmt.Sprintf(".*%s.*", strings.ReplaceAll(rootDomain, ".", "\\.")))
			}
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Printf("Error reading input: %v\n", err)
		os.Exit(1)
	}

	// Remove duplicates
	output = removeDuplicates(output)

	fmt.Println(strings.Join(output, "\n"))
}

// Helper function to remove duplicates from a string slice
func removeDuplicates(slice []string) []string {
	seen := make(map[string]bool)
	j := 0
	for _, val := range slice {
		if seen[val] {
			continue
		}
		seen[val] = true
		slice[j] = val
		j++
	}
	return slice[:j]
}