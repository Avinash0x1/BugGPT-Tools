 ### About:
➼ Generate BurpSuite Configuration file **`scope.json`** (based on Edoardottt's [genscope](https://github.com/edoardottt/lit-bb-hack-tools/tree/main/genscope))     
Major ***differences*** being able to specify input (`-t`), output (`-o`) flags and printing to `stdout`  

### **Installation**
 - **Go**:  `go get -v github.com/Azathothas/BugGPT-Tools/burpscope`

 ### Usage: `burpscope -h`
 ```bash
burpscope -t domains.txt -o burpscope.json
#Or via stdin:
cat domains.txt | burpscope -o burpscope.json
```
 ### Examples: 
 **`cat domains.txt`** [wildcards (**`*.`**) are allowed]
```bash 
example.com
*.example2.com
www.example3.com
*.example4.com
 ```
 Then, **`burpscope -t domains.txt `** will generate **`burpscope.json`** in current directory [use `-o` to specify custom output]
 ```json
{
	"target": {
		"scope": {
			"advanced_mode": true,
			"exclude": [],
			"include": [
				{
					"enabled": true,
					"file": "^/.*",
					"host": "^example\\.com$",
					"port": "^80$",
					"protocol": "http"
				},
				{
					"enabled": true,
					"file": "^/.*",
					"host": "^example\\.com$",
					"port": "^443$",
					"protocol": "https"
				},
				{
					"enabled": true,
					"file": "^/.*",
					"host": "^.*\\.example2\\.com$",
					"port": "^80$",
					"protocol": "http"
				},
				{
					"enabled": true,
					"file": "^/.*",
					"host": "^.*\\.example2\\.com$",
					"port": "^443$",
					"protocol": "https"
				},
				{
					"enabled": true,
					"file": "^/.*",
					"host": "^www\\.example3\\.com$",
					"port": "^80$",
					"protocol": "http"
				},
				{
					"enabled": true,
					"file": "^/.*",
					"host": "^www\\.example3\\.com$",
					"port": "^443$",
					"protocol": "https"
				},
				{
					"enabled": true,
					"file": "^/.*",
					"host": "^.*\\.example4\\.com$",
					"port": "^80$",
					"protocol": "http"
				},
				{
					"enabled": true,
					"file": "^/.*",
					"host": "^.*\\.example4\\.com$",
					"port": "^443$",
					"protocol": "https"
				}
			]
		}
	}
}
 ```
