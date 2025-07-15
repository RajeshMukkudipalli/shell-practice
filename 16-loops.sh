#! /bin/bash

userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
Logs="/var/log/shellscript-logs"
script_name=$(echo $0 | cut -d   '.' -f1)
logfile="$Logs/$script_name-$(date +%F).log"
packages=("mysql" "python3" "nginx")

mkdir -p $Logs
echo "Script started at: $(date)" &>> $logfile

if [ $userid -ne 0 ]; then
    echo "You are not root user"
else
    echo "You are  root user"
fi
# this is a validation function
validate() {
    if [ $1 -eq 0 ]; then
        echo -e "$G Installing $2 is successful" | tee -a $logfile
    else
        echo -e "$R Installing $2 is failed"
        exit 1
    fi
}

for package in "${packages[@]}" 
do
    dnf list installed $package &>> $logfile
    if [ $? -ne 0 ]; then
        echo "$package is not installed...proceeding with installation" | tee -a $logfile
        dnf install $package -y
        validate $? "$package"
    else
        echo -e "$Y $package is already installed...nothing to do" | tee -a $logfile
    fi
done