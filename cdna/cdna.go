package main

import (
	"bufio"
	"fmt"
	"log"
	"net"
	"os"

	"github.com/projectdiscovery/cdncheck"
)

func main() {
	// uses projectdiscovery endpoint with cached data to avoid ip ban
	// Use cdncheck.New() if you want to scrape each endpoint (don't do it too often or your ip can be blocked)
	client, err := cdncheck.NewWithCache()
	if err != nil {
		log.Fatal(err)
	}

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		ipStr := scanner.Text()
		ip := net.ParseIP(ipStr)
		if ip == nil {
			fmt.Printf("%s is not a valid IP address\n", ipStr)
			continue
		}
		found, result, err := client.Check(ip)
		if found && err == nil {
			fmt.Printf("%s\n", result)
		} else if err != nil {
			fmt.Printf("%s: error checking CDN: %v\n", ipStr, err)
		} else {
			fmt.Printf("N/A\n")
		}
	}
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
