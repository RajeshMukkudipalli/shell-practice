#!/bin/bash



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

if [ $userid -ne 0 ]; then
    echo "You are not root user"
else
    echo "You are  root user"
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


File_to_delete=$(find $source_dir -name "*.log" -mtime +14)
while IFS= read -r file
do
    echo "Deleting file: $file"
    rm -rf "$file"
done <<< "$File_to_delete"

echo "Script successfully executed and deleted files older than 14 days" >> $log_file