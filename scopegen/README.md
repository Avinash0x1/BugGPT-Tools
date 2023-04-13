### About:
Generates **`.scope`** compatible format for TomNomNom's [Inscope](https://github.com/tomnomnom/hacks/tree/master/inscope)

### **Installation**
 - **Go**:  `go install -v github.com/Azathothas/BugGPT-Tools/scopegen@main`
 ### Usage: `scopegen -h` will display help
 **Examples**: 

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


