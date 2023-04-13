### About:
➼ Generates **`.scope`** compatible format for [**ScopeView**](https://github.com/Azathothas/BugGPT-Tools/tree/main/scopeview) (based on TomNomNom's [Inscope](https://github.com/tomnomnom/hacks/tree/master/inscope))                                              
➼ [**BurpScope**](https://github.com/Azathothas/BugGPT-Tools/tree/main/burpscope) (based on Edoardottt's [genscope](https://github.com/edoardottt/lit-bb-hack-tools/tree/main/genscope)) is a similar tool for generating **Burpsuite**'s `scope.json`
### **Installation**
 - **Go**:  `go install -v github.com/Azathothas/BugGPT-Tools/scopegen@main`
 
### Usage: `scopegen -h` 
 
 ```bash
Usage: scopegen [OPTIONS]
Options:
  -in           generate in-scope domains
  -os           generate out-of-scope domains
  -t            path to file containing domain list
  -wl           generate wildcard in-scope domains
Examples:
cat domains.txt | scopegen -in           # Generate in-scope domains 
cat domains.txt | scopegen -wl           # Generate wildcard in-scope domains
cat domains.txt | scopegen -os           # Generate wildcard out-of-scope domains
 ```
 **Additional examples**: 

 `cat inscope-domains.txt`
```bash 
 example.com
 example.org
 abc.example.com
 ```
 `cat outscope-domains.txt`
 ```bash
 oos.example.com
 oos.abc.example.org
 ```
 Then, **`scopegen -t inscope-domains.txt -in`** will generate **`inscope`**  domains:
 ```bash
 .*\.example\.com$
.*\.example\.org$
.*\.abc\.example\.com$
 ```
 and, **`scopegen -t inscope-domains.txt -wl`** will generate **`wildcard`** **inscope** domains:
  ```bash
.*example.*
.*abc.*
 ```
 similarly, **`scopegen -t outscope-domains.txt -os`** will generate **`outscope`**  domains:
 ```bash
!.*oos\.example\.com$
!.*oos\.abc\.example\.org$
 ```

 you can also pass **`stdin`**: 
```bash 
cat [inscope|outscope]-domains.txt | scopegen [-in | -wl | -os]
#or as echo
echo "example.com" | scopegen [-in | -wl | -os]
```


