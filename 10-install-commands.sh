#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
 then
    echo "you are not root user. Please run this script as root user"
    exit 1 
else
   echo "You are root user. Proceeding with installation commands"
fi

dnf list installed mysql

if [ $? -ne 0]
then
    echo "MySQL is not installed...proceeding with installation"
    dnf install mysql -y

    if [ $? -eq 0]
    then
        echo "MySQL istallation is successful"
    else
        echo "MYSQL Installation failed"
        exit 1
    fi
else
    echo "mySQL is already installed...nothing to do"
    
fi
    

