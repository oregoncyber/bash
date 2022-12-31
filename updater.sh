#!/bin/bash

#Script to update common linux distros
#By Jose Oregon

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_errors.log
now=$(date)

check_exit_status() {
 if [ $? -eq 0 ]
 then
     echo "^---------$now----------^" >> $logfile #makes logs more readable
     echo "                         " >> $logfile
     echo "Updating Complete"
     exit
 else
     echo "^----------$now----------^" >> $errorlog
     echo "                          " >> $errorlog
     echo "An error has occured please check $errorlog file"
 fi
}

if grep -q -i "Arch" $release_file
then
   echo "Updater is running..."
   echo "Check updater.log for status"
   sleep 5
   clear
   # The host is based on Arch, run the pacman update command
   sudo pacman -Syu 1>>$logfile 2>>$errorlog
   check_exit_status
fi

if grep -q -i "Ubuntu" $release_file || grep -q -i "Debian" $release_file
then
   echo "Updater is running..."
   echo "Check updater.log for status"
   # The host is based on Debian or Ubuntu
   # Run the apt version of the command
   sudo apt update 1>>$logfile 2>>$errorlog
   sudo apt dist-upgrade -y 1>>$logfile 2>>$errorlog
   check_exit_status
fi
