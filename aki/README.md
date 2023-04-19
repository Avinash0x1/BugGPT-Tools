<img src="https://user-images.githubusercontent.com/58171889/233020776-156788d9-de04-40c9-a1b2-87e264373298.gif" width="250" height="150">

 ```bash
 
  _  |  o 
(_| |< |  : Api Key | Tokens validator 

```
### About:
`Api Key` | `Token` checker & validator for [**amass**](https://github.com/owasp-amass/amass/blob/master/doc/user_guide.md#the-configuration-file) | [**subfinder**](https://github.com/projectdiscovery/subfinder#post-installation-instructions) | [**github**](https://github.com/gwen001/github-endpoints) & [**gitlab**](https://github.com/gwen001/gitlab-subdomains)

### **Installation**:
```bash 
sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/aki.sh -O /usr/local/bin/aki && sudo chmod +xwr /usr/local/bin/aki && aki --help
``` 

### **Considerations**:
 - **Amass**: Your `config.ni` must be properly indentated and formatted. [Default: `$HOME/.config/amass/config.ini`]
 ```ini
[data_sources.Example]
[data_sources.Example.Credentials]
#As you can see this is a comment. Comments are allowed (must start with #) and are ignored when parsing 
#New line should have no space, and there should be only 1 space where space is needed:
apikey = example-api-key-notice-there-is-space-between-equal-sign
apikey = also-notice-everything-is-in-lowercase
#for usernames, passwords, secrets, follow same rules
username = same-for-usernames-only-1-space-between-eequals-and-everything-lower-case
password = same-for-passwords-only-1-space-between-eequals-and-everything-lower-case
secret = same-for-secret-only-1-space-between-eequals-and-everything-lower-case
#Please view amass's official config file and follow it: https://github.com/owasp-amass/amass/blob/master/examples/config.ini
#Uncomment and fill in you details where it's needed
#By default, amass config.ini will be located at: $HOME/.config/amass/config.ini
```
- **Subfinder**: Your `provider-config.yaml` must be properly indentated and formatted. [Default: `$HOME/.config/subfinder/provider-config.yaml`]
```YAML
#Comments will be ignored. And valid root element line must have no spaces at beginning or ending, and must end with : 
example:
  - yaml-starts-with-2-spaces-then-dash-then-1-space-then-value
  - the-space-is-very-important-so-please-double-check-or-use-https://www.yamllint.com/
  - The-script-uses-yq-to-validate-and-parse-and-will-exit-if-it-fails
  - when-you-have-multiple-values-such-as-key-secret-or-username-password-put-them-on-single-line-separated-by-colon
  - username:password
  - key-secret
  - follow-default-config-example-https://www.yamllint.com/
#Default config file: $HOME/.config/subfinder/provider-config.yaml
#Note that, it's `provider-config.yaml` & NOT `config.yaml`
```
- **Github Tokens**: Your `.github_tokens` must be properly indentated and formatted (**1** token **per line**). [Default: `$HOME/.config/.github_tokens`]
```TXT
ghp_yourtoken_value
gph_one_token_per_line
ghp_DO_NOT_include_comments_here
```
- **Gitlab Tokens**: Your `.gitlab_tokens` must be properly indentated and formatted (**1** token **per line**). [Default: `$HOME/.config/.gitlab_tokens`]
```bash
glpat-yourtoken_value
glpat_one_token_per_line
glpat_DO_NOT_include_comments_here
```
### Usage:
`aki --help`
```bash
➼ Usage: aki -a <your/amass/config.ini> -s <your/subfinder/provider-config.yaml>

➼ Extended Help :

➼ By default $HOME/.config/amass/config.ini will be used
  To change it use:
                   -a,  --amass     <your/amass/config.ini>

➼ By default $HOME/.config/subfinder/provider-config.yaml will be used
  To change it use:
                   -s,  --subfinder     <your/subfinder/provider-config.yaml>
Optional flags :
 -gh,  --github     <github_tokens_file> (1 per line) [Default: $HOME/.config/.github_tokens]
 -gl,  --gitlab     <gitlab_tokens_file> (1 per line) [Default: $HOME/.config/.gitlab_tokens]
```

### Currently Checked Keys & Tokens:
```yaml
ASNLookup
```











