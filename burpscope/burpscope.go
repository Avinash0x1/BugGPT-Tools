package main

import (
	"bufio"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
	"github.com/edoardottt/golazy"
	// "github.com/elliotwutingfeng/go-fasttld"
)

func main() {
	helpPtr := flag.Bool("h", false, "Show usage.")
	inputPathPtr := flag.String("t", "", "Path to file containing a list of (sub)domains (wildcards allowed).")
	outputPathPtr := flag.String("o", "burpscope.json", "Path to Output file (default burpscope.json in $cwd)")

	flag.Parse()

	if *helpPtr {
		help()
	}

	var domains []string
	if *inputPathPtr != "" {
		domains = golazy.RemoveDuplicateValues(golazy.ReadFileLineByLine(*inputPathPtr))
	} else {
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			domains = append(domains, scanner.Text())
		}
	}

	if len(domains) == 0 {
		fmt.Println("Error: no domains provided.")
		os.Exit(1)
	}

	generateDomains(domains, *outputPathPtr)
}

// help shows the usage.
func help() {
	var usage = `Take as input a file containing a list of (sub)domains (wildcards allowed) and produce a BurpSuite Configuration file.
	$> burpscope -t domains.txt -o burpscope.json

	Alternatively, provide the domains via stdin:
	$> cat domains.txt | burpscope -o burpscope.json`

	fmt.Println()
	fmt.Println(usage)
	fmt.Println()
	os.Exit(0)
}

type BurpSuiteConfiguration struct {
	Target Target `json:"target"`
}

type Target struct {
	Scope Scope `json:"scope"`
}

type Scope struct {
	AdvancedMode bool     `json:"advanced_mode"`
	Exclude      []Domain `json:"exclude"`
	Include      []Domain `json:"include"`
}

type Domain struct {
	Enabled  bool   `json:"enabled"`
	File     string `json:"file"`
	Host     string `json:"host"`
	Port     string `json:"port"`
	Protocol string `json:"protocol"`
}

// generateDomains creates the BurpSuiteConfiguration object from the input domains and writes it to the output file.
func generateDomains(input []string, outputPath string) {
	var domains []Domain

	for _, elem := range input {
		domain := "^" + strings.ReplaceAll(strings.ReplaceAll(elem, ".", "\\."), "*", ".*") + "$"
		// Here add logic for hosts.
		dom80 := Domain{Enabled: true, File: "^/.*", Host: domain, Port: "^80$", Protocol: "http"}
		dom443 := Domain{Enabled: true, File: "^/.*", Host: domain, Port: "^443$", Protocol: "https"}
		domains = append(domains, dom80)
		domains = append(domains, dom443)
	}

	var result = BurpSuiteConfiguration{Target: Target{Scope: Scope{AdvancedMode: true, Exclude: []Domain{}, Include: domains}}}

	file, _ := json.MarshalIndent(result, "", "	")

	fmt.Println(string(file)) // Print JSON output to console

	_ = ioutil.WriteFile(outputPath, file, 0644)
}
