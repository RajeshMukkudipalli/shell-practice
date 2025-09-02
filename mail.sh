#!/bin/bash

To_team=$1
Alert_type=$2
IP_address=$3
Msg=$4
Final_msg=$(printf '%s\n' "$Msg" | sed -e 's/\\n/<br>/g')
To_address=$5

{
    echo "To = $To_team"
    echo "subject= $subject"
    echo "content-Tyee= text/html"
    echo ""
    echo "$email_body"
    echo ""
} | msmtp  "$To_team"