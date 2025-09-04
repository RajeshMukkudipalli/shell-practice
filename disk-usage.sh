#!/bin/bash

Disk_usage=$(df -hT | grep -v Filesystem)
disk_threshold=1
Msg=""
IP=$(hostname -I | awk '{print $1}')
echo "Disk Usage on Server - $IP"

while IFS= read -r line
do 
    usage=$(echo $line | awk '{print $6F}' | cut -d "'%" -f1)
    partition=$(echo $line | awk '{print $7F}')
    echo " $partition : $usage"
    if [ $usage -ge $disk_threshold ]
    then
        Msg+="High Disk usage on $partition is ${usage}% <br>"
    fi
done <<< "$Disk_usage"

#echo $Msg
sh mail.sh "DevOps Team" "High Disk Alert" "$IP" "$Msg" "mrajesh0525@gmail.com" "Alert: High Disk Usage"