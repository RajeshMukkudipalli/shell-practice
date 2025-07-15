#! /bin/bash

userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

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


dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "MySQL is not installed...proceeding with installation"
    dnf install mysql -y
    validate $? "MySQL"
else
    echo -e "$Y mySQL is already installed...nothing to do"
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo -e " $N MySQL is not installed...proceeding with installation"
    dnf install python3 -y
    validate $? "python3"
else
    echo -e " $Y python3 is already installed...nothing to do"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "MySQL is not installed...proceeding with installation"
    dnf install nginx -y
    validate $? "nginx"
else
    echo -e "$Y nginx is already installed...nothing to do"
fi