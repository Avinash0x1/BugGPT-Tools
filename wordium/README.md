<img src="https://user-images.githubusercontent.com/58171889/232502216-cff949a2-aa18-4d6e-bc74-674ab6deaff1.gif" width="220" height="220">

```bash
        ╭┳╮
╭┳┳┳━┳┳┳╯┣╋┳┳━━╮
┃W┃O┃R╭┫D┃I┃U┃M┃ : Wordlist Fetcher & Updater
╰━━┻━┻╯╰━┻┻━┻┻┻╯
```
### About:
A dirty utility to fetch, create & update fuzzing wordlists

### **Installation**:
 - **Bash**: 
```bash
sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/wordium/wordium.sh -O /usr/local/bin/wordium && sudo chmod +xwr /usr/local/bin/wordium && wordium --help
``` 
### Usage:
`wordium --help`
```bash

        ╭┳╮
╭┳┳┳━┳┳┳╯┣╋┳┳━━╮
┃W┃O┃R╭┫D┃I┃U┃M┃
╰━━┻━┻╯╰━┻┻━┻┻┻╯

➼ Usage: wordium -w </path/to/your/wordlist/directory> 

Extended Help
-w,  --wordlist-dir     Specify where to create your wordlists (Required, else specify as $WORDLIST in $ENV:VAR)
-q,  --quick            Quick Mode [Only Use if not first time]
-up, --update           Update wordium
```
### Currently Tracked Wordlists:
```bash
 ~ >  70K --> https://github.com/reewardius/bbFuzzing.txt
 ~ >   5K --> https://github.com/Bo0oM/fuzz.txt
 ~ > 180K --> https://github.com/thehlopster/hfuzz
 ~ > 1.8K --> https://github.com/ayoubfathi/leaky-paths
 ~ > 760K --> https://github.com/six2dez/OneListForAll
 ~ > 1.1M --> https://github.com/rix4uni/WordList
```
### Optimal Goal
```bash

 x-api.txt       --> ~ < 100K [Everything API]
 x-api-tiny.txt  --> ~ <  20K [Top Paths || Objects || Verbs]
 x-dns.txt       --> ~ < 100K [Fuzz || Permutate Subdomains]
 x-dns-tiny.txt  --> ~ <  20K [Most Common Subdomains]
 x-mini.txt      --> ~ <  15K [Juicy || Leaky Paths]
 x-lhf-mini.txt  --> ~ <  50K [Top Low Hanging Fruits]
 x-lhf-mid.txt   --> ~ < 100K [Low Hanging Fruits Medium]
 x-lhf-large.txt --> ~ < 500K [Low Hanging Fruits Comprehensive]
 x-massive.txt   --> ~ <   1M [Low Hanging Fruits All]
```
### Some Tips:
1. You want to add a new word to the wordlist? [Example: /api/v1/graphql]
```bash
#Make sure you remove `/` unless intended of course!
echo "api/v1/graphql" | anew $WORDLIST/x-lhf-mini.txt
```
> Used anew (so only adds new entries) and x-lhf-mini (because, it's automagically added, sorted in all other wordlists)
```bash
#And now run
wordium -w $/path/to/WORDLIST
```
![Demo](https://github.com/Azathothas/BugGPT-Tools/blob/main/wordium/assets/wordium-demo.png)
