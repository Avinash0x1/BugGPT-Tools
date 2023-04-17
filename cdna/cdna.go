package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"net"
	"os"
    // "os/exec"

	"github.com/fatih/color"
	"github.com/projectdiscovery/cdncheck"
)

func main() {
	//flags
	inputPtr := flag.String("i", "", "path to input file containing IP addresses")
	noCDNPtr := flag.Bool("n", false, "only print IPs that don't have a CDN")
	noColorPtr := flag.Bool("sc", false, "suppress output colors")
	flag.Usage = func() {
		var usage = `Options:
  -i    path to input file containing IP addresses
  -n    only print IPs that don't have a CDN
  -sc   suppress all output colors

Examples:

Quickly get IP:CDN          :: ➼ cdna -i ip-addr.txt 	
Or via stdin                :: ➼ cat ip-addr.txt | cdna
Print only ips with no cdns :: ➼ cat ip-addr.txt | cdna -n
More: https://github.com/Azathothas/BugGPT-Tools/tree/main/cdna
`	
		fmt.Fprintf(os.Stderr, "Usage: %s [OPTIONS]\n", os.Args[0])
		fmt.Fprintln(os.Stderr, usage)
	}
	
	flag.Parse()
    // Colors
	blue := color.New(color.FgBlue).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()
	orange := color.New(color.FgHiYellow).SprintFunc()
   //gup update function
   // ensureGupInstalled()
   // fmt.Println(string(out))
	//main functions
	var scanner *bufio.Scanner
	if *inputPtr != "" {
		file, err := os.Open(*inputPtr)
		if err != nil {
			log.Fatal(err)
		}
		defer file.Close()
		scanner = bufio.NewScanner(file)
	} else {
		scanner = bufio.NewScanner(os.Stdin)
	}

	// uses projectdiscovery endpoint with cached data to avoid ip ban
	// Use cdncheck.New() if you want to scrape each endpoint (don't do it too often or your ip can be blocked)
	client, err := cdncheck.NewWithCache()
	if err != nil {
		if !*noColorPtr {
			color.Red("! Error contacting cdn.nuclei.sh")
			color.Red("! Either the cdn provider is down or your internet is")
		} else {
			fmt.Println("! Error contacting cdn.nuclei.sh")
			fmt.Println("! Either the cdn provider is down or your internet is")
		}
		return
	}

	for scanner.Scan() {
		ipStr := scanner.Text()
		ip := net.ParseIP(ipStr)
		if ip == nil {
			if !*noColorPtr {
				color.Red("%s is not a valid IP address", ipStr)
			} else {
				fmt.Printf("%s is not a valid IP address\n", ipStr)
			}
			continue
		}
		found, result, err := client.Check(ip)
		if found && err == nil {
			if *noCDNPtr {
				if result == "" {
					if !*noColorPtr {
						color.Green("%s", ipStr)
					} else {
						fmt.Println(ipStr)
					}
				}
				continue
			}
			if result != "" {
				if !*noColorPtr {
					fmt.Printf("%s:%v\n", blue(ipStr), orange(result))
				} else {
					fmt.Printf("%s:%v\n", ipStr, result)
				}
			} else {
				if !*noColorPtr {
					color.Blue("%s", ipStr)
				} else {
					fmt.Println(ipStr)
				}
			}
		} else if err != nil {
			if !*noColorPtr {
				color.Red("! Error contacting cdn.nuclei.sh")
			} else {
				fmt.Println("! Error contacting cdn.nuclei.sh")
			}
			return
		} else {
			if *noCDNPtr {
				if !*noColorPtr {
					color.Green("%s", ipStr)
				} else {
					fmt.Println(ipStr)
				}
				continue
			}
			if !*noColorPtr {
				fmt.Printf("%s:%v%s\n", blue(ipStr), orange(result), green("N/A"))
			} else {
				fmt.Printf("%s:%vN/A\n", ipStr, result)
			}
		}
	}
	
    if err := scanner.Err(); err != nil {
        log.Println("! Error processing Input:", err)
        log.Println("Double check your input")        
        return
    }
}
//check for updates
// func ensureGupInstalled() {
//     cmd := exec.Command("gup", "version")
//     if err := cmd.Run(); err != nil {
//         fmt.Println("gup not found, installing...")
//         installCmd := exec.Command("go", "install", "-v", "github.com/nao1215/gup@latest")
//         if err := installCmd.Run(); err != nil {
//             fmt.Printf("error installing gup: %v\n", err)
//             os.Exit(1)
//         }
//     }
// }
