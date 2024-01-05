#!/bin/bash

#enter greppable nmap scan
grep 445/open $1 | cut -d " " -f 2 > smbhosts.txt

for host in $(cat smbhosts.txt); do nmap --script=smb-enum-shares.nse; done

#adding more nse scripts + other enumeration...
