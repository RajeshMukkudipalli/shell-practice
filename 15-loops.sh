#!/bin/bash
# This script demonstrates the use of loops in bash 
# to iterate over a list of items and perform actions.
# Define an array of items
items=("mysql" "python3" "nginx")
# Function to validate installation
validate() {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Installing $2 is successful"
    else
        echo -e "\e[31m Installing $2 is failed"
        exit 1
    fi
}
# Check if the user is root
userid=$(id -u) 

if [ $userid -ne 0 ]; then
    echo "You are not root user"
    exit 1
else
    echo "You are root user"
fi
# Loop through each item in the array  
for item in "${items[@]}"; do
    dnf list installed $item
    if [ $? -ne 0 ]; then
        echo "$item is not installed...proceeding with installation"
        dnf install $item -y
        validate $? "$item"
    else
        echo -e "\e[33m $item is already installed...nothing to do"
    fi
done