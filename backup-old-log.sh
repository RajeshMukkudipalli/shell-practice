#!/bin/bash

source_dir=$1
backup_dir=$2
days=${3:-14}

source_dir=/home/ec2-user/app-log
log_folder=/home/ec2-user/old-logs
script_name=$(basename "$0" | cut -d "." -f1)
log_file="$log_folder/$script_name-$(date +'%d-%m-%Y').log"

userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p "$log_folder"

# Check user
if [ "$userid" -ne 0 ]; then
    echo -e "${R}You are not root user${N}"
else
    echo -e "${G}You are root user${N}"
fi

validate() {
    if [ $1 -eq 0 ]; then
        echo -e "$G Installing $2 is successful $N"
    else
        echo -e "$R Installing $2 failed $N"
        exit 1
    fi
}

usage() {
    echo -e "$R Usage: sh back-up.sh <source_directory> <backup_directory> <days>$N"
}

# Validate arguments
if [ $# -lt 2 ]; then
    usage
    exit 1
fi

# Validate directories
if [ ! -d "$source_dir" ]; then
    echo -e "$R Source directory $source_dir does not exist $N"
    usage
    exit 1
fi

if [ ! -d "$backup_dir" ]; then
    echo -e "$R Backup directory $backup_dir does not exist $N"
    usage
    exit 1
fi

# Find old log files
File=$(find "$source_dir" -name "*.log" -mtime +"$days")

if [ -n "$File" ]; then
    echo "Files found to be zipped: $File"
    timestamp=$(date +%F-%H-%M-%S)
    Zip_file="$backup_dir/log-backup-$timestamp.zip"
    find $source_dir -name "*.log" -mtime +"$days" | zip -@ "$Zip_file"

    echo "$File" | zip "$Zip_file" -@

    if [ -f "$Zip_file" ]; then
        echo -e "$G Backup successful: $Zip_file $N"
        while IFS= read -r file; do
            echo "Deleting file: $file"
            rm -f "$file"
        done <<< "$File"
        echo -e "Log files older than $days days deleted from $source_dir... ${G}SUCCESS${N}"
    else
        echo -e "$R Backup failed $N"
    fi
else
    echo -e "No log files older than $days days... ${Y}Skipping backup${N}"
fi
