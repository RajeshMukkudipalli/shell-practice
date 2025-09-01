#!/bin/bash

source_dir =$1
backup_dir =$2
days=$(3:-14)
source_dir=/home/ec2-user/app-log
log_folder=/home/ec2-user/old-logs
script_name=$(echo $0 | cut  -d "." -f1)
log_file="$log_folder/$script_name-$(date +'%d-%m-%Y').log"
userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
mkdir -p $log_folder

if [ $userid -ne 0 ] 
then
    echo "You are not root user"
else
    echo "You are  root user"
fi

usage(){

    echo -e "$R sh back-up.sh <source_directory> <backup_directory> <days>$N"
}

if [ $# -lt 2 ]; then
    usage
    exit 1
fi
# this is a validation function
validate() {
    if [ $1 -eq 0 ]; then
        echo -e "$G Installing $2 is successful"
    else
        echo -e "$R Installing $2 is failed"
        exit 1
    fi
}