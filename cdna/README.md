### Deprecated: This is now deprecated since the release of [**cdncheck** v1.0.0](https://github.com/projectdiscovery/cdncheck/releases/tag/v1.0.0)
---

<img src="https://user-images.githubusercontent.com/58171889/232501093-32a48356-281b-4f16-9dbb-f15b4421edf8.gif" width="400" height="300">

### About:
A small utility to ***fetch*** , ***check*** & ***list*** **`CDN IPs`** using [**cdncheck**](https://github.com/projectdiscovery/cdncheck).                                                           
This is ***different*** than [**ipcdn**](https://github.com/six2dez/ipcdn) as it ***directly communicates*** with [**cdn.nuclei.sh**](https://cdn.nuclei.sh/) and doesn't rely on cached ip-ranges. 

### **Installation**:
```bash 
go install -v github.com/Azathothas/BugGPT-Tools/cdna@main
``` 
### **Updating**: using [gup](https://github.com/nao1215/gup)
```bash
#Install & set up gup
go install -v github.com/nao1215/gup@latest && gup completion && exec "$SHELL"
#Update cdna
gup update cdna
```
### Usage:
`cdna -h`
```bash 
Usage: cdna [OPTIONS]
Options:
  -i    path to input file containing IP addresses
  -n    only print IPs that don't have a CDN
  -sc   suppress all output colors
```

### Examples: 
 - Quickly get **`IP:CDN`**
```bash
cdna -i ip-addr.txt 	
#Or via stdin
cat ip-addr.txt | cdna
```
![image](https://user-images.githubusercontent.com/58171889/232415653-a076a836-bce6-47e9-bf8c-b6166f647af8.png)
 - Print only **`IPs`** with ***`no CDNs`***
```bash 
cat ip-addr.txt | cdna -n
```
![image](https://user-images.githubusercontent.com/58171889/232415863-249ce264-c0d5-4839-a034-eaf7252cfb9f.png)
 - Print **`IP:CDNs`** only
```bash
cat ip-addr.txt | cdna | grep -v N/A
#or just the CDN Ips
cat ip-addr.txt | cdna | grep -v N/A | awk -F':' '{print $1}'
```
 - CIDR using [**`mapcidr`**](https://github.com/projectdiscovery/mapcidr)
 ```bash
cat /tmp/cidr-ranges.txt | mapcidr -silent | cdna 
 ```
 ![image](https://user-images.githubusercontent.com/58171889/232421086-1058837c-a084-473b-bada-a39e7782973e.png)

### Afterthoughts:
 - **cdna** is desgned and coded to be used to do simple things and do it well. I am sure there are better tools out there. 
    > For instance, I personally use [**cut-cdn**](https://github.com/ImAyrix/cut-cdn) to quickly list non-cdn IPs.

