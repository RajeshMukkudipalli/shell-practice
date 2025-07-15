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