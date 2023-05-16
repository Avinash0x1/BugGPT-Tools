<img src="https://user-images.githubusercontent.com/58171889/233020776-156788d9-de04-40c9-a1b2-87e264373298.gif" width="250" height="150">

 ```bash
  _  |  o 
(_| |< |  : Api Key | Tokens validator 
```
### About:
`Api Key` | `Token` checker & validator for [**amass**](https://github.com/owasp-amass/amass/blob/master/doc/user_guide.md#the-configuration-file) | [**subfinder**](https://github.com/projectdiscovery/subfinder#post-installation-instructions) | [**github**](https://github.com/gwen001/github-endpoints) & [**gitlab**](https://github.com/gwen001/gitlab-subdomains)                                                                                                                           
This is achieved using [**`curl`**](https://github.com/curl/curl) + [**`jq`**](https://github.com/stedolan/jq) + [**`yq`**](https://github.com/mikefarah/yq) and querying a less resourceful api endpoint for each service.

### **Installation**:
```bash 
sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/aki.sh -O /usr/local/bin/aki && sudo chmod +xwr /usr/local/bin/aki && aki --help
``` 
 - **`aki`** will try to install `jq` & `yq` if they aren't installed. You will get errors:
 ```bash
 ✘ Error: /home/sparrow/.config/subfinder/provider-config.yaml is not a valid YAML
 ```
 - In case it fails, try installing manually:
 ```YAML
 JQ : https://github.com/stedolan/jq/wiki/Installation
 Linux: sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq && sudo chmod +xwr /usr/local/bin/yq
 YQ : https://github.com/mikefarah/yq/#install
 ```
### **Considerations**:
 - **Amass**: Your `config.ini` must be properly indentated and formatted. [Default: `$HOME/.config/amass/config.ini`]
 > ***Example*** : https://github.com/Azathothas/BugGPT-Tools/blob/main/aki/Examples/.config/amass/config.ini
 ```ini
[data_sources.Example]
[data_sources.Example.Credentials]
#As you can see this is a comment. Comments are allowed (must start with #) and are ignored when parsing 
#New line should have no space, and there should be only 1 space where space is needed:
apikey = example-api-key-notice-there-is-space-between-equal-sign
apikey = also-notice-everything-is-in-lowercase
#for usernames, passwords, secrets, follow same rules
username = same-for-usernames-only-1-space-between-equal-and-everything-lower-case
password = same-for-passwords-only-1-space-between-equal-and-everything-lower-case
secret = same-for-secret-only-1-space-between-equal-and-everything-lower-case
#Please view amass's official config file and follow it: https://github.com/owasp-amass/amass/blob/master/examples/config.ini
#Uncomment and fill in you details where it's needed
#By default, amass config.ini will be located at: $HOME/.config/amass/config.ini
```
- **Subfinder**: Your `provider-config.yaml` must be properly indentated and formatted. [Default: `$HOME/.config/subfinder/provider-config.yaml`]
> ***Example*** : https://github.com/Azathothas/BugGPT-Tools/blob/main/aki/Examples/.config/subfinder/provider-config.yaml
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
```console
ghp_yourtoken_value
gph_one_token_per_line
ghp_DO_NOT_include_comments_here
```
- **Gitlab Tokens**: Your `.gitlab_tokens` must be properly indentated and formatted (**1** token **per line**). [Default: `$HOME/.config/.gitlab_tokens`]
```console
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
 -q,   --quota       Shows Usage Quota [https://github.com/the-valluvarsploit/APIkeyBeast] (Limited)
```
- Default :
> ```console
> aki
> ```
![default01](https://user-images.githubusercontent.com/58171889/235456875-5d5b2601-f26b-4406-860a-ca2bc3d0ef6a.png)
![default02](https://user-images.githubusercontent.com/58171889/235460893-20611677-18c8-463e-845a-c96aa6ad18b9.png)
![default03](https://user-images.githubusercontent.com/58171889/235460900-8c53f455-de8a-44ba-8d56-b839865f7b23.png)

- Quota Usage:
> ```console
> aki --quota
> ```
![usage01](https://user-images.githubusercontent.com/58171889/235455838-efbcaf9f-806f-4112-8830-58b1378c834c.png)
![usage02](https://user-images.githubusercontent.com/58171889/235455860-7878291c-525c-4fd0-b1d8-dc09c3961d22.png)

### Currently Checked Keys & Tokens:
 - [**Amass**](https://github.com/owasp-amass/amass/tree/master/resources/scripts/api) : Almost all **free** sources are checked and validated!
```yaml
ASNLookup : ✓
AlienVault : ✓
BeVigil : ✓
BigDataCloud : ✓
BinaryEdge : ✓
BuiltWith : ✓
Censys : ✓
CertCentral : ✓
Chaos : ✓
Cloudflare : ✓
Facebook : ✓
FullHunt : ✓
GitHub : ✓
GitLab : ✓
Hunter : ✓
IntelX : ✓
IPdata : ✓
IPinfo : ✓
LeakIX : ✓
Netlas : ✓
NetworksDB : ✓
ONYPHE : ✓
PassiveTotal : ✓
Pastebin : ✓
PublicWWW : ✓
Shodan : ✓
SecurityTrails : ✓
Spamhaus : ✓
Twitter : ✓
URLScan : ✓
VirusTotal : ✓
WhoisXML : ✓
Yandex : ✓
ZoomEye : ✓
```
 - [**BBot**](https://github.com/blacklanternsecurity/bbot/tree/stable/bbot/modules)
```yaml
AlienVault: + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/otx.py
AnubisDB(jldc.me) : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/anubisdb.py
BeVigil : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/bevigil.py
BinaryEdge : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/binaryedge.py
BuiltWith : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/builtwith.py
Censys.io : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/censys.py
CertSpotter.com : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/certspotter.py
Crobat : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/crobat.py
Crt.sh : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/crt.py
DnsDumpster.com : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/dnsdumpster.py
C99.nl - (✘) [💰 --> http://api.c99.nl/dashboard/shop] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/c99.py
FullHunt.io : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/fullhunt.py
GitHub : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/github.py
HackerTarget : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/hackertarget.py
Hunter.io : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/hunterio.py
IpStack.com : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/ipstack.py
LeakIX : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/leakix.py
PassiveTotal : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/passivetotal.py
RapidDNS.io : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/rapiddns.py
Riddler.io : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/riddler.py
SecurityTrails : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/securitytrails.py 
Shodan : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/shodan_dns.py
Skymem.info : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/skymem.py
ThreatMiner.org : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/threatminer.py
UrlScan.io : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/urlscan.py
ViewDNS.info : + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/viewdns.py
VirusTotal : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/virustotal.py)
WaybackArchive: + [api_key NOT Required] # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/wayback.py
ZoomeEyeApi : ? # https://github.com/blacklanternsecurity/bbot/blob/stable/bbot/modules/zoomeye.py
```
 - [**Subfinder**](https://github.com/projectdiscovery/subfinder/tree/main/v2/pkg/subscraping/sources) : Almost all **free** sources are checked and validated!
```yaml
anubis - (✘) [Not Available]
alienvault : ✓
bevigil : ✓
binaryedge : ✓
bufferover - (✘) [💰 --> https://rapidapi.com/projectxio/api/bufferover-run-tls/pricing]
chinaz - (✘) [Sketchy as F]
chaos : ✓
censys : ✓
certspotter : ✓
c99 - (✘) [💰 --> http://api.c99.nl/dashboard/shop]
fofa - ?
fullhunt : ✓
github : ✓
hunter : ✓
intelx : ✓
passivetotal : ✓
quake : ?
robotext: ?
securitytrails : ✓
threatbook  ?
shodan : ✓
urlscan : ✓
virustotal : ✓
whoisxmlapi : ✓
zoomeye : ✓
zoomeyeapi : ✓
```

---
### Verification:
- [**ASNLookup**](https://rapidapi.com/yaaboukir/api/asn-lookup) 
> 
```bash
curl -qsk "https://asn-lookup.p.rapidapi.com/api?asn=AS13414" -H "Host: asn-lookup.p.rapidapi.com" -H "X-Rapidapi-Host: asn-lookup.p.rapidapi.com" -H "X-Rapidapi-Key: $api_key" -H "Accept":"application/json"
```
- [**AlienVault**](https://otx.alienvault.com/api) 
> 
```bash
curl -qsk "https://otx.alienvault.com/api/v1/user/me" -H "X-OTX-API-KEY: $api_key" -H "Accept":"application/json"   
```
- [**BeVigil**](https://bevigil.com/osint-api/subdomains)  
```bash
curl -qsk "https://osint.bevigil.com/api/example.com/subdomains/" -H "X-Access-Token: $api_key" -H "Accept":"application/json"   
```  
- [**BigDataCloud**](https://www.bigdatacloud.com/docs/api/asn-short-info-api) 
```bash
curl -qsk "https://api-bdc.net/data/asn-info?asn=AS17501&localityLanguage=en&key=$api_key" -H "Accept":"application/json"   
```
- [**BinaryEdge**](https://docs.binaryedge.io/api-v2/) 
```bash
curl -qsk "https://api.binaryedge.io/v2/user/subscription" -H "X-Key: $api_key" -H "Accept":"application/json"   
```  
- [**BuiltWith**](https://api.builtwith.com/domain-api) 
```bash
curl -qsk "https://api.builtwith.com/usagev2/api.json&KEY=$api_key" -H "Accept":"application/json"   
```
- [**Censys**](https://search.censys.io/api) 
```bash
curl -qsk "https://search.censys.io/api/v1/account" -u "$apikey:$secret" -H "accept: application/json"
```
- [**CertCentral**](https://dev.digicert.com/en/certcentral-apis/services-api/users/user-info.html)
```bash
curl -qsk "https://www.digicert.com/services/v2/user" -H "Content-Type: application/json" -H "X-DC-DEVKEY: $api_key"
```
- [**CertSpotter**](https://sslmate.com/help/reference/ct_search_api_v1)
```bash
curl -qsk "https://api.certspotter.com/v1/issuances?domain=example.com" -H "Authorization: Bearer $api_key"
```
- [**Chaos**](https://chaos.projectdiscovery.io/#/docs)
```bash
curl -qsk "https://dns.projectdiscovery.io/dns/example.com/subdomains" -H "Authorization: $api_key" -H "Accept: application/json"
```
- [**Cloudflare**](https://developers.cloudflare.com/api/operations/accounts-list-accounts)
```bash
curl -qsk "https://api.cloudflare.com/client/v4/accounts" -H "Authorization: Bearer $api_key" -H "Content-Type: application/json" -H "Accept: application/json"
```
- [**Facebook**](https://developers.facebook.com/docs/facebook-login/guides/access-tokens#apptokens)
```bash
curl -qsk "https://graph.facebook.com/oauth/access_token?client_id=$apikey&client_secret=$secret&redirect_uri=&grant_type=client_credentials"
```
- [**FullHunt**](https://api-docs.fullhunt.io/#authentication)
```bash
curl -qsk "https://fullhunt.io/api/v1/auth/status" -H "X-API-KEY: $api_key" -H "Accept: application/json"
```
- [**GitHub**](https://docs.github.com/en/rest)
```bash
curl -qsk "https://api.github.com/user" -H "Authorization: Bearer $api_key" -H "Accept: application/vnd.github+json"
```
- [**GitLab**](https://docs.gitlab.com/ee/api/users.html)
```bash
curl -qsk "https://gitlab.com/api/v4/user" -H "PRIVATE-TOKEN: $api_key" -H "Accept: application/json"
```
- [**Hunter**](https://hunter.io/api-documentation/v2#account)
```bash
curl -qsk "https://api.hunter.io/v2/account?api_key=$api_key" -H "Accept: application/json"
```
- [**IntelX**](https://intelx.io/account?tab=developer)
```bash
curl -qsk "https://2.intelx.io/authenticate/info" "x-key:$api_key" -H "Accept: application/json" 
```
- [**IPdata**](https://docs.ipdata.co/docs/getting-started)
```bash
curl -qsk "https://api.ipdata.co/?api-key=$api_key" -H "Accept: application/json"
```
- [**IPinfo**](https://ipinfo.io/developers)
```bash
curl -qsk "https://ipinfo.io/me?token=$api_key" -H "Accept: application/json"
```
- [**Ipstack**](https://ipstack.com/documentation)
```bash
curl -qsk "http://api.ipstack.com/check?access_key=$api_access_key"
```
- [**LeakIX**](https://docs.leakix.net/docs/api/authentication/)
```bash
curl -qsk "https://leakix.net/domain/example.com" -H "api-key: $api_key" -H "Accept: application/json"
```
- [**Netlas**](https://netlas-api.readthedocs.io/en/latest/)
```bash
curl -qsk "https://app.netlas.io/api/users/current/" -H "X-Api-Key: $api_key" -H "Accept: application/json"
```
- [**NetworksDB**](https://networksdb.io/api/docs)
```bash
curl -qsk "https://networksdb.io/api/key" -H "X-Api-Key: $api_key" -H "Accept: application/json"
```
- [**PassiveTotal**](https://api.riskiq.net/api/pt_started.html)
```bash
curl -qsk "https://api.riskiq.net/pt/v2/account/quota" -H "Authorization: Basic $api_key" -H "Accept: application/json"
```
- [**Pastebin**](https://psbdmp.cc/api)
```bash
curl -qsk "https://psbdmp.ws/api/v3/dump/KF7hDTp1?key=$api_key"
```
- [**PublicWWW**](https://publicwww.com/profile/api)
```bash
curl -qsk "https://publicwww.com/profile/api_status.xml?key=$api_key"
```
- [**Quake**](https://quake.360.net/quake/#/help?id=5e77423bcb9954d2f8a01656&title=%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E)
```bash
curl -qsk "https://quake.360.net/api/v3/user/info" -H "X-QuakeToken: $api_key" -H "Accept: application/json"
```
- [**RoboTex**](https://www.robtex.com/api/)
```bash
curl -qsk "https://freeapi.robtex.com/ipquery/1.1.1.1?key=$api_key" -H "Accept: application/json"
```
> In case timeouts:
> ```bash
> curl -qsk "https://proapi.robtex.com/ipquery/199.19.54.12?key=$api_key" -H "Accept: application/json"
> ```
- [**Shodan**](https://developer.shodan.io/api)
```bash
curl -qsk "https://api.shodan.io/account/profile?key=$api_key" -H "Accept: application/json"
```
> This has no rate limits: 
>  ```bash
>  curl -qsk "https://api.shodan.io/api-info?key=$api_key" -H "Accept: application/json"
>  ```
- [**SecurityTrails**](https://docs.securitytrails.com/reference/ping)
```bash
curl -qsk "https://api.securitytrails.com/v1/account/usage" -H "APIKEY:$api_key"
```
- [**Spamhaus**](https://docs.spamhaus.com/extended-data/docs/source/02-availability/current/110-API.html)
```bash
curl -qsk "https://api.spamhaus.org/api/v1/login" -d '{"username":"$email_in_lowercase", "password":"$password", "realm":"intel"}' -H "Content-Type: application/json" -H "Accept: application/json"
```
- [**URLScan**](https://urlscan.io/docs/api/)
```bash
curl -qsk "https://urlscan.io/user/quotas/" -H "API-Key: $api_key" -H "Content-Type: application/json"
```
- [**Twitter**](https://developer.twitter.com/en/docs/authentication/oauth-2-0/bearer-tokens)
```bash
curl -u "$apikey:$secret" "https://api.twitter.com/oauth2/token" --data "grant_type=client_credentials" -H "Accept: application/json"
```
- [**VirusTotal**](https://developers.virustotal.com/reference/overview)
```bash
curl -qsk "https://www.virustotal.com/api/v3/ip_addresses/1.1.1.1" -H "x-apikey: $api_key" -H "Content-Type: application/json"
```
- [**WhoisXML**](https://whois.whoisxmlapi.com/documentation/balance-information)
```bash
curl -qsk "https://user.whoisxmlapi.com/user-service/account-balance?apiKey=$api_key" -H "Accept: application/json"
```
- [**WPScan**](https://wpscan.com/docs/api/v3)
```bash
curl -qsk "https://wpscan.com/api/v3/status" -H "Authorization: Token token=$WPSCAN_API_TOKEN" -H "Accept: application/json"
```
> You can use **`jq`** to directly convert the unix time
> ```bash
> curl -qsk "https://wpscan.com/api/v3/status" -H "Authorization: Token token=$WPSCAN_API_TOKEN" -H "Accept: application/json" | jq '. + { requests_reset: ( .requests_reset + (5*3600+45*60) ) | strftime("%Y-%m-%d||Time:%H:%M:%S") }'
> ```
- [**Yandex**](https://yandex.com/dev/xml/doc/dg/concepts/get-request.html)
```bash
curl -qsk "https://yandex.com/search/xml?user=$email_lowercase&key=$apikey&query=example"
```
> You might need to change permitted IP addresses : https://xml.yandex.com/settings/
- [**ZoomEye**](https://www.zoomeye.org/doc#authenticate)
```bash
curl -qsk "https://api.zoomeye.org/user/login" -H "Content-Type: application/json" -d '{"username":"$email_lowercased","password":"$password"}' -H "Accept: application/json"
```
- [**ZoomEyeAPI**](https://www.zoomeye.org/doc#authenticate)
```bash
curl -qsk "https://api.zoomeye.org/resources-info" -H "API-KEY:$api_key" -H "Accept: application/json"
```




