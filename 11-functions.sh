#! /bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]; then
    echo "You are not root user"
else
    echo "You are  root user"
fi
# this is a validation function
validate() {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Installing $2 is successful"
    else
        echo -e "\e[31m Installing $2 is failed"
        exit 1
    fi
}


dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "MySQL is not installed...proceeding with installation"
    dnf install mysql -y
    validate $? "MySQL"
else
    echo -e "\e[33m mySQL is already installed...nothing to do"
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo "MySQL is not installed...proceeding with installation"
    dnf install python3 -y
    validate $? "python3"
else
    echo -e " \e[33m python3 is already installed...nothing to do"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "MySQL is not installed...proceeding with installation"
    dnf install nginx -y
    validate $? "nginx"
else
    echo -e "\e[33m nginx is already installed...nothing to do"
fi