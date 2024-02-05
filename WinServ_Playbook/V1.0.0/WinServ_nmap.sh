#!/bin/sh

cd /usr/share/scripts/output

start_time=$(date +%s)
nmap_output="nmap_vulns_$start_time.txt"

sudo nmap -sV -oN "$nmap_output" --script vulners 192.168.1.3

awk '/vulners:/,/^[0-9]+\/[a-zA-Z]+/ {if (!/^[0-9]+\/[a-zA-Z]+/) print $0}' "$nmap_output" > "temp_awk_output.txt"

mv -f "temp_awk_output.txt" "$nmap_output"

curl -F "chat_id=6680816225" \
     -F "document=@$nmap_output" \
     -F "disable_notification=true" \
     -F "caption=Nmap Vulnerability Scan Results" \
     "https://api.telegram.org/bot6964667296:AAF8Bv8XibWEPeQ4CQCL5htOfEVJTrffhHs/sendDocument"