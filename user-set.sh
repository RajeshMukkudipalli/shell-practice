#! /bin/bash

set -e

failure(){
    echo "Failed at line no $1 with exit code $2"
}

trap 'failure "${LINENO}" "${BASH_COMMAND}"' ERR

Start_time=$(date +%s)
userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
Logs="/var/log/roboshop-logs"
script_name=$(echo $0 | cut -d   '.' -f1)
logfile="$Logs/$script_name-$(date +%F).log"
script_dir=$(pwd)

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
        echo -e "$G $2 is successful" | tee -a $logfile
    else
        echo -e "$R  $2 is failed"
        exit 1
    fi
}

dnf module disable nodejs -y &&>>$logfile


dnf module enable nodejs:20 -y &&>>$logfile


dnf install nodejs -y &&>>$logfile


id roboshopp
if [ $? -ne 0 ]
then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    
else
    echo -e "roboshop user already exists"
fi

mkdir  /app


curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip 

rm -rf /app/* &&>>$logfile
cd /app

unzip /tmp/user.zip


npm install &&>>$logfile


cp $script_dir/user.service /etc/systemd/system/user.service


systemctl daemon-reload &&>>$logfile


systemctl enable user &&>>$logfile
  

systemctl start user &&>>$logfile


End_time=$(date +%s)
Total_time=$(($End_time - $Start_time))
echo -e "$Y Total time took to execute the script: $Total_time seconds $N" | tee -a $logfile
