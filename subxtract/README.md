```bash
╔═╗ ╔╗  ╔╗       ╔╗
║═╬╦╣╚╦╦╣╚╦╦╦═╗╔═╣╚╗
╠s║u║b╠X╣t╣r╣a╚╣c╣t╣ : Public-Suffix based TLDs (Top-Level-Domains) & Subdomains extractor 
╚═╩═╩═╩╩╩═╩╝╚══╩═╩═╝
```
### About:
 Wrapper around [go-fasttld](https://github.com/elliotwutingfeng/go-fasttld) for extracting **`TLD`** (Top-Level-Domains) & **`Subdomains`** using ***accurate*** and ***always-uptodate*** `public-suffix` list from **domains**, **urls**, **ipv4**, **ipv6**, etc.  

Used as a helper utility in tools like [Scopegen](https://github.com/Azathothas/BugGPT-Tools/tree/main/scopegen) & [Burpscope](https://github.com/Azathothas/BugGPT-Tools/tree/main/burpscope) to generate scopes, among other places.
### **Installation**:
 - **Bash**: 
```bash
sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/subxtract/subxtract.sh -O /usr/local/bin/subxtract && sudo chmod +xwr /usr/local/bin/subxtract && subxtract --help
``` 
### Usage:
`subxtract --help`
```bash
╔═╗ ╔╗  ╔╗       ╔╗
║═╬╦╣╚╦╦╣╚╦╦╦═╗╔═╣╚╗
╠s║u║b╠X╣t╣r╣a╚╣c╣t╣
╚═╩═╩═╩╩╩═╩╝╚══╩═╩═╝

➼ Usage: subxtract -i </path/to/domain/urls.txt> 

Extended Help:
-i,  --input     Specify input file containing domains or urls (Required)
                 else stdin: cat domains.txt | subxtract

-s,  --subs      Extract Subdomains only (default: false)
-up, --update    Update subxtract
```
### Examples:
**`cat domains.txt`** [You can also pass `urls`, doesn't really matter] [Don't pass wildcards `(.*)`]
```bash
abc.example.com
abc.example.net
apple.com
be.banana.com
example.com
example.com.np
example.net
example.org
xyz.abc.example.com
xyz.abc.example.net
```
 Then, **`subxtract -i domains.txt | sed '/^$/d'`** will extract **`Root Domains`**:  [**use `sed '/^$/d'`** as output often has empty /n]
 ```bash
example
apple
banana
 ```
 similarly, **`subxtract -i domains.txt -s`** will extract **`subdomains`** along with **`TLDs`**: [**use `sed '/^$/d'`** as output often has empty /n]
  ```bash
example.com
example.net
apple.com
banana.com
example.com.np
example.org
 ```


