#!/bin/bash
#Simple linux box enumeration
#by Jose Oregon

file=check_scan.txt
file2=enum_results.txt

echo "Enter the IP range to scan in CIDR:"
read ScanRange

echo "Enter the first port to scan:"
read FirstPort

echo "Enter the last port to scan:"
read LastPort

nmap -sT $ScanRange -p $FirstPort-$LastPort | grep -i -e "for" -e "open" > $file
cat $file > $file2

check_status(){
if grep "open" $file
then
   echo "Found open ports"
else 
   echo "" > $file2
   echo "Scan completed no open ports" > $file2
 fi
}

simple_enum(){
  echo "--------Whoami results-------------------"
  whoami
  echo -e ' \t '
  echo "----------ARP results--------------------"
  arp -a
  echo -e ' \t '
  echo "-----------OS results--------------------"
  cat /etc/os-release
  echo -e ' \t '
  echo "------------Sudo-------------------------"
  sudo -l
  echo -e ' \t '
  echo "-------------ip a results-----------------"
  echo ip a
  echo -e ' \t '
  echo "------------Routes------------------------"
  route
  echo -e ' \t '
}

check_status
simple_enum >> $file2

echo "Scanning.."
echo -e ' \t '
rm $file
cat $file2
echo -e ' \t '
echo "Scan saved to enum_results.txt"
                                         